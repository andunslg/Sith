package com.sith.user;

import com.sith.event.Event;

import java.util.ArrayList;

public class UserHandler{

	public ArrayList<Event> getUserEventList(String userID){
		ArrayList<Event> events=new ArrayList<Event>();
		Event sampleEvent=new Event("event1","CSE_Programming_Challange","aslg","This is programming challenge","1300","1700","20-06-2013","CSLR","Happy:Sleepy:Bored:Interested:Neutral");
		events.add(sampleEvent);
		sampleEvent=new Event("event2","Software_Engineering_Project","prabhath","This is SE project","0800","1200","22-06-2013","Seminar Room","Happy:Sleepy:Bored:Interested:Neutral");
		events.add(sampleEvent);
		return events;
	}

	public boolean registerToEvent(String eventID, String userID){
		return true;
	}
}
