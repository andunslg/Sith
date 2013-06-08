package com.sith;

import com.sith.model.Event;
import com.sith.model.Participant;

import java.util.ArrayList;
import java.util.List;

public class SithAPI {
	public static SithAPI sithAPI=new SithAPI();

	public static String NODEAPI="http://192.248.8.246:3000/";
	public static String LOGIN=NODEAPI+"authenticateUser";
	public static String SIGNUP=NODEAPI+"registerAnnonymousUser";
	public static String GET_EVENT_LIST="";

	public Event getEvent(String eventID){

		Event sampleEvent=new Event("event1","CSE_Programming_Challange","aslg","This is programming challenge","1300","1700","20-06-2013","CSLR","Happy:Sleepy:Bored:Interested:Neutral");
		Event sampleEvent1=new Event("event2","Software_Engineering_Project","prabhath","This is SE project","0800","1200","22-06-2013","Seminar Room","Happy:Sleepy:Bored:Interested:Neutral");
		Event sampleEvent2=new Event("event3","FYP","sachintha","This is FYP","0800","1200","22-10-2013","FYP Lab","Happy:Sleepy:Bored:Interested:Neutral");
		Event sampleEvent3=new Event("event4","WSO2_Con","tgts","This is WSO2 CON","0800","1200","04-11-2013","USA","Happy:Sleepy:Bored:Interested:Neutral");
		if(eventID.equals("event1")){
			return sampleEvent;
		}
		else if(eventID.equals("event2")){
			return  sampleEvent1;
		}
		else if(eventID.equals("event3")){
			return  sampleEvent2;
		}
		else{
			return  sampleEvent3;
		}


	}

	public ArrayList<String> getComments(String eventID){

		ArrayList<String> list=new ArrayList<String>();
		list.add("Prabhath::this is cool");
		return list;

	}

	public Participant getParticipant(String name){
		if(name.equals("aslg")){
			return new Participant("aslg","Andun Sameera","2.35PM","Happy");
		}
		else{
			return new Participant("prabhath","Prabhath Pathirana","2.35PM","Happy");
		}
	}

	public List<Participant> getParticipants(String eventID){
		ArrayList<Participant> participants=new ArrayList<Participant>();

		participants.add(new Participant("prabhath","Prabhath Pathirana","2.35PM","Happy"));
		participants.add(new Participant("aslg","Andun Sameera","2.35PM","Happy"));
		return participants;
	}

	public ArrayList<Event> getEventList(){
		ArrayList<Event> events=new ArrayList<Event>();
		Event sampleEvent=new Event("event1","CSE_Programming_Challange","aslg","This is programming challenge","1300","1700","20-06-2013","CSLR","Happy:Sleepy:Bored:Interested:Neutral");
		events.add(sampleEvent);
		sampleEvent=new Event("event2","Software_Engineering_Project","prabhath","This is SE project","0800","1200","22-06-2013","Seminar Room","Happy:Sleepy:Bored:Interested:Neutral");
		events.add(sampleEvent);
		sampleEvent=new Event("event3","FYP","sachintha","This is FYP","0800","1200","22-10-2013","FYP Lab","Happy:Sleepy:Bored:Interested:Neutral");
		events.add(sampleEvent);
		sampleEvent=new Event("event4","WSO2_Con","tgts","This is WSO2 CON","0800","1200","04-11-2013","USA","Happy:Sleepy:Bored:Interested:Neutral");
		events.add(sampleEvent);
		return  events;
	}

	public ArrayList<Event> getUserEventList(String userID){
		ArrayList<Event> events=new ArrayList<Event>();
		Event sampleEvent=new Event("event1","CSE_Programming_Challange","aslg","This is programming challenge","1300","1700","20-06-2013","CSLR","Happy:Sleepy:Bored:Interested:Neutral");
		events.add(sampleEvent);
		sampleEvent=new Event("event2","Software_Engineering_Project","prabhath","This is SE project","0800","1200","22-06-2013","Seminar Room","Happy:Sleepy:Bored:Interested:Neutral");
		events.add(sampleEvent);
		return  events;
	}

	public boolean registerToEvent(String eventID, String userID){
		return true;
	}

	public static SithAPI getInstance(){
		return sithAPI;
	}


}
