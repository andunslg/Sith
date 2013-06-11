package com.sith;

import com.sith.event.Event;
import com.sith.util.HTTPUtil;
import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;

public class SithAPI{
	public static SithAPI sithAPI=new SithAPI();
	private HTTPUtil httpUtil=new HTTPUtil();

	public static String NODEAPI="http://192.248.8.246:3000/";

	public static String LOGIN=NODEAPI+"authenticateUser";
	public static String SIGNUP=NODEAPI+"registerAnnonymousUser";

	public static String GET_EVENT_LIST=NODEAPI+"getAllEvents";
	public static String ADD_EVENT=NODEAPI+"addEvent";
	public static String ADD_USER_TO_EVENT=NODEAPI+"registerUserForEvent";
	public static String REMOVE_USER_FROM_EVENT=NODEAPI+"unsubscribeFromEvent" ;
	public static String GET_EVENT_BY_ID=NODEAPI+"getEventById";
	public static String PUBLISH_COMMENT=NODEAPI+"publishComment";
	public static String GET_ALL_COMMENTS=NODEAPI+"getAllComments";
	public static String GET_PARTICIPANTS=NODEAPI+"getParticipants";
	public static String DELETE_EVENT=NODEAPI+"deleteEvent";

	public static String GET_MASTER_PERCEPTIONS=NODEAPI+"getMasterPerceptions";

	public static String GET_USER_EVENT_LIST=NODEAPI+"getSubscribedEvents";


	public ArrayList<Event> getEventList(){
		ArrayList<Event> events=null;

		String result=null;
		try{
			result=httpUtil.doGet(GET_EVENT_LIST);
			JSONArray jsonArray=new JSONArray(result);
			events=new ArrayList<Event>();
			for(int i=0;i<jsonArray.length();i++){
				JSONObject jsonObject=jsonArray.getJSONObject(i);
				Event event= new Event(jsonObject.getString("eventID"),jsonObject.getString("eventName"),jsonObject.getString("eventAdmin"),jsonObject.getString("description"),jsonObject.getString("startTime"),jsonObject.getString("endTime"),jsonObject.getString("date"),jsonObject.getString("location"),jsonObject.getString("perceptionSchema"));
				events.add(event);
			}

		}catch(Exception e){
			e.printStackTrace();
		}

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
