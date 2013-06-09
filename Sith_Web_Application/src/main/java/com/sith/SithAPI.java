package com.sith;

import com.sith.event.Event;
import com.sith.util.HTTPUtil;

import java.util.ArrayList;

public class SithAPI{
	public static SithAPI sithAPI=new SithAPI();
	private HTTPUtil httpUtil=new HTTPUtil();

	public static String NODEAPI="http://192.248.8.246:3000/";

	public static String LOGIN=NODEAPI+"authenticateUser";
	public static String SIGNUP=NODEAPI+"registerAnnonymousUser";

	public static String GET_EVENT_LIST=NODEAPI+"getAllEvents";
	public static String ADD_EVENT=NODEAPI+"addEvent";

	public static String GET_MASTER_PERCEPTIONS=NODEAPI+"getMasterPerceptions";

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

		String result=null;
		try{
			result=httpUtil.doGet(GET_EVENT_LIST);
		}catch(Exception e){
			e.printStackTrace();
		}
		System.out.println(result);
		return events;
	}
	public ArrayList<String> getMasterPerceptions(){
		ArrayList<String> perceptions=null;
		try{
			String result=httpUtil.doGet(GET_MASTER_PERCEPTIONS);
			if(result!=null){
				perceptions=new ArrayList<String>();
				result=result.substring(1,result.length()-1);
				String arr[]=result.split(",");
				for(int i=0;i<arr.length;i++){
					perceptions.add(arr[i].substring(1,arr[i].length()-1));
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return perceptions;
	}


	public static SithAPI getInstance(){
		return sithAPI;
	}


}
