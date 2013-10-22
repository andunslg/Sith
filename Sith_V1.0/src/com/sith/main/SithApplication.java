package com.sith.main;

import java.util.ArrayList;
import java.util.List;

import com.sith.model.Subscription;

import android.app.Application;
import android.location.Location;

public class SithApplication extends Application {

	List<String> subscriptionIDs = new ArrayList<String>();
	
	String userID;
	
	String currentFeeling;
	
	Subscription currentSubcription;
	
	boolean isFB=false;
	
	Location location;
	
	String locationName="none";
	
	

	public boolean isFB() {
		return isFB;
	}

	public void setFB(boolean isFB) {
		this.isFB = isFB;
	}

	public Subscription getCurrentSubcription() {
		return currentSubcription;
	}

	public void setCurrentSubcription(Subscription currentSubcription) {
		this.currentSubcription = currentSubcription;
	}

	public String getCurrentFeeling() {
		return currentFeeling;
	}

	public void setCurrentFeeling(String currentFeeling) {
		this.currentFeeling = currentFeeling;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	List<Subscription> subscriptions = new ArrayList<Subscription>();

	public List<String> getSubscriptionIDs() {
		return subscriptionIDs;
	}

	public void setSubscriptionIDs(List<String> subscriptionIDs) {
		this.subscriptionIDs = subscriptionIDs;
	}

	public List<Subscription> getSubscriptions() {
		return subscriptions;
	}

	public void setSubscriptions(List<Subscription> subscriptions) {
		this.subscriptions = subscriptions;
	}

	public String getLocationName() {
		return locationName;
	}

	public void setLocationName(String locationName) {
		this.locationName = locationName;
	}

	public void setLocation(Location location) {
		this.location = location;
	}

	public Location getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.locationName = location;
	}

	

}
