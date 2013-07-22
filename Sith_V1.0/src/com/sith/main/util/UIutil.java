package com.sith.main.util;

import com.sith.main.R;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
import android.graphics.Point;
import android.view.Display;
import android.view.WindowManager;

public class UIutil {
	
	public static void showExceptionAlert(Context context,Exception e){
		new AlertDialog.Builder(context)
	    .setTitle("Exception Occured")
	    .setMessage(e.toString())
	    .setPositiveButton("OK", new DialogInterface.OnClickListener() {
	           public void onClick(DialogInterface dialog, int id) {
	                //do things
	           }
	       })
	     .show();
	}
	
	public static void showAlert(Context context,String title, String message) {
		new AlertDialog.Builder(context).setTitle(title).setMessage(message)
				.setPositiveButton(R.string.ok, null).show();
	}
	
	public static void showAlert(Context context,String title, String message, OnClickListener clickListener) {
		new AlertDialog.Builder(context).setTitle(title).setMessage(message)
				.setPositiveButton(R.string.ok, clickListener).show();
	}
	
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
