package com.sith.main;

import android.graphics.Point;
import android.view.Display;
import android.view.WindowManager;

public class Utils {
	
	public static int getScreenWidth(WindowManager windowManager){
		Display display = windowManager.getDefaultDisplay();
		Point size = new Point();
		display.getSize(size);
		return size.x;
	}
	
	public static int getScreenHeight(WindowManager windowManager){
		Display display = windowManager.getDefaultDisplay();
		Point size = new Point();
		display.getSize(size);
		return size.y;
	}
	


}
