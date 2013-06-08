package com.sith.event;

public class Event{
	private String eventID;
	private String eventName;
	private String adminID;
	private String description;
	private String startTime;
	private String endTime;
	private String date;
	private String location;
	private String perceptionSchema;

	public Event(String eventID, String eventName, String adminID, String description, String startTime, String endTime, String date, String location, String perceptionSchema){

		this.eventID=eventID;
		this.eventName=eventName;
		this.adminID=adminID;
		this.description=description;
		this.startTime=startTime;
		this.endTime=endTime;
		this.date=date;
		this.location=location;
		this.perceptionSchema=perceptionSchema;
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

	public String getDate(){
		return date;
	}

	public String getLocation(){
		return location;
	}

	public String getPerceptionSchema(){
		return perceptionSchema;
	}

	public String getEventID(){
		return eventID;
	}
}
