/**
 * Copyright 2010-present Facebook.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.sith.login;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.app.AlertDialog;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Typeface;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentActivity;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.facebook.FacebookAuthorizationException;
import com.facebook.FacebookOperationCanceledException;
import com.facebook.FacebookRequestError;
import com.facebook.Request;
import com.facebook.Response;
import com.facebook.Session;
import com.facebook.SessionState;
import com.facebook.UiLifecycleHelper;
import com.facebook.model.GraphObject;
import com.facebook.model.GraphUser;
import com.facebook.widget.LoginButton;
import com.facebook.widget.ProfilePictureView;
import com.sith.main.MainActivity;
import com.sith.main.R;
import com.sith.main.SithAPI;
import com.sith.main.SithApplication;
import com.sith.main.util.AsyncHTTPHandler;

public class FBLoginActivity extends FragmentActivity {

	private final String PENDING_ACTION_BUNDLE_KEY = "com.facebook.samples.hellofacebook:PendingAction";

	private LoginButton loginButton;
	private ProfilePictureView profilePictureViewFB;
	private TextView greeting;
	private PendingAction pendingAction = PendingAction.NONE;
	private ViewGroup controlsContainer;
	private GraphUser user;

	private static final int LOGINMETHOD = 0;
	private static final int PROFILE = 1;
	private Fragment[] fragments = new Fragment[2];

	private boolean isConnect;

	private String redirectState;

	private enum PendingAction {
		NONE, POST_PHOTO, POST_STATUS_UPDATE
	}

	private UiLifecycleHelper uiHelper;

	private Session.StatusCallback callback = new Session.StatusCallback() {

		public void call(Session session, SessionState state,
				Exception exception) {
			onSessionStateChange(session, state, exception);
		}
	};

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		getActionBar().setDisplayHomeAsUpEnabled(true);

		// redirectState=getIntent().getExtras().getString("riderect_state");
		isConnect = getIntent().getExtras().getBoolean("isConnect");

		uiHelper = new UiLifecycleHelper(this, callback);
		uiHelper.onCreate(savedInstanceState);

		if (savedInstanceState != null) {
			String name = savedInstanceState
					.getString(PENDING_ACTION_BUNDLE_KEY);
			pendingAction = PendingAction.valueOf(name);
		}

		setContentView(R.layout.login);

		FragmentManager fm1 = getSupportFragmentManager();
		fragments[LOGINMETHOD] = fm1.findFragmentById(R.id.loginMethodFragment);
		fragments[PROFILE] = fm1.findFragmentById(R.id.profileFragment);

		FragmentTransaction transaction = fm1.beginTransaction();
		for (int i = 0; i < fragments.length; i++) {
			transaction.hide(fragments[i]);
		}
		transaction.commit();

		loginButton = (LoginButton) findViewById(R.id.login_button);
		List<String> additionalPermissions = new ArrayList<String>();
		additionalPermissions.add("publish_stream");
		additionalPermissions.add("publish_actions");
		loginButton.setPublishPermissions(additionalPermissions);
		loginButton
				.setUserInfoChangedCallback(new LoginButton.UserInfoChangedCallback() {
					// @Override
					public void onUserInfoFetched(GraphUser user) {
						FBLoginActivity.this.user = user;
						updateUserInfo();
						// It's possible that we were waiting for this.user to
						// be populated in order to post a
						// status update.
						handlePendingAction();
					}
				});

		profilePictureViewFB = (ProfilePictureView) findViewById(R.id.profilePictureFB);
		greeting = (TextView) findViewById(R.id.greeting);

		controlsContainer = (ViewGroup) findViewById(R.id.main_ui_container);

		final FragmentManager fm = getSupportFragmentManager();
		Fragment fragment = fm.findFragmentById(R.id.fragment_container);
		if (fragment != null) {
			// If we're being re-created and have a fragment, we need to a) hide
			// the main UI controls and
			// b) hook up its listeners again.
			controlsContainer.setVisibility(View.GONE);

		}

		// Listen for changes in the back stack so we know if a fragment got
		// popped off because the user
		// clicked the back button.
		fm.addOnBackStackChangedListener(new FragmentManager.OnBackStackChangedListener() {
			// @Override
			public void onBackStackChanged() {
				if (fm.getBackStackEntryCount() == 0) {
					// We need to re-show our UI.
					controlsContainer.setVisibility(View.VISIBLE);
				}
			}
		});

		// Fonts
		Typeface tf = Typeface.createFromAsset(getAssets(),
				"fonts/Roboto-Medium.ttf");
		greeting.setTypeface(tf);
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		switch (item.getItemId()) {
		case android.R.id.home:
			startActivity(new Intent(this, MainActivity.class));
			return true;
		}
		return true;
	}

	@Override
	protected void onResume() {
		super.onResume();
		uiHelper.onResume();

	}

	@Override
	protected void onSaveInstanceState(Bundle outState) {
		super.onSaveInstanceState(outState);
		uiHelper.onSaveInstanceState(outState);

		outState.putString(PENDING_ACTION_BUNDLE_KEY, pendingAction.name());
	}

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		super.onActivityResult(requestCode, resultCode, data);
		uiHelper.onActivityResult(requestCode, resultCode, data);
	}

	@Override
	public void onPause() {
		super.onPause();
		uiHelper.onPause();
	}

	@Override
	public void onDestroy() {
		super.onDestroy();
		uiHelper.onDestroy();
	}

	private void onSessionStateChange(Session session, SessionState state,
			Exception exception) {
		if (pendingAction != PendingAction.NONE
				&& (exception instanceof FacebookOperationCanceledException || exception instanceof FacebookAuthorizationException)) {
			new AlertDialog.Builder(FBLoginActivity.this).setTitle("Cancelled")
					.setMessage("Permission not granted")
					.setPositiveButton("OK", null).show();
			pendingAction = PendingAction.NONE;
		} else if (state == SessionState.OPENED_TOKEN_UPDATED) {
			handlePendingAction();
		}
		updateUserInfo();

	}

	private void updateUserID(GraphUser user) {
		SharedPreferences pref = this.getSharedPreferences("SITH_PREF",
				Context.MODE_PRIVATE);
		SithApplication sithApplication = (SithApplication) getApplication();
		if (user != null) {

			if (!isConnect) {
				// TODO encrypt
				pref.edit().putString("userID", user.getUsername()).commit();
				pref.edit().putBoolean("isFB", true).commit();
				sithApplication.setUserID(user.getUsername());
				sithApplication.setFB(true);
				Map<String, String> paramets = new HashMap<String, String>();
				paramets.put("userID", user.getUsername());
				paramets.put("accessToken", "test");
				AsyncHTTPHandler asyncHTTPHandler = new AsyncHTTPHandler();
				try {
					asyncHTTPHandler.post(SithAPI.REGISTER_FB_USER, paramets);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			} else {
				// TODO implement
			}
			FBLoginActivity.this.setResult(45);

		} else {

			pref.edit().putString("userID", "none").commit();
			pref.edit().putBoolean("isFB", false).commit();
			sithApplication.setUserID("none");
			sithApplication.setFB(false);

		}
	}

	private void updateUserInfo() {
		Session session = Session.getActiveSession();

		if (session != null && session.isOpened()) {
			// if the session is already open, try to show the selection
			// fragment
			showFragment(PROFILE, false);
			populateProfileInfo(session);

		} else {
			// otherwise present the splash screen and ask the user to login.
			showFragment(LOGINMETHOD, false);
			updateUserID(null);
		}
		/*
		 * if(redirectState!=null && redirectState.equalsIgnoreCase("initial")){
		 * try { Thread.sleep(2000); } catch (InterruptedException e) { // TODO
		 * Auto-generated catch block e.printStackTrace(); } this.finish(); }
		 */
	}

	private void populateProfileInfo(Session session) {
		if (user == null) {
			return;
		}
		updateUserID(user);
		profilePictureViewFB.setProfileId(user.getId());
		greeting.setText(getString(R.string.hello_user, user.getFirstName()));

	}

	@SuppressWarnings("incomplete-switch")
	private void handlePendingAction() {
		PendingAction previouslyPendingAction = pendingAction;
		// These actions may re-set pendingAction if they are still pending, but
		// we assume they
		// will succeed.
		pendingAction = PendingAction.NONE;

		switch (previouslyPendingAction) {
		case POST_PHOTO:
			postPhoto();
			break;
		case POST_STATUS_UPDATE:
			postStatusUpdate();
			break;
		}
	}

	private interface GraphObjectWithId extends GraphObject {
		String getId();
	}

	private void showPublishResult(String message, GraphObject result,
			FacebookRequestError error) {
		String title = null;
		String alertMessage = null;
		if (error == null) {
			title = getString(R.string.success);
			String id = result.cast(GraphObjectWithId.class).getId();
			alertMessage = getString(R.string.successfully_posted_post,
					message, id);
		} else {
			title = getString(R.string.error);
			alertMessage = error.getErrorMessage();
		}

		new AlertDialog.Builder(this).setTitle(title).setMessage(alertMessage)
				.setPositiveButton(R.string.ok, null).show();
	}

	private void postStatusUpdate() {
		if (user != null && hasPublishPermission()) {
			final String message = getString(R.string.status_update,
					user.getFirstName(), (new Date().toString()));
			Request request = Request.newStatusUpdateRequest(
					Session.getActiveSession(), message,
					new Request.Callback() {
						// @Override
						public void onCompleted(Response response) {
							showPublishResult(message,
									response.getGraphObject(),
									response.getError());
						}
					});
			request.executeAsync();
		} else {
			pendingAction = PendingAction.POST_STATUS_UPDATE;
		}
	}

	private void postPhoto() {
		if (hasPublishPermission()) {
			Bitmap image = BitmapFactory.decodeResource(this.getResources(),
					R.drawable.icon);
			Request request = Request.newUploadPhotoRequest(
					Session.getActiveSession(), image, new Request.Callback() {
						// @Override
						public void onCompleted(Response response) {
							showPublishResult(getString(R.string.photo_post),
									response.getGraphObject(),
									response.getError());
						}
					});
			request.executeAsync();
		} else {
			pendingAction = PendingAction.POST_PHOTO;
		}
	}

	private boolean hasPublishPermission() {
		Session session = Session.getActiveSession();
		return session != null
				&& session.getPermissions().contains("publish_actions");
	}

	private void showFragment(int fragmentIndex, boolean addToBackStack) {
		FragmentManager fm = getSupportFragmentManager();
		FragmentTransaction transaction = fm.beginTransaction();
		for (int i = 0; i < fragments.length; i++) {
			if (i == fragmentIndex) {
				transaction.show(fragments[i]);
			} else {
				transaction.hide(fragments[i]);
			}
		}
		if (addToBackStack) {
			transaction.addToBackStack(null);
		}
		transaction.commit();
	}

	@Override
	protected void onResumeFragments() {
		super.onResumeFragments();
		Session session = Session.getActiveSession();

		if (session != null && session.isOpened()) {
			showFragment(PROFILE, false);
		} else {
			showFragment(LOGINMETHOD, false);
		}
	}
}
