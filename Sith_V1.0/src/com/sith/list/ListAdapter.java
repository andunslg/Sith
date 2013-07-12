package com.sith.list;

import com.sith.main.R;

import android.app.Activity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;

public class ListAdapter extends ArrayAdapter<String> {
	private final Activity context;
	private final String[] names;

	static class ViewHolder {
		public TextView text;
		public ImageView image;
	}

	public ListAdapter(Activity context, String[] names) {
		super(context, R.layout.list_item_subscriptions, names);
		this.context = context;
		this.names = names;
	}

	@Override
	public View getView(int position, View convertView, ViewGroup parent) {
		View rowView = convertView;
		if (rowView == null) {
			LayoutInflater inflater = context.getLayoutInflater();
			rowView = inflater.inflate(R.layout.list_item_subscriptions, null);
			ViewHolder viewHolder = new ViewHolder();
			viewHolder.text = (TextView) rowView
					.findViewById(R.id.subscription_list_text);
			viewHolder.image = (ImageView) rowView
					.findViewById(R.id.subscription_list_icon);
			rowView.setTag(viewHolder);
		}

		ViewHolder holder = (ViewHolder) rowView.getTag();
		String s = names[position];
		holder.text.setText(s);
		holder.image.setImageResource(R.drawable.ic_launcher);

		return rowView;
	}
}