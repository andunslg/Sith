package com.sith.main;

import android.app.PendingIntent;
import android.appwidget.AppWidgetManager;
import android.appwidget.AppWidgetProvider;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.widget.RemoteViews;

import com.sith.main.R;
import com.sith.model.EmotionsModel;

/**
 * Contains the functionality of Sith widget
 * 
 * @author Prabhath
 * 
 */
public class SithWidgetProvider extends AppWidgetProvider {

//	public static final String ACTION_FEELING_CHANGED = "com.sith.widget.APPWIDGET_UPDATE";

	@Override
	public void onUpdate(Context context, AppWidgetManager appWidgetManager,
			int[] appWidgetIds) {

		final int N = appWidgetIds.length;

		// Perform this loop procedure for each App Widget that belongs to this
		// provider
		for (int i = 0; i < N; i++) {
			int appWidgetId = appWidgetIds[i];

			// Create an Intent to launch ExampleActivity
			Intent intent = new Intent(context, MainActivity.class);
			PendingIntent pendingIntent = PendingIntent.getActivity(context, 0,
					intent, 0);

			// Get the layout for the App Widget and attach an on-click listener
			// to the button
			RemoteViews views = new RemoteViews(context.getPackageName(),
					R.layout.widget);
			views.setOnClickPendingIntent(R.id.widget_button, pendingIntent);

			// Tell the AppWidgetManager to perform an update on the current app
			// widget
			appWidgetManager.updateAppWidget(appWidgetId, views);
		}

	}

	@Override
	public void onReceive(Context context, Intent intent) {
		super.onReceive(context, intent);
		String s = null;
		if (intent.getAction().equals("android.appwidget.action.APPWIDGET_UPDATE")) {
			// handle intent here
			s = intent.getStringExtra("currentFeeling");
		}
		if (s != null) {
			RemoteViews remoteViews = new RemoteViews(context.getPackageName(),
					R.layout.widget);
			remoteViews.setImageViewResource(R.id.widget_image,
					EmotionsModel.getDawable(s));
			remoteViews.setTextViewText(R.id.widget_text, "I am feeling " + s);
			ComponentName widget = new ComponentName(context, SithWidgetProvider.class);
	        AppWidgetManager.getInstance(context).updateAppWidget(widget, remoteViews );
		}
	}
}
