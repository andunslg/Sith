package com.sith.event;

import org.json.JSONObject;

public class Event{
	private String eventID;
	private String eventName;
	private String adminID;
	private String description;
	private String startDate;
	private String endDate;
	private String startTime;
	private String endTime;
	private String location;
    private JSONObject latLang;
	private String perceptionSchema;
	private String commentEnabled;
    private String colors;
	public Event(String eventID, String eventName, String adminID, String description, String startDate, String endDate, String startTime, String endTime, String location,JSONObject latlng, String perceptionSchema, String commentEnabled, String colors){

		this.eventID=eventID;
		this.eventName=eventName;
		this.adminID=adminID;
		this.description=description;
		this.startDate=startDate;
		this.endDate=endDate;
		this.startTime=startTime;
		this.endTime=endTime;
		this.location=location;
        this.latLang = latlng;
		this.perceptionSchema=perceptionSchema;
		this.commentEnabled=commentEnabled;
        this.colors = colors;
	}

	public String getEventName(){
		return eventName;
	}

	public String getAdminID(){
		return adminID;
	}

	public String getDescription(){
		return description;
	}

	public String getStartTime(){
		return startTime;
	}

	public String getEndTime(){
		return endTime;
	}

	public String getLocation(){
		return location;
	}
    public JSONObject getLatLng(){
        return latLang;
    }
	public String getPerceptionSchema(){
		return perceptionSchema;
	}

	public String getEventID(){
		return eventID;
	}

	public String getStartDate(){
		return startDate;
	}

	public String getEndDate(){
		return endDate;
	}

	public String getCommentEnabled(){
		return commentEnabled;
	}

    public String getColors(){
        return colors;
    }
}
