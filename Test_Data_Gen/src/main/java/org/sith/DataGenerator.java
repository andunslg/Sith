package org.sith;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

public class DataGenerator{
	HTTPUtil httpUtil=new HTTPUtil();

	public static void main(String[] args) throws InterruptedException{
		String eventID="nbqsa_demo";
		//String eventID="asas";
		String userIDMain="test_user_";

		Random randomGenerator = new Random();

		int longitude=79;
		int latitude=6;

		int longitude_one=920000;
		int longitude_two=870000;

		int latitude_one=830000;
		int latitude_two=770000;

		int timeLimit_one=5000;
		int timeLimit_two=1000;



		while(true){

			int tempLat=randomGenerator.nextInt(latitude_one -latitude_two)+latitude_two;
			int tempLong=randomGenerator.nextInt(longitude_one-longitude_two)+longitude_two;

			String lat=String.valueOf(latitude)+"."+String.valueOf(tempLat);
			String longt=String.valueOf(longitude)+"."+String.valueOf(tempLong);

			int perceptionValue=randomGenerator.nextInt(10);
			String perception="";

//			switch(perceptionValue){
//				case 1:
//					perception = "Awesome";
//					break;
//				case 2:
//					perception = "Wonderful";
//					break;
//				case 3:
//					perception = "Excited";
//					break;
//				case 4:
//					perception = "Happy";
//					break;
//				case 5:
//					perception = "Neutral";
//					break;
//				case 6:
//					perception = "Bored";
//					break;
//				case 7:
//					perception = "Sleepy";
//					break;
//				case 8:
//					perception = "Sad";
//					break;
//				case 9:
//					perception = "Angry";
//					break;
//				case 10:
//					perception = "Horrible";
//					break;
//				default :
//					perception = "Neutral";
//					break;
//			}

			switch(perceptionValue){
				case 1:
					perception = "Awesome";
					break;
				case 2:
					perception = "Neutral";
					break;
				case 3:
					perception = "Happy";
					break;
				case 4:
					perception = "Happy";
					break;
				case 5:
					perception = "Neutral";
					break;
				case 6:
					perception = "Bored";
					break;
				case 7:
					perception = "Bored";
					break;
				case 8:
					perception = "Awesome";
					break;
				case 9:
					perception = "Awesome";
					break;
				case 10:
					perception = "Horrible";
					break;
				default :
					perception = "Horrible";
					break;
			}

			int time=randomGenerator.nextInt(timeLimit_one-timeLimit_two);



			int userIDVal=randomGenerator.nextInt(11-1)+1;

			String userID=userIDMain+String.valueOf(userIDVal);

			System.out.println("Latitude - "+lat);
			System.out.println("Longitude - "+longt);
			System.out.println("Perception -"+perception);
			System.out.println("UserID -"+userID);
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
