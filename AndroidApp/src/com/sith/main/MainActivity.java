package com.sith.main;

import java.security.MessageDigest;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.Signature;
import android.graphics.Typeface;
import android.os.Bundle;

import android.util.Base64;
import android.util.Log;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.ArrayAdapter;
import android.widget.SpinnerAdapter;
import android.widget.TextView;
import android.widget.Toast;

import com.carousel.controls.Carousel;
import com.carousel.controls.CarouselAdapter;
import com.carousel.controls.CarouselAdapter.OnItemClickListener;
import com.carousel.controls.CarouselAdapter.OnItemSelectedListener;
import com.carousel.controls.CarouselItem;
import com.sith.list3d.ListChooser;
import com.sith.main.util.AsyncHTTPHandler;
import com.slidingmenu.lib.SlidingMenu;

public class MainActivity extends Activity {

	/** An map of strings to populate dropdown list */
	Map<String, String> subscriptions = new LinkedHashMap<String, String>();

	// Sliding Drawer
	SlidingMenu menu;
	AsyncHTTPHandler httpHandler = new AsyncHTTPHandler();
	String userID;
	SharedPreferences pref;

	/** Called when the activity is first created. */
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main);
		
		pref = this.getSharedPreferences("SITH_PREF", Context.MODE_PRIVATE);
		pref.edit().commit();
		
		

		try {
			   PackageInfo info = getPackageManager().getPackageInfo("com.sith.main", PackageManager.GET_SIGNATURES);
			   for (Signature signature : info.signatures) {
			        MessageDigest md = MessageDigest.getInstance("SHA");
			        md.update(signature.toByteArray());
			        Log.d("KeyHash:", Base64.encodeToString(md.digest(), Base64.DEFAULT));
			   }
			}
			catch (Exception e) {}
	
		 
		 
		init();

		// Fonts
		TextView status = (TextView) findViewById(R.id.selected_item);
		Typeface tf = Typeface.createFromAsset(getAssets(),
				"fonts/Roboto-Condensed.ttf");
		status.setTypeface(tf);

		// Webview
		/*
		 * WebView webView = (WebView) findViewById(R.id.context_page);
		 * webView.setWebViewClient(new WebViewClient());
		 * webView.getSettings().setJavaScriptEnabled(true);
		 * webView.loadUrl("http://twitter.github.io/bootstrap/index.html");
		 */

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
		menu.setBehindWidth((Utils.getScreenWidth(getWindowManager()) / 5) * 3);
		menu.setMenu(R.layout.menu_frame);

		Carousel carousel = (Carousel) findViewById(R.id.carousel);
		carousel.setOnItemClickListener(new OnItemClickListener() {

			public void onItemClick(CarouselAdapter<?> parent, View view,
					int position, long id) {

				Toast.makeText(
						MainActivity.this,
						String.format("I Am %s.",
								((CarouselItem) parent.getChildAt(position))
										.getName()), Toast.LENGTH_SHORT).show();
				String s = handlePerception(position);
				
				final TextView txt = (TextView) (findViewById(R.id.selected_item));
				txt.setText(s);
			}

		});

		carousel.setOnItemSelectedListener(new OnItemSelectedListener() {

			public void onItemSelected(CarouselAdapter<?> parent, View view,
					int position, long id) {

			}

			public void onNothingSelected(CarouselAdapter<?> parent) {
			}

		});

	}

	private String getUserID() {
		return pref.getString("userID", null);
	}

	private String handlePerception(int position) {
		switch (position) {
		case 0:
			sendStatus("Happy");
			return ("Happy");
		case 1:
			sendStatus("Sad");
			return ("Sad");
		case 2:
			sendStatus("Angry");
			return ("Angry");
		case 3:
			sendStatus("Exciting");
			return ("Exciting");
		case 4:
			sendStatus("Boring");
			return ("Boring");
		default:
			sendStatus("Nutral");
			return ("Nutral");
		}
	}

	private void populateActionbar(ActionBar actionBar) {
		/** Create an array adapter to populate dropdownlist */
		ArrayAdapter<String> adapter = new ArrayAdapter<String>(
				getBaseContext(),
				android.R.layout.simple_spinner_dropdown_item, subscriptions
						.values().toArray(new String[subscriptions.size()]));

		/** Defining Navigation listener */
		ActionBar.OnNavigationListener navigationListener = new ActionBar.OnNavigationListener() {
			public boolean onNavigationItemSelected(int itemPosition,
					long itemId) {
				String[] subscriptionIDs = subscriptions.keySet().toArray(
						new String[subscriptions.size()]);
				Toast.makeText(getBaseContext(),
						"You selected : " + subscriptionIDs[itemPosition],
						Toast.LENGTH_SHORT).show();
				return false;
			}
		};

		/**
		 * Setting dropdown items and item navigation listener for the actionbar
		 */
		actionBar.setListNavigationCallbacks(adapter, navigationListener);
	}

	// Intialize user data
	private void init() {
		subscriptions.put("none", "No Context");

		subscriptions.put("1", "Event:3rd ODI");
		subscriptions.put("2", "Topic:Prize hike");
		subscriptions.put("thinSlice", "Event:Thin slice demo");

	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// TODO Auto-generated method stub
		MenuInflater inflater = getMenuInflater();
		inflater.inflate(R.menu.menu, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		Intent myIntent = null;
		switch (item.getItemId()) {
		case R.id.itemAdd:
			myIntent = new Intent(MainActivity.this, ListChooser.class);
			MainActivity.this.startActivity(myIntent);
			return true;
		case R.id.itemDashboard:
			myIntent = new Intent(MainActivity.this, RealTimeStatictics.class);
			MainActivity.this.startActivity(myIntent);
			return true;
			// case R.id.:
			// //do something when this button is pressed
			// return true;
		case android.R.id.home:
			menu.toggle();
			return true;
		}
		return true;
	}

	public void onClickProfile(View v) {
		MainActivity.this.startActivity(new Intent(MainActivity.this,
				LoginActivity.class));
	}
	
	public void onClickHelp(View v) {
		//TODO implement
	}
	
	public void onClickSettings(View v) {
		MainActivity.this.startActivity(new Intent(MainActivity.this,
				SettingsActivity.class));
	}

	public void sendStatus(String s) {
		Map<String, String> parameters = new HashMap<String, String>();
		userID=getUserID();
		if(userID!=null){
			parameters.put("userID",userID);
		}else{
			parameters.put("userID","none");
		}
		
		parameters.put("eventID", "thinSlice");
		if (s.equalsIgnoreCase("happy")) {
			parameters.put("perceptionValue", "+1");
		} else if (s.equalsIgnoreCase("sad")) {
			parameters.put("perceptionValue", "-2");
		} else if (s.equalsIgnoreCase("exciting")) {
			parameters.put("perceptionValue", "+2");
		} else if (s.equalsIgnoreCase("nutral")) {
			parameters.put("perceptionValue", "0");
		} else if (s.equalsIgnoreCase("boring")) {
			parameters.put("perceptionValue", "-1");
		} else if (s.equalsIgnoreCase("angry")) {
			parameters.put("perceptionValue", "-3");
		}

		try {
			httpHandler.post(SithAPI.EVENT_STATUS_POST, parameters);
		} catch (Exception e) {
			Log.e("POST error", e.toString());
		}
	}
}
