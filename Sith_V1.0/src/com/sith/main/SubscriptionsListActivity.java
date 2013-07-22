package com.sith.main;

import java.util.List;

import android.app.ListActivity;
import android.app.SearchManager;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.graphics.Typeface;
import android.os.Bundle;
import android.view.ActionMode;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.AdapterView.OnItemLongClickListener;
import android.widget.SearchView;
import android.widget.TextView;
import android.widget.Toast;

import com.sith.list.ListAdapter;
import com.sith.main.util.UIutil;
import com.sith.model.Subscription;

public class SubscriptionsListActivity extends ListActivity {

	protected Object mActionMode;
	public int selectedItem = -1;
	private List<Subscription> subscriptions;
	private TextView textView;
	private SithApplication sithApplication;

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_manage_subscriptions);

		sithApplication = (SithApplication) this.getApplication();
		subscriptions = sithApplication.getSubscriptions();

		// Text view to display if there are no subscriptions
		textView = (TextView) findViewById(R.id.subscriptions_list_info);
		Typeface tf = Typeface.createFromAsset(getAssets(),
				"fonts/Roboto-BoldCondensed.ttf");
		textView.setTypeface(tf);

		updateListView();

		// Fonts
		TextView label = (TextView) findViewById(R.id.Type);
		Typeface tf1 = Typeface.createFromAsset(getAssets(),
				"fonts/Roboto-Medium.ttf");
		label.setTypeface(tf1);

		getListView().setSelector(R.drawable.list_selector);

		getListView().setOnItemLongClickListener(new OnItemLongClickListener() {

			@Override
			public boolean onItemLongClick(AdapterView<?> parent, View view,
					int position, long id) {

				if (mActionMode != null) {
					return false;
				}
				selectedItem = position;

				getListView().setItemChecked(position, true);

				// Start the CAB using the ActionMode.Callback defined above
				mActionMode = SubscriptionsListActivity.this
						.startActionMode(mActionModeCallback);
				view.setSelected(true);
				return true;
			}
		});

		getListView().setOnItemClickListener(new OnItemClickListener() {
			@Override
			public void onItemClick(AdapterView<?> parent, View view,
					int position, long id) {
				Intent intent = new Intent(SubscriptionsListActivity.this,
						SubscriptionInfoActivity.class);
				intent.putExtra("subscriptionID", subscriptions.get(position)
						.getSubscriptionID());
				SubscriptionsListActivity.this.startActivity(intent);
			}
		});

	}

	private void updateListView() {
		if (subscriptions.isEmpty()) {
			textView.setVisibility(View.VISIBLE);
		} else {
			textView.setVisibility(View.GONE);
		}
		String[] values = new String[subscriptions.size()];
		for (int i = 0; i < subscriptions.size(); i++) {
			values[i] = subscriptions.get(i).getSubscriptionName();
		}

		setListAdapter(new ListAdapter(this, values));
	}

	private ActionMode.Callback mActionModeCallback = new ActionMode.Callback() {

		// Called when the action mode is created; startActionMode() was called
		public boolean onCreateActionMode(ActionMode mode, Menu menu) {
			// Inflate a menu resource providing context menu items
			MenuInflater inflater = mode.getMenuInflater();
			// Assumes that you have "contexual.xml" menu resources
			inflater.inflate(R.menu.rowselection, menu);
			return true;
		}

		// Called each time the action mode is shown. Always called after
		// onCreateActionMode, but
		// may be called multiple times if the mode is invalidated.
		public boolean onPrepareActionMode(ActionMode mode, Menu menu) {
			return false; // Return false if nothing is done
		}

		// Called when the user selects a contextual menu item
		@Override
		public boolean onActionItemClicked(ActionMode mode, MenuItem item) {
			switch (item.getItemId()) {
			case R.id.menuitem1_show:
				try {
					// TODO uncomment below line
					SithAPI sithAPI = new SithAPI();
					sithAPI.unSubscribe(sithApplication.getUserID(),
							subscriptions.get(selectedItem).getSubscriptionID());
					if(sithApplication.getCurrentSubcription()!=null && subscriptions.get(selectedItem).getSubscriptionID().equals(sithApplication.getCurrentSubcription().getSubscriptionID())){
						sithApplication.setCurrentSubcription(null);
					}
					subscriptions.remove(selectedItem);
					sithApplication.setSubscriptions(subscriptions);
					Toast.makeText(getBaseContext(),
							"Sucessfully unsubscribed!", Toast.LENGTH_SHORT)
							.show();
					updateListView();
				} catch (Exception e) {
					// TODO
					UIutil.showExceptionAlert(SubscriptionsListActivity.this, e);
				}
				selectedItem = -1;
				mode.finish();
				return true;
			default:
				return false;
			}
		}

		// Called when the user exits the action mode
		public void onDestroyActionMode(ActionMode mode) {
			mActionMode = null;
			getListView().setItemChecked(selectedItem, false);
			selectedItem = -1;

		}

	};

	// @Override
	// protected void onStart() {
	// super(onStart());
	// updateListView();
	// }

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		MenuInflater inflater = getMenuInflater();
		inflater.inflate(R.menu.search_menu, menu);

		// Associate searchable configuration with the SearchView
		SearchManager searchManager = (SearchManager) getSystemService(Context.SEARCH_SERVICE);
		SearchView searchView = (SearchView) menu.findItem(R.id.search)
				.getActionView();
		ComponentName cn = new ComponentName(this, SearchResultsActivity.class);
		searchView.setSearchableInfo(searchManager.getSearchableInfo(cn));

		return true;
	}

}