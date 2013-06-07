package com.sith.model;

public class User{
	private String userID;
	private String userName;

	public User(String userID,String userName){
		this.userID=userID;
		this.userName=userName;
	}


	public String getUserName(){
		return userName;
	}

	public void setUserName(String userName){
		this.userName=userName;
	}

	public String getUserID(){
		return userID;
	}
}
