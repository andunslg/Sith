package com.sith.login;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.Menu;
import android.view.View;
import android.widget.TextView;

import com.sith.main.R;
import com.sith.main.SithApplication;

public class SithProfileActivity extends Activity {

	private TextView textView;
	private SithApplication sithApplication;
	private SharedPreferences pref;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_sith_profile);

		pref = this.getSharedPreferences("SITH_PREF", Context.MODE_PRIVATE);
		sithApplication = (SithApplication) getApplication();

		textView = (TextView) findViewById(R.id.editText_profile_info);

		sithApplication = (SithApplication) this.getApplication();

		String user = sithApplication.getUserID();
		if (user == null || user.equalsIgnoreCase("none")) {
			startActivity(new Intent(this, SithLoginActivity.class));
		} else {
			textView.setText("You are logged in as " + user + ".");
		}
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.sith_profile, menu);
		return true;
	}

	public void onClickLogout(View view) {
		Intent intent = new Intent(this, SithLoginActivity.class);
		startActivity(intent);

		pref.edit().putString("userID", "none").commit();
		pref.edit().putBoolean("isFB", false).commit();
		sithApplication.setUserID("none");
		sithApplication.setFB(false);

	}

	public void onClickFacebookConnect(View view) {
		Intent intent = new Intent(this, FBLoginActivity.class);
		intent.putExtra("isConnect", true);
		startActivity(intent);
	}

}
