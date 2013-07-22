package com.sith.model;

import java.util.List;

import com.google.gson.annotations.SerializedName;

public class Subscription {
	
	public Subscription() {
		super();
	}
	
	@SerializedName("eventID")
	private String subscriptionID;
	
	@SerializedName("eventName")
	private String subscriptionName;
	
	@SerializedName("description")
	String description;
	

	private SubscriptionTypes type;
	
	@SerializedName("perceptionSchema")
	private List<String> moods;
	
	
	public List<String> getMoods() {
		return moods;
	}
	public void setMoods(List<String> moods) {
		this.moods = moods;
	}
	public SubscriptionTypes getType() {
		return type;
	}
	public void setType(SubscriptionTypes type) {
		this.type = type;
	}
	public Subscription(String subscriptionID, String subscriptionName,List<String> moods) {
		super();
		this.subscriptionID = subscriptionID;
		this.subscriptionName = subscriptionName;
		this.moods=moods;
	}
	public String getSubscriptionID() {
		return subscriptionID;
	}
	public void setSubscriptionID(String subscriptionID) {
		this.subscriptionID = subscriptionID;
	}
	public String getSubscriptionName() {
		return subscriptionName;
	}
	public void setSubscriptionName(String subscriptionName) {
		this.subscriptionName = subscriptionName;
	}
	
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}


