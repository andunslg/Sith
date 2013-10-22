package com.sith.model;

import java.util.ArrayList;
import java.util.List;

import com.sith.main.R;
import com.sith.main.SithAPI;

public class EmotionsModel {

	public static int getDawable(String emotion) {

		if (emotion.equalsIgnoreCase("happy")) {
			return R.drawable.happy1;
		} else if (emotion.equalsIgnoreCase("Awesome")) {
			return R.drawable.very_happy;
		} else if (emotion.equalsIgnoreCase("Wonderful")) {
			return R.drawable.wonderfull;
		} else if (emotion.equalsIgnoreCase("Excited")) {
			return R.drawable.excited;
		} else if (emotion.equalsIgnoreCase("Interested")) {
			return R.drawable.interested;
		} else if (emotion.equalsIgnoreCase("Neutral")) {
			return R.drawable.neutral1;
		} else if (emotion.equalsIgnoreCase("Bored")) {
			return R.drawable.bored;
		} else if (emotion.equalsIgnoreCase("Sleepy")) {
			return R.drawable.sleepy;
		} else if (emotion.equalsIgnoreCase("Sad")) {
			return R.drawable.crying;
		} else if (emotion.equalsIgnoreCase("Angry")) {
			return R.drawable.angry;
		} else if (emotion.equalsIgnoreCase("Horrible")) {
			return R.drawable.horrible;
		} else if (emotion.equalsIgnoreCase("surprised ")) {
			return R.drawable.surprised;
		}

		return -1;

	}
	
	public static String getImageURL(String emotion) {

		if (emotion.equalsIgnoreCase("happy")) {
			return SithAPI.IMAGE_HOST+"happy1.png";
		} else if (emotion.equalsIgnoreCase("Awesome")) {
			return SithAPI.IMAGE_HOST+"very_happy.png";
		} else if (emotion.equalsIgnoreCase("Wonderful")) {
			return SithAPI.IMAGE_HOST+"wonderfull.png";
		} else if (emotion.equalsIgnoreCase("Excited")) {
			return SithAPI.IMAGE_HOST+"excited.png";
		} else if (emotion.equalsIgnoreCase("Interested")) {
			return SithAPI.IMAGE_HOST+ "interested.png";
		} else if (emotion.equalsIgnoreCase("Neutral")) {
			return SithAPI.IMAGE_HOST+"neutral1.png";
		} else if (emotion.equalsIgnoreCase("Bored")) {
			return SithAPI.IMAGE_HOST+"bored.png";
		} else if (emotion.equalsIgnoreCase("Sleepy")) {
			return SithAPI.IMAGE_HOST+"sleepy.png";
		} else if (emotion.equalsIgnoreCase("Sad")) {
			return SithAPI.IMAGE_HOST+"crying.png";
		} else if (emotion.equalsIgnoreCase("Angry")) {
			return SithAPI.IMAGE_HOST+"angry.png";
		} else if (emotion.equalsIgnoreCase("Horrible")) {
			return SithAPI.IMAGE_HOST+"horrible.png";
		} else if (emotion.equalsIgnoreCase("surprised ")) {
			return SithAPI.IMAGE_HOST+"surprised.png";
		}

		return null;

	}

	public static List<String> getDefaultModel() {
		ArrayList<String> list = new ArrayList<String>();
		list.add("Neutral");
		list.add("Happy");
		list.add("Sad");
		list.add("Angry");
		list.add("Excited");

		return list;
	}
}
