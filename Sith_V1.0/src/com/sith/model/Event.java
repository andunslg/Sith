package com.sith.model;


public class Event extends Subscription {

	private String location;

	private String startTime;

	private String endTime;

	private String startDate;
	
	private String endDate;
	
	private double lat=-1;
	
	private double lng=-1;
	
	private boolean isDistributed=false;

	public double getLat() {
		return lat;
	}

	public void setLat(double lat) {
		this.lat = lat;
	}

	public double getLng() {
		return lng;
	}

	public void setLng(double lng) {
		this.lng = lng;
	}

	public boolean isDistributed() {
		return isDistributed;
	}

	public void setDistributed(boolean isDistributed) {
		this.isDistributed = isDistributed;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public Event() {
		super();
		this.setType(SubscriptionTypes.event);
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	

}
