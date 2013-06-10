package com.sith.event;

import com.sith.user.AnonymousUser;
import com.sith.user.User;

public class Participant extends AnonymousUser{
	private String time;
	private String mode;


	public Participant(String name, String time, String mode){
		super(name);
		this.time=time;
		this.mode=mode;
	}

	public void setMode(String mode){
		this.mode=mode;

	}

	public String getTime(){
		return time;
	}

	public void setTime(String time){
		this.time=time;
	}

	public String getMode(){
		return mode;
	}
}
