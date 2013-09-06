package org.sith;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

public class DataGenerator{
	HTTPUtil httpUtil=new HTTPUtil();

	public static void main(String[] args) throws InterruptedException{
		String eventID="nbqsa_demo_2";
		//String eventID="asas";
		//String eventID="e1";
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

		for(int i=0;i<300;i++){

			int tempLat=randomGenerator.nextInt(latitude_one -latitude_two)+latitude_two;
			int tempLong=randomGenerator.nextInt(longitude_one-longitude_two)+longitude_two;

//			String lat=String.valueOf(latitude)+"."+String.valueOf(tempLat);
//			String longt=String.valueOf(longitude)+"."+String.valueOf(tempLong);

			String lat="";
			String longt="";

			int event=randomGenerator.nextInt(4);

			switch(event){
				case 0:
					eventID="nbqsa_1";
					lat = "6.902664905294386";
					longt="79.86482799053192";
					break;
				case 1:
					eventID="nbqsa_2";
					lat = "6.9027714159904647";
					longt="79.860724210739136";
					break;
				case 2:
					eventID="nbqsa_3";
					lat = "6.8933398009786018";
					longt="79.8547214269638";
					break;
				case 3:
					eventID="nbqsa_4";
					lat = "6.893749875101383";
					longt="79.86346006393433";
					break;
			}

			int perceptionValue=randomGenerator.nextInt(7);
			String perception="";

			switch(perceptionValue){
				case 0:
					perception = "Excited";
					break;
				case 1:
					perception = "Excited";
					break;
				case 2:
					perception = "Happy";
					break;
				case 3:
					perception = "Neutral";
					break;
				case 4:
					perception = "Sad";
					break;
				case 5:
					perception = "Horrible";
					break;
				case 6:
					perception = "Horrible";
					break;
			}

			int time=randomGenerator.nextInt(timeLimit_one-timeLimit_two);

			int userIDVal=randomGenerator.nextInt(11-1)+1;
			String userID=userIDMain+String.valueOf(userIDVal);

			System.out.println(i);
			System.out.println("Latitude -"+lat);
			System.out.println("Longitude -"+longt);
			System.out.println("Perception -"+perception);
			System.out.println("UserID -"+userID);
			System.out.println("EventID -"+eventID);
			System.out.println("Sleep Time -"+time);

			DataGenerator dataGenerator=new DataGenerator();
			dataGenerator.postPerception(eventID,userID,perception,lat,longt,"TestLocation");

			Thread.sleep(time);

		}
	}

	public boolean postPerception(String eventID, String userID,String perceptionValue, String lat,String lang,String location){
		Map<String,String> parms=new HashMap<String,String>();
		parms.put("eventID",eventID);
		parms.put("userID",userID);
		parms.put("perceptionValue",perceptionValue);
		parms.put("lat",lat);
		parms.put("lng",lang);
		parms.put("location",location);

		String result=null;
		try{
			//result=httpUtil.doPost("http://localhost:3000/publishEventPerception",parms);
			result=httpUtil.doPost("http://192.248.8.246:3000/publishEventPerception",parms);
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
