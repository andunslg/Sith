package com.sith.main;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.json.JSONException;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.graphics.Typeface;
import android.os.Bundle;
import android.text.Html;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.Button;
import android.widget.TextView;

import com.loopj.android.http.AsyncHttpClient;
import com.loopj.android.http.AsyncHttpResponseHandler;
import com.loopj.android.http.RequestParams;
import com.sith.dashbord.DashbordActivity;
import com.sith.login.SithLoginActivity;
import com.sith.main.util.UIutil;
import com.sith.model.Event;
import com.sith.model.Parser;
import com.sith.model.Subscription;
import com.sith.model.SubscriptionTypes;

public class SubscriptionInfoActivity extends Activity {
	
	private Subscription subscription;
	private boolean isSubscribed=false;
	
	private SithApplication sithApplication;
	
	private TextView type;
	private TextView description;
	private TextView startTime;
	private TextView endTime;
	private TextView moods;
	private TextView activeSubscriptions;
	private Button subscribeButton;
	private AsyncHttpClient client = new AsyncHttpClient();
	private SithAPI sithAPI=new SithAPI();
	private ProgressDialog progress;
	private RequestParams requestParams = new RequestParams();	
	private List<String> userList;
	

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_subscription_info);
		setTitle("Info");
		
		getActionBar().setDisplayHomeAsUpEnabled(true);
		
		sithApplication=(SithApplication) this.getApplication();
		
		progress = new ProgressDialog(this);
		
		WebView webView = (WebView) findViewById(R.id.subscription_webview);
		webView.setWebViewClient(new WebViewClient());
		webView.loadUrl("http://t1.gstatic.com/images?q=tbn:ANd9GcRSYyf9iaNHuq19vtoPu3_IFArLwWV1MG2JjFgHPL0cqYhGTgwr");
		
		type=(TextView) findViewById(R.id.sub_type);
		description=(TextView) findViewById(R.id.sub_description);
		startTime=(TextView) findViewById(R.id.sub_starttime);
		endTime=(TextView) findViewById(R.id.sub_endtime);
		moods=(TextView) findViewById(R.id.sub_moods);
		activeSubscriptions=(TextView) findViewById(R.id.sub_active_count);
		subscribeButton=(Button)findViewById(R.id.subscribe_button);
		
		//Fonts
		Typeface tf = Typeface.createFromAsset(getAssets(),
				"fonts/Roboto-Medium.ttf");
		type.setTypeface(tf);
		
		init(getIntent().getExtras().getString("subscriptionID"));
		
	}

	private void init(String subscriptionID) {
		
		requestParams.put("eventID", subscriptionID);
		client.get(SithAPI.GET_SUBSCRIPTION_BY_ID,requestParams, new AsyncHttpResponseHandler() {
			
			@Override
			public void onStart() {
				super.onStart();
				progress.setTitle("Loading");
				progress.setMessage("Downloading information....");
				progress.show();
			};
			
		    @Override
		    public void onSuccess(String response) {
		    	
		    	try {
		    		subscription=Parser.parseSubscription(response);
				} catch (Exception e) {
					//TODO
					progress.dismiss();
					UIutil.showExceptionAlert(SubscriptionInfoActivity.this, e);
				}
		    	
		    	SubscriptionInfoActivity.this.setTitle(subscription.getSubscriptionName());
		    	description.setText(Html.fromHtml("<b>Description:</b>" + subscription.getDescription()));

		    	if(subscription.getType().equals(SubscriptionTypes.event)){
		    		Event e=(Event)subscription;
		    		startTime.setText(Html.fromHtml("<b>Start Time:</b>" + e.getStartTime()));
		    		endTime.setText(Html.fromHtml("<b>End Time:</b>"+e.getEndTime()));
		    		type.setText(Html.fromHtml("<b>Type:</b>"+"Event")); 
		    		moods.setText(Html.fromHtml("<b>Moods:</b>"+StringUtils.join(e.getMoods())));
		    		
		    	}		   
		    	
		    	SithApplication activeSubscriptions=(SithApplication) getApplicationContext().getApplicationContext();
		    	if(!activeSubscriptions.getSubscriptionIDs().contains(subscription.getSubscriptionID())){
		    		subscribeButton.setText("Subscribe");
		    		isSubscribed=false;
		    	}else{
		    		subscribeButton.setText("Unsubscribe");
		    		isSubscribed=true;
		    	}
		       
		    }
		    
		    @Override
			public void onFailure(Throwable arg0, String arg1) {
				UIutil.showExceptionAlert(SubscriptionInfoActivity.this, new Exception(arg0.toString()));
			}
		    
		    @Override
		    public void onFinish() {
//		    	progress.dismiss();
		    	super.onFinish();
		    	
		    	client.get(SithAPI.GET_SUBSCRIPTION_BY_ID,requestParams, new AsyncHttpResponseHandler() {
					
					@Override
					public void onStart() {
						super.onStart();
					};
					
				    @Override
				    public void onSuccess(String response) {
				    	try {
							userList=Parser.parseList(response, "userID");
						} catch (JSONException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}    	
				    }
				    
				    @Override
					public void onFailure(Throwable arg0, String arg1) {
						UIutil.showExceptionAlert(SubscriptionInfoActivity.this, new Exception(arg0.toString()));
					}
				    
				    @Override
				    public void onFinish() {
				    	if(userList!=null){
				    		activeSubscriptions.setText(Html.fromHtml("<b>No of participants:</b>"+userList.size()));
				    	}else{
				    		activeSubscriptions.setText(Html.fromHtml("<b>No of participants:0</b>"));
				    	}
				    	progress.dismiss();
				    	super.onFinish();
				    }
				    
				    
		    	});
		    }
		});		
		
		
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.subscription_info, menu);
		return true;
	}
	
	public void onClickSubscription(View v){
		try {
			if (isSubscribed) {
				sithAPI.unSubscribe(sithApplication.getUserID(),
						subscription.getSubscriptionID());
				isSubscribed=false;
				subscribeButton.setText("Subscribe");
				List<Subscription> temp=new ArrayList<Subscription>();
				for(Subscription s:sithApplication.getSubscriptions()){
					if(!s.getSubscriptionID().equals(subscription.getSubscriptionID())){
						temp.add(s);
					}else{
						continue;
					}
				}
				sithApplication.setSubscriptions(temp);				
			} else {
				sithAPI.subscribe(sithApplication.getUserID(),
						subscription.getSubscriptionID());
				subscribeButton.setText("Unsubscribe");
				sithApplication.getSubscriptions().add(subscription);
				isSubscribed=true;
			}
		} catch (Exception e) {
			// TODO: handle exception
			progress.dismiss();
			UIutil.showExceptionAlert(SubscriptionInfoActivity.this, e);
		}		
	}
	
	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		switch (item.getItemId()) {
		case android.R.id.home:
			Intent intent = new Intent(SubscriptionInfoActivity.this, MainActivity.class);
			intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
			startActivity(intent);
			return true;
		}
		return true;
	}

}
