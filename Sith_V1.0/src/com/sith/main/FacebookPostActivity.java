package com.sith.main;

import java.util.Arrays;
import java.util.Collection;
import java.util.List;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.facebook.FacebookRequestError;
import com.facebook.HttpMethod;
import com.facebook.Request;
import com.facebook.RequestAsyncTask;
import com.facebook.Response;
import com.facebook.Session;
import com.facebook.SessionState;
import com.sith.main.util.UIutil;
import com.sith.model.EmotionsModel;

public class FacebookPostActivity extends Activity {

	private static final List<String> PERMISSIONS = Arrays
			.asList("publish_actions");
	private EditText editTextComment;
	private SithApplication sithApplication;
	private String context;
	private ProgressDialog progress;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_facebook_post);

		setTitle("Share with Facebook friends");
		progress = new ProgressDialog(this);

		sithApplication = (SithApplication) getApplication();

		TextView mood = (TextView) findViewById(R.id.share_emotion_name);
		mood.setText(sithApplication.getCurrentFeeling());

		ImageView imageView = (ImageView) findViewById(R.id.imageView_emotion);
		imageView.setImageResource(EmotionsModel.getDawable(sithApplication
				.getCurrentFeeling()));

		TextView textViewContext = (TextView) findViewById(R.id.share_subcription_info);

		editTextComment = (EditText) findViewById(R.id.editText_FB_comment);
		if (sithApplication.getCurrentSubcription() != null) {
			textViewContext.setText("@ "
					+ sithApplication.getCurrentSubcription()
							.getSubscriptionName());
		} else {
			context = "No context ";
			textViewContext.setText(context);
		}
	}

	/*
	 * @Override public boolean onCreateOptionsMenu(Menu menu) { // Inflate the
	 * menu; this adds items to the action bar if it is present.
	 * getMenuInflater().inflate(R.menu.facebook_post, menu); return true; }
	 */

	public void onClickPost(View v) {
		Session session=getSession();
		if(session==null){
			showFBError();
		}
	}

	private Session.StatusCallback callback = new Session.StatusCallback() {

		public void call(Session session, SessionState state,
				Exception exception) {
			if (session.isOpened()) {
				publishStory(session);
			} else {
				showFBError();
			}
		}	
	};
	
	private void showFBError() {
		UIutil.showAlert(FacebookPostActivity.this,
				"Not connected to facebook.",
				"Connect your facebook account to enable sharing",
				new OnClickListener() {

					@Override
					public void onClick(DialogInterface arg0, int arg1) {
						FacebookPostActivity.this.finish();

					}
				});
	}

	public Session getSession() {
		return Session.openActiveSession(this, false, callback);
	}

	private void publishStory(Session session) {

		// Check for publish permissions
		List<String> permissions = session.getPermissions();
		if (!isSubsetOf(PERMISSIONS, permissions)) {
			Session.NewPermissionsRequest newPermissionsRequest = new Session.NewPermissionsRequest(
					this, PERMISSIONS);
			session.requestNewPublishPermissions(newPermissionsRequest);
			return;
		}

		Bundle postParams = new Bundle();
		String comment = editTextComment.getText().toString();
		postParams.putString("message", comment);
		postParams.putString("name",
				"I am " + sithApplication.getCurrentFeeling());
		postParams.putString("caption", "@ " + sithApplication.getCurrentSubcription().getSubscriptionName());
		postParams.putString("description", "Expressed via Sith Platform");
		// postParams.putString("link",
		// "https://developers.facebook.com/android");
		postParams.putString("picture",
				EmotionsModel.getImageURL(sithApplication.getCurrentFeeling()));

		Request.Callback callback = new Request.Callback() {
			public void onCompleted(Response response) {
				progress.dismiss();
				FacebookRequestError error = response.getError();
				if (error != null) {
					UIutil.showExceptionAlert(FacebookPostActivity.this,
							new Exception(error.getErrorMessage()));
				} else {
					Toast.makeText(FacebookPostActivity.this,
							"Successflly posted to your timeline.",
							Toast.LENGTH_SHORT).show();
					FacebookPostActivity.this.finish();
				}
			}
		};

		Request request = new Request(session, "me/feed", postParams,
				HttpMethod.POST, callback);

		progress.setTitle("Posting to Facebook.");
		progress.setMessage("Please wait....");
		progress.show();

		RequestAsyncTask task = new RequestAsyncTask(request);
		task.execute();

	}

	private boolean isSubsetOf(Collection<String> subset,
			Collection<String> superset) {
		for (String string : subset) {
			if (!superset.contains(string)) {
				return false;
			}
		}
		return true;
	}

}
