package com.sith.location;

import android.app.IntentService;
import android.content.Intent;
import android.location.Location;

import com.google.android.gms.location.LocationClient;
import com.sith.main.SithApplication;

public class LocationService extends IntentService {

	public LocationService() {
		super("Fused Location");
	}

	public LocationService(String name) {
		super("Fused Location");
	}

	@Override
	protected void onHandleIntent(Intent intent) {

			Location location = intent.getParcelableExtra(LocationClient.KEY_LOCATION_CHANGED);
			SithApplication sithApplication=(SithApplication) this.getApplication();
			if(location !=null){
				sithApplication.setLocation(location);
			}
	}

}