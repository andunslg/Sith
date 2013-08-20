package com.sith.event;

import org.json.JSONObject;

import java.util.ArrayList;

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
	private boolean fixedLocation;
    private String colors;


	private ArrayList<String> timeVariantParams;

	public Event(String eventID, String eventName, String adminID, String description, String startDate, String endDate, String startTime, String endTime, String location,JSONObject latlng, String perceptionSchema, String commentEnabled, String colors,ArrayList<String> timeVariantParams,boolean fixedLocation){

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
		this.timeVariantParams=timeVariantParams;
		this.fixedLocation=fixedLocation;
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
	public void setColors(String colors){
		this.colors = colors;
	}

	public ArrayList<String> getTimeVariantParams(){
		return timeVariantParams;
	}

	public void setTimeVariantParams(ArrayList<String> timeVariantParams){
		this.timeVariantParams=timeVariantParams;
	}

	public boolean isFixedLocation(){
		return fixedLocation;
	}

	public void setFixedLocation(boolean fixedLocation){
		this.fixedLocation=fixedLocation;
	}

	public String getTimeVariantParamsAsString(){
		String timeVariantParamsString="";

		for(String param:timeVariantParams){
			if(timeVariantParamsString.equals("")){
				timeVariantParamsString+=param;
			}
			else {
				timeVariantParamsString+=":"+param;
			}
		}
		return timeVariantParamsString;
	}

	public JSONObject getLatLang(){
		return latLang;
	}

	public void setLatLang(JSONObject latLang){
		this.latLang=latLang;
	}
}
