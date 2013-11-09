package org.sith;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

public class DataGenerator extends Thread{
	private HTTPUtil httpUtil=new HTTPUtil();
	private int requestCount;

	public DataGenerator(int requestCount){
		this.requestCount=requestCount;
	}

	public static void main(String[] args) throws InterruptedException{
		Random randomGenerator = new Random();
		for(int i=0;i<2;i++){
			int requestCount=randomGenerator.nextInt(2-1)+1;
			new DataGenerator(requestCount).start();
		}
	}

	@Override
	public void run(){

		String eventID="test";
		String userIDMain="test_user_";

		Random randomGenerator = new Random();

		int longitude=79;
		int latitude=6;

		int longitude_one=874969;
		int longitude_two=855571;

		int latitude_one=916373;
		int latitude_two=885186;

		int timeLimit_one=2000;
		int timeLimit_two=1000;

		int successfulCount=0;
		for(int i=0;i<requestCount;i++){

			int tempLat=randomGenerator.nextInt(latitude_one -latitude_two)+latitude_two;
			int tempLong=randomGenerator.nextInt(longitude_one-longitude_two)+longitude_two;

			String lat=String.valueOf(latitude)+"."+String.valueOf(tempLat);
			String longt=String.valueOf(longitude)+"."+String.valueOf(tempLong);

//			String lat="";
//			String longt="";
//
//			int event=randomGenerator.nextInt(4);
//
//			switch(event){
//				case 0:
//					eventID="test_event_2";
//					lat = "6.991859181483692";
//					longt="79.98046875";
//					break;
//				case 1:
//					eventID="test_event_3";
//					lat = "6.863712339483681";
//					longt="79.95849609375";
//					break;
//				case 2:
//					eventID="test_event_4";
//					lat = "6.926426847059551";
//					longt="79.903564453125";
//					break;
//				case 3:
//					eventID="test_event_5";
//					lat = "6.926426847059551";
//					longt="79.969482421875";
//					break;
//			}

			int perceptionValue=randomGenerator.nextInt(11);
			String perception="";

			switch(perceptionValue){
				case 0:
					perception = "Excited";
					break;
				case 1:
					perception = "Neutral";
					break;
				case 2:
					perception = "Happy";
					break;
				case 3:
					perception = "Excited";
					break;
				case 4:
					perception = "Happy";
					break;
				case 5:
					perception = "Neutral";
					break;
				case 6:
					perception = "Sad";
					break;
				case 7:
					perception = "Horrible";
					break;
				case 8:
					perception = "Sad";
					break;
				case 9:
					perception = "Happy";
					break;
				case 10:
					perception = "Horrible";
					break;
			}

			int time=randomGenerator.nextInt(timeLimit_one-timeLimit_two);

			int userIDVal=randomGenerator.nextInt(5-1)+1;
			String userID=userIDMain+String.valueOf(userIDVal);

			System.out.println("----------------------------------"+Thread.currentThread()+"----------------------------------");
			System.out.println(i);
			System.out.println("Latitude -"+lat);
			System.out.println("Longitude -"+longt);
			System.out.println("Perception -"+perception);
			System.out.println("UserID -"+userID);
			System.out.println("EventID -"+eventID);
			System.out.println("Sleep Time -"+time);
			System.out.println("----------------------------------------------------------------------------------------------");

			//String url="http://localhost:3000/publishEventPerception";
			//String url="http://192.248.8.246:3000/publishEventPerception";
			String url="http://192.248.15.232:3000/publishEventPerception";

			boolean result=postPerception(url,eventID,userID,perception,lat,longt,"TestLocation");
			if(result){
				successfulCount++;
			}

			try{
				Thread.sleep(400);
			}catch(InterruptedException e){
				e.printStackTrace();
			}

		}

		System.out.println(Thread.currentThread()+" - Out of "+requestCount+" requests, "+successfulCount+" are successful");
	}

	private boolean postPerception(String url,String eventID, String userID,String perceptionValue, String lat,String lang,String location){
		Map<String,String> parms=new HashMap<String,String>();
		parms.put("eventID",eventID);
		parms.put("userID",userID);
		parms.put("perceptionValue",perceptionValue);
		parms.put("lat",lat);
		parms.put("lng",lang);
		parms.put("location",location);

		String result=null;
		try{
			result=httpUtil.doPost(url,parms);
			if(!result.equals("")){
				if("{\"response\":true}".equals(result)){
					return true;
				}
				return false;
			}
		}catch(Exception e){
			e.printStackTrace();
		}

		return false;
	}
}
