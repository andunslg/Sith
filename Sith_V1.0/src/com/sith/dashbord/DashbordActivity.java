package com.sith.dashbord;

import android.app.Activity;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.DialogInterface.OnClickListener;
import android.os.Bundle;
import android.view.Menu;
import android.view.View;

import com.sith.main.R;
import com.sith.main.SithAPI;
import com.sith.main.SithApplication;
import com.sith.main.util.UIutil;
import com.sith.model.Subscription;

public class DashbordActivity extends Activity {

	private SithApplication sithApplication;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_dashbord);
		
		getActionBar().setDisplayHomeAsUpEnabled(true);

		sithApplication = (SithApplication) this.getApplication();
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.dashbord, menu);
		return true;
	}

	/**
	 * Button click handler
	 * 
	 * @param v
	 */
	public void onButtonClicker(View v) {
		Intent intent = new Intent(this, GraphActivity.class);
		if (sithApplication.getCurrentSubcription() == null) {
			handleNoSubcription();
		}

		switch (v.getId()) {
		case R.id.main_btn_eclair:
			intent.putExtra("url", SithAPI.REALTIME_GRAPH);
			break;

		case R.id.main_btn_froyo:
			intent.putExtra("url", SithAPI.NONREALTIME_GRAPH);
			break;

		case R.id.main_btn_gingerbread:
			intent.putExtra("url", SithAPI.COUNT_GRAPH);
			break;

		case R.id.main_btn_honeycomb:
			intent.putExtra("url", SithAPI.SELF_GRAPH);
			break;
			
		default:
			break;
		}
		startActivity(intent);
	}

	public void handleNoSubcription() {
		UIutil.showAlert(this, "No subscription",
				"You have to selecet an event first", new OnClickListener() {

					@Override
					public void onClick(DialogInterface dialog, int which) {
						DashbordActivity.this.finish();

					}
				});
	}

}
