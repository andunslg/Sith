package com.sith.main;

import java.util.HashMap;
import java.util.Map;

import com.sith.main.util.AsyncHTTPHandler;

public class SithAPI {

	public static final String EVENT_STATUS_POST="http://sithplatform.cse.mrt.ac.lk:8280/Sith/1.0/publishEventPerception";
	public static final String HELP_URL="http://sithplatform.cse.mrt.ac.lk";
	public static final String GET_SUBSCRIPTION_BY_ID="http://sithplatform.cse.mrt.ac.lk:8280/Sith/1.0/getEventById";
	public static final String SUBSCRIBE="http://sithplatform.cse.mrt.ac.lk:8280/Sith/1.0/registerUserForEvent";
	public static final String GET_ACTIVE_SUBSCRIPTIONS="http://sithplatform.cse.mrt.ac.lk:8280/Sith/1.0/getSubscribedEvents";
	public static final String UNSUBSCRIBE="http://sithplatform.cse.mrt.ac.lk:8280/Sith/1.0/unsubscribeFromEvent";
	public static final String SEARCH="http://sithplatform.cse.mrt.ac.lk:8280/Sith/1.0/getAllEvents";
	public static final String REGISTER_FB_USER="http://sithplatform.cse.mrt.ac.lk:8280/Sith/1.0/registerFBUser";
	public static final String IMAGE_HOST="http://sithplatform.cse.mrt.ac.lk/imageHosting/";
	public static final String GET_PARTICIPANTS="http://sithplatform.cse.mrt.ac.lk:8280/Sith/1.0/getParticipants"	;
	public static final String REGISTER_USER="http://sithplatform.cse.mrt.ac.lk:8280/Sith/1.0/registerAnnonymousUser"	;
	public static final String AUTHENTICATE_USER="http://sithplatform.cse.mrt.ac.lk:8280/Sith/1.0/authenticateUser"	;
	
	public static final String NONREALTIME_GRAPH="http://sithplatform.cse.mrt.ac.lk/Sith/mobile/percepCountsMob.jsp";
	public static final String REALTIME_GRAPH="http://sithplatform.cse.mrt.ac.lk/Sith/mobile/percepTimeAnalysisMob.jsp";
	public static final String COUNT_GRAPH="http://sithplatform.cse.mrt.ac.lk/Sith/mobile/line-basic.jsp";
	public static final String SELF_GRAPH="http://sithplatform.cse.mrt.ac.lk/Sith/mobile/selfAnalyticsMob.jsp";
	
	AsyncHTTPHandler httpHandler=new AsyncHTTPHandler();
	
	
	public boolean subscribe(String userID,String subscriptionID) throws Exception{
		Map<String,String> parameters=new HashMap<String,String>();
		parameters.put("userID",userID );
		parameters.put("eventID",subscriptionID );
		parameters.put("status","participant");
		httpHandler.get(SithAPI.SUBSCRIBE, parameters);
		return false;
	}
	
	public boolean unSubscribe(String userID,String subscriptionID) throws Exception{
		Map<String,String> parameters=new HashMap<String,String>();
		parameters.put("userID",userID );
		parameters.put("eventID",subscriptionID );
		httpHandler.get(SithAPI.UNSUBSCRIBE, parameters);
		return false;
	}
	
	
}
