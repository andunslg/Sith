package com.sith.main;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONException;

import android.app.ListActivity;
import android.app.ProgressDialog;
import android.app.SearchManager;
import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ListView;

import com.loopj.android.http.AsyncHttpClient;
import com.loopj.android.http.AsyncHttpResponseHandler;
import com.sith.list.ListAdapter;
import com.sith.main.util.UIutil;
import com.sith.model.Parser;

public class SearchResultsActivity extends ListActivity {

	private AsyncHttpClient client = new AsyncHttpClient();
	private ProgressDialog progress;
	private List<String> subcriptionIDs = new ArrayList<String>();
	private List<String> subcriptionNames = new ArrayList<String>();
	private List<String> unfilteredSubcriptionIDs = new ArrayList<String>();
	private List<String> unfilteredSubcriptionNames = new ArrayList<String>();
	private String[] results;
	private String query;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		handleIntent(getIntent());

		progress = new ProgressDialog(this);
	}

//	@Override
//	protected void onNewIntent(Intent intent) {
//		setIntent(intent);
////		handleIntent(intent);
//	}

	@Override
	public void onListItemClick(ListView l, View v, int position, long id) {

		Intent intent = new Intent(SearchResultsActivity.this,
				SubscriptionInfoActivity.class);
		intent.putExtra("subscriptionID", subcriptionIDs.get(position));

		SearchResultsActivity.this.startActivity(intent);
	}

	private void handleIntent(Intent intent) {

		if (Intent.ACTION_SEARCH.equals(intent.getAction())) {
			// TODO improve
			query = intent.getStringExtra(SearchManager.QUERY);
			client.get(SithAPI.SEARCH, new AsyncHttpResponseHandler() {

				@Override
				public void onStart() {
					super.onStart();
					progress.setTitle("Loading");
					progress.setMessage("Getting results....");
					progress.show();
				};

				@Override
				public void onSuccess(String response) {
					try {
						unfilteredSubcriptionIDs = Parser.parseList(response,
								"eventID");
						unfilteredSubcriptionNames = Parser.parseList(response,
								"eventName");
					} catch (JSONException e) {
						// TODO
						progress.dismiss();
						UIutil.showExceptionAlert(SearchResultsActivity.this, e);
					}
				}

				@Override
				public void onFinish() {
					super.onFinish();

					for (int i = 0; i < unfilteredSubcriptionNames.size(); i++) {
						String temp = unfilteredSubcriptionNames.get(i);
						if (org.apache.commons.lang3.StringUtils
								.containsIgnoreCase(temp, query)) {
							subcriptionIDs.add(unfilteredSubcriptionIDs.get(i));
							subcriptionNames.add(unfilteredSubcriptionNames
									.get(i));
						}
					}
					results = new String[subcriptionNames.size()];
					for (int i = 0; i < subcriptionNames.size(); i++) {
						results[i] = subcriptionNames.get(i);
					}
					setListAdapter(new ListAdapter(SearchResultsActivity.this,
							results));
					progress.dismiss();

					if (results.length == 0) {
						UIutil.showAlert(
								SearchResultsActivity.this,
								"No matches",
								"We could not find any events matches to your query. Please try a different one",
								new OnClickListener() {

									@Override
									public void onClick(DialogInterface dialog,
											int which) {
										SearchResultsActivity.this.finish();

									}
								});
					}

				}
			});

		}
	}

}
