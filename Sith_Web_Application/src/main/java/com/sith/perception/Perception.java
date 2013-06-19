package com.sith.perception;

public class Perception{

	private String userID;
	private String eventID;
	private String perceptionValue;
	private String text;

	public Perception(String userID, String eventID, String perceptionValue, String text){

		this.userID=userID;
		this.eventID=eventID;
		this.perceptionValue=perceptionValue;
		this.text=text;
	}

	public Perception(String userID, String eventID, String perceptionValue){

		this.userID=userID;
		this.eventID=eventID;
		this.perceptionValue=perceptionValue;
		this.text="";
	}

	public String getUserID(){
		return userID;
	}

	public String getEventID(){
		return eventID;
	}

	public String getPerceptionValue(){
		return perceptionValue;
	}

	public String getText(){
		return text;
	}

	private String perceptionMapper(int perceptionValue){
		switch(perceptionValue){
			case 5 :
				return "Awesome";

			case 4:
				return "Wonderful";

			case 3:
				return "Excited";

			case 2:
				return "Interested";

			case 1:
				return "Happy";

			case 0:
				return "Neutral";

			case -1:
				return "Bored";

			case -2:
				return "Sleepy";

			case -3:
				return "Sad";

			case -4:
				return "Angry";

			case -5:
				return "Horrible";
			default:
				return "Not valid";
		}
	}
}
