package com.sith.main;

import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONException;

import android.app.ActionBar;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.PendingIntent;
import android.app.ProgressDialog;
import android.appwidget.AppWidgetManager;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.Signature;
import android.graphics.Typeface;
import android.graphics.drawable.Drawable;
import android.location.Location;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Bundle;
import android.util.Base64;
import android.util.Log;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.TextView;
import android.widget.Toast;

import com.carousel.controls.Carousel;
import com.carousel.controls.CarouselAdapter;
import com.carousel.controls.CarouselAdapter.OnItemClickListener;
import com.carousel.controls.CarouselAdapter.OnItemSelectedListener;
import com.carousel.controls.CarouselItem;
import com.carousel.controls.ImageAdapter;
import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GooglePlayServicesClient;
import com.google.android.gms.common.GooglePlayServicesUtil;
import com.google.android.gms.location.LocationClient;
import com.google.android.gms.location.LocationListener;
import com.google.android.gms.location.LocationRequest;
import com.loopj.android.http.AsyncHttpClient;
import com.loopj.android.http.AsyncHttpResponseHandler;
import com.loopj.android.http.RequestParams;
import com.sith.dashbord.DashbordActivity;
import com.sith.location.LocationService;
import com.sith.login.FBLoginActivity;
import com.sith.login.SithLoginActivity;
import com.sith.login.SithProfileActivity;
import com.sith.main.util.AsyncHTTPHandler;
import com.sith.main.util.UIutil;
import com.sith.model.EmotionsModel;
import com.sith.model.Event;
import com.sith.model.Parser;
import com.sith.model.Subscription;
import com.slidingmenu.lib.SlidingMenu;

public class MainActivity extends Activity implements
		GooglePlayServicesClient.ConnectionCallbacks,
		GooglePlayServicesClient.OnConnectionFailedListener, LocationListener {

	private ArrayList<Subscription> subscriptions = new ArrayList<Subscription>();
	private List<String> subscriptionIDs = new ArrayList<String>();
	private List<String> moods = new ArrayList<String>();

	private SithApplication sithApplication;

	private AsyncHttpClient client = new AsyncHttpClient();

	// Sliding Drawer
	private SlidingMenu menu;

	private AsyncHTTPHandler httpHandler = new AsyncHTTPHandler();

	private Carousel carousel;

	private SharedPreferences pref;
	private ProgressDialog progress;
	private boolean firstLaunch = true;

	private LocationClient locationclient;
	private LocationRequest locationrequest;
	private Intent mIntentService;
	private PendingIntent mPendingIntent;

	/** Called when the activity is first created. */
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main);

		if (GooglePlayServicesUtil.isGooglePlayServicesAvailable(this) == ConnectionResult.SUCCESS) {
			initializeLocationClient();
		} else {
			UIutil.showAlert(this, "Error",
					"This application needs Google play services to work well.");
		}

		sithApplication = (SithApplication) this.getApplication();

		pref = this.getSharedPreferences("SITH_PREF", Context.MODE_PRIVATE);
		sithApplication.setUserID(pref.getString("userID", "none"));
		sithApplication.setFB(pref.getBoolean("isFB", false));

		progress = new ProgressDialog(this);

		// pref = this.getSharedPreferences("SITH_PREF", Context.MODE_PRIVATE);
		// pref.edit().commit();

//		try {
//			PackageInfo info = getPackageManager().getPackageInfo(
//					"com.sith.main", PackageManager.GET_SIGNATURES);
//			for (Signature signature : info.signatures) {
//				MessageDigest md = MessageDigest.getInstance("SHA");
//				md.update(signature.toByteArray());
//				Log.d("KeyHash:","hash "+
//						Base64.encodeToString(md.digest(), Base64.DEFAULT));
//			}
//		} catch (Exception e) {			
//		}

		init();

		// Fonts
		TextView status = (TextView) findViewById(R.id.selected_item);
		Typeface tf = Typeface.createFromAsset(getAssets(),
				"fonts/Roboto-Condensed.ttf");
		status.setTypeface(tf);

		// gets the activity's default ActionBar
		ActionBar actionBar = getActionBar();
		actionBar.setNavigationMode(ActionBar.NAVIGATION_MODE_LIST);

		populateActionbar(actionBar);
		actionBar.setDisplayOptions(ActionBar.DISPLAY_SHOW_HOME);
		actionBar.setDisplayHomeAsUpEnabled(true);
		actionBar.show();

		menu = new SlidingMenu(this);
		menu.setMode(SlidingMenu.LEFT);
		menu.setTouchModeAbove(SlidingMenu.TOUCHMODE_FULLSCREEN);
		menu.setShadowWidth(5);
		menu.setFadeDegree(0.0f);
		menu.attachToActivity(this, SlidingMenu.SLIDING_CONTENT);
		menu.setBehindWidth((UIutil.getScreenWidth(getWindowManager()) / 5) * 3);
		menu.setMenu(R.layout.menu_frame);

		carousel = (Carousel) findViewById(R.id.carousel);
		carousel.setOnItemClickListener(new OnItemClickListener() {

			public void onItemClick(CarouselAdapter<?> parent, View view,
					int position, long id) {
				Toast.makeText(
						MainActivity.this,
						String.format("I Am %s.", ((CarouselItem) parent
								.getChildAt(position)).getName()),
						Toast.LENGTH_SHORT).show();

				String s = handlePerception(position);
				sithApplication.setCurrentFeeling(s);

				final TextView txt = (TextView) (findViewById(R.id.selected_item));
				txt.setText(s);
				updateWidget();

				sendStatus(s);
			}
		});

		carousel.setOnItemSelectedListener(new OnItemSelectedListener() {

			public void onItemSelected(CarouselAdapter<?> parent, View view,
					int position, long id) {
			}

			public void onNothingSelected(CarouselAdapter<?> parent) {
			}

		});

		if (!isOnline()) {
			try {
				AlertDialog alertDialog = new AlertDialog.Builder(this)
						.create();

				alertDialog.setTitle("Info");
				alertDialog
						.setMessage("Internet not available, Cross check your internet connectivity and try again");
				// alertDialog.setIcon(R.drawable.alerticon);
				alertDialog.setButton("OK",
						new DialogInterface.OnClickListener() {
							public void onClick(DialogInterface dialog,
									int which) {
								finish();

							}
						});

				alertDialog.show();
			} catch (Exception e) {
				// TODO handle
			}

		} else {// Redirect to login
			checkLoginStatus();
		}

	}

	private void checkLoginStatus() {
		if (sithApplication.getUserID() == null
				|| sithApplication.getUserID().equalsIgnoreCase("none")) {
			Toast.makeText(getBaseContext(), "Please Login", Toast.LENGTH_LONG)
					.show();
			Intent intent = new Intent(MainActivity.this,
					SithLoginActivity.class);
			MainActivity.this.startActivity(intent);
		}
	}

	private void updateCarousal(List<String> moods) {
		ImageAdapter adapter = new ImageAdapter(this);

		Drawable[] images = new Drawable[moods.size()];
		String[] names = new String[moods.size()];

		for (int i = 0; i < moods.size(); i++) {
			images[i] = getResources().getDrawable(
					EmotionsModel.getDawable(moods.get(i)));
			names[i] = moods.get(i);
		}

		adapter.SetImages(images, names, true);
		carousel.setAdapter(adapter);
		carousel.setSelection(0);

	}

	private String handlePerception(int position) {
		return moods.get(position);
	}

	private void populateActionbar(ActionBar actionBar) {
		if (actionBar == null) {
			actionBar = getActionBar();
		}
		String[] subscriptionsArray = new String[subscriptions.size() + 1];
		subscriptionsArray[0] = "No Context";

		for (int i = 0; i < subscriptions.size(); i++) {
			subscriptionsArray[i + 1] = subscriptions.get(i)
					.getSubscriptionName();
		}

		/** Create an array adapter to populate dropdownlist */
		ArrayAdapter<String> adapter = new ArrayAdapter<String>(
				getBaseContext(),
				android.R.layout.simple_spinner_dropdown_item,
				subscriptionsArray);

		/** Defining Navigation listener */
		ActionBar.OnNavigationListener navigationListener = new ActionBar.OnNavigationListener() {
			public boolean onNavigationItemSelected(int itemPosition,
					long itemId) {

				if (itemPosition == 0) {
					sithApplication.setCurrentSubcription(null);
					if (firstLaunch) {
						firstLaunch = false;
					} else {
						Toast.makeText(getBaseContext(),
								"You selected : None ", Toast.LENGTH_SHORT)
								.show();
					}
					onSubscriptionChanged(-1);
				} else {
					sithApplication.setCurrentSubcription(subscriptions
							.get(itemPosition - 1));
					Toast.makeText(
							getBaseContext(),
							"You selected : "
									+ subscriptions.get(itemPosition - 1)
											.getSubscriptionName(),
							Toast.LENGTH_SHORT).show();
					onSubscriptionChanged(itemPosition - 1);
				}
				return false;
			}
		};

		/**
		 * Setting dropdown items and item navigation listener for the actionbar
		 */
		actionBar.setListNavigationCallbacks(adapter, navigationListener);
	}

	private void onSubscriptionChanged(int position) {
		if (position == -1) {
			updateCarousal(EmotionsModel.getDefaultModel());
			moods = EmotionsModel.getDefaultModel();
			Toast.makeText(getBaseContext(), "You selected : None",
					Toast.LENGTH_SHORT).show();
			return;
		}
		updateCarousal(subscriptions.get(position).getMoods());
		moods = subscriptions.get(position).getMoods();
		Toast.makeText(
				getBaseContext(),
				"You selected : "
						+ subscriptions.get(position).getSubscriptionName(),
				Toast.LENGTH_SHORT).show();

	}

	// Intialize user data
	private void init() {
		getActiveSubscriptions();

	}

	private void getSubscriptionInfo() {
		RequestParams requestParams = null;
		for (int i = 0; i < subscriptionIDs.size(); i++) {
			requestParams = new RequestParams();
			requestParams.put("eventID", subscriptionIDs.get(i));
			client.get(SithAPI.GET_SUBSCRIPTION_BY_ID, requestParams,
					new AsyncHttpResponseHandler() {

						@Override
						public void onStart() {
							super.onStart();
						};

						@Override
						public void onSuccess(String response) {
							try {
								if (!response.equalsIgnoreCase("null")) {
									subscriptions.add(Parser
											.parseSubscription(response));
								}else{
									subscriptions.add(new Event());
								}							
							} catch (JSONException e) {
								// TODO
								progress.dismiss();
								UIutil.showExceptionAlert(MainActivity.this, e);
							}
						}

						@Override
						public void onFinish() {
							super.onFinish();
							if (subscriptions.size() == subscriptionIDs.size()) {
								populateActionbar(null);
								sithApplication.setSubscriptions(subscriptions);
								progress.dismiss();
							}
						}
					});
		}
		progress.dismiss();
	}

	private void getActiveSubscriptions() {
		RequestParams requestParams = new RequestParams();

		if (sithApplication.getUserID() == null
				|| sithApplication.getUserID().equalsIgnoreCase("none")) {
			return;
		}

		requestParams.put("userID", sithApplication.getUserID());
		client.get(SithAPI.GET_ACTIVE_SUBSCRIPTIONS, requestParams,
				new AsyncHttpResponseHandler() {

					@Override
					public void onStart() {
						super.onStart();
						progress.setTitle("Loading");
						progress.setMessage("Downloading information....");
						progress.show();
					};

					@Override
					public void onSuccess(String response) {
						try {
							subscriptionIDs = Parser.parseList(response,
									"eventID");
						} catch (JSONException e) {
							// TODO
							progress.dismiss();
							UIutil.showExceptionAlert(MainActivity.this, e);
						}
					}

					@Override
					public void onFinish() {

						super.onFinish();
						sithApplication.setSubscriptionIDs(subscriptionIDs);
						getSubscriptionInfo();
					}
				});

	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		MenuInflater inflater = getMenuInflater();
		inflater.inflate(R.menu.menu, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		Intent myIntent = null;
		switch (item.getItemId()) {
		case R.id.itemAdd:
			myIntent = new Intent(MainActivity.this,
					SubscriptionsListActivity.class);
			MainActivity.this.startActivity(myIntent);
			return true;
		case R.id.itemDashboard:
//			UIutil.showAlert(MainActivity.this, "Not available",
//					"Currently this feature has disabled by admins");
			 myIntent = new Intent(MainActivity.this, DashbordActivity.class);
			 MainActivity.this.startActivity(myIntent);
			return true;
		case android.R.id.home:
			menu.toggle();
			return true;
		}
		return true;
	}

	@Override
	protected void onRestart() {
		super.onRestart();
		checkLoginStatus();
		populateActionbar(null);
		if (sithApplication.currentSubcription == null) {
			onSubscriptionChanged(-1);
		} else {
			int i = 0;
			for (; i < subscriptions.size(); i++) {
				String s = subscriptions.get(i).getSubscriptionID();
				String s1 = sithApplication.currentSubcription
						.getSubscriptionID();
				if (s.equals(s1)) {
					break;
				}
			}
			getActionBar().setSelectedNavigationItem(i + 1);
		}
	}

	public void onClickProfile(View v) {
		if (!sithApplication.isFB) {
			Intent intent = new Intent(MainActivity.this,
					SithProfileActivity.class);
			MainActivity.this.startActivity(intent);
		} else {
			Intent intent = new Intent(MainActivity.this, FBLoginActivity.class);
			intent.putExtra("isConnect", true);
			MainActivity.this.startActivity(intent);
		}
	}

	public void onClickHelp(View v) {
		MainActivity.this.startActivity(new Intent(MainActivity.this,
				HelpActivity.class));
	}

	public void onClickSettings(View v) {
		MainActivity.this.startActivity(new Intent(MainActivity.this,
				SettingsActivity.class));
	}

	public void onFBShareClick(View v) {
		if (sithApplication.getCurrentFeeling() == null) {
			Toast.makeText(getBaseContext(), "Select your feeling first",
					Toast.LENGTH_SHORT).show();
			return;
		}
		String user = sithApplication.getUserID();
		if (user == null || user.equalsIgnoreCase("none")) {
			Toast.makeText(getBaseContext(), "Please Login", Toast.LENGTH_LONG)
					.show();
			MainActivity.this.startActivity(new Intent(MainActivity.this,
					FBLoginActivity.class));
		}
		Intent intent = new Intent(MainActivity.this,
				FacebookPostActivity.class);
		MainActivity.this.startActivity(intent);
	}

	public void sendStatus(String s) {
		Map<String, String> parameters = new HashMap<String, String>();
		String user = sithApplication.getUserID();
		if (user != null && !user.equalsIgnoreCase("none")) {
			parameters.put("userID", user);
		} else {
			Toast.makeText(getBaseContext(), "Please Login", Toast.LENGTH_LONG)
					.show();
			MainActivity.this.startActivity(new Intent(MainActivity.this,
					FBLoginActivity.class));
		}
		if (sithApplication.getCurrentSubcription() != null) {
			parameters.put("eventID", sithApplication.getCurrentSubcription()
					.getSubscriptionID());
		} else {
			parameters.put("eventID", "none");
		}

		parameters.put("perceptionValue", s);
		if (sithApplication.getLocation() != null) {
			parameters
					.put("lat", String.valueOf(sithApplication.getLocation()
							.getLatitude()));
			parameters.put("lng", String.valueOf(sithApplication.getLocation()
					.getLongitude()));
		}

		if (sithApplication.getLocation() != null) {
			parameters.put("locationName", sithApplication.getLocationName());
		}

		try {
			httpHandler.post(SithAPI.EVENT_STATUS_POST, parameters);
		} catch (Exception e) {
			Log.e("POST error", e.toString());
		}
	}

	public boolean isOnline() {
		ConnectivityManager conMgr = (ConnectivityManager) getApplicationContext()
				.getSystemService(Context.CONNECTIVITY_SERVICE);
		NetworkInfo netInfo = conMgr.getActiveNetworkInfo();

		if (netInfo == null || !netInfo.isConnected() || !netInfo.isAvailable()) {
			return false;
		}
		return true;
	}

	private void updateWidget() {
		Intent intent = new Intent(this, SithWidgetProvider.class);
		intent.setAction("android.appwidget.action.APPWIDGET_UPDATE");
		// Use an array and EXTRA_APPWIDGET_IDS instead of
		// AppWidgetManager.EXTRA_APPWIDGET_ID,
		// since it seems the onUpdate() is only fired on that:
		int[] ids = { R.xml.sith_widget_provider };
		intent.putExtra(AppWidgetManager.EXTRA_APPWIDGET_IDS, ids);
		intent.putExtra("currentFeeling", sithApplication.getCurrentFeeling());
		sendBroadcast(intent);
	}

	private void initializeLocationClient() {

		locationclient = new LocationClient(this, this, this);
		locationclient.connect();

		mIntentService = new Intent(this, LocationService.class);
		mPendingIntent = PendingIntent.getService(this, 1, mIntentService, 0);

	}

	public void getCurrentLocation() {
		if (locationclient != null && locationclient.isConnected()) {
			Location loc = locationclient.getLastLocation();
			sithApplication.setLocation(loc);
		}
	}

	@Override
	public void onLocationChanged(Location location) {
		if (location != null) {
			sithApplication.setLocation(location);
		}

	}

	@Override
	public void onConnectionFailed(ConnectionResult arg0) {
		UIutil.showAlert(MainActivity.this, "Alert",
				"Could not retriew location info");
	}

	@Override
	public void onConnected(Bundle arg0) {
		locationrequest = LocationRequest.create();
		locationrequest.setInterval(300000);
		locationrequest
				.setPriority(LocationRequest.PRIORITY_BALANCED_POWER_ACCURACY);
		locationclient.requestLocationUpdates(locationrequest, this);

		getCurrentLocation();
	}

	@Override
	public void onDisconnected() {
		// TODO Auto-generated method stub

	}

	@Override
	public void onBackPressed() {
		 Intent startMain = new Intent(Intent.ACTION_MAIN);
	        startMain.addCategory(Intent.CATEGORY_HOME);
	        startMain.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
	        startActivity(startMain);

	}
	
	

}
