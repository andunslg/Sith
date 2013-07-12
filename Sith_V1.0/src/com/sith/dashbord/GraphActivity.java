package com.sith.dashbord;

import android.app.Activity;
import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import com.sith.main.R;
import com.sith.main.SithApplication;
import com.sith.main.util.UIutil;

public class GraphActivity extends Activity {

	private SithApplication sithApplication;
	private String url;
	private WebView webView;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		sithApplication = (SithApplication) this.getApplication();
		
		url=getIntent().getExtras().getString("url");
		url+=("?userID="+sithApplication.getUserID());
		
		if(sithApplication.getCurrentSubcription()!=null){
			url+="&subcriptionID="+sithApplication.getCurrentSubcription().getSubscriptionID()+"&subcriptionName="+sithApplication.getCurrentSubcription().getSubscriptionName();
		}else{
			UIutil.showAlert(this, "No subscription", "You have to selecet an event first", new OnClickListener() {
				
				@Override
				public void onClick(DialogInterface dialog, int which) {
					GraphActivity.this.finish();
					
				}
			});
		}
		
		setContentView(R.layout.activity_realtime_statictics);
		
		webView = (WebView) findViewById(R.id.fullscreen_content);
		webView.setWebViewClient(new WebViewClient());
		webView.getSettings().setJavaScriptEnabled(true);
		webView.loadUrl(url);
		
		
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.real_time_statictics2, menu);
		return true;
	}
	
	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		switch (item.getItemId()) {
		case R.id.refreshGraph:
			webView.reload();
			return true;
		}
		return true;
	}

}
