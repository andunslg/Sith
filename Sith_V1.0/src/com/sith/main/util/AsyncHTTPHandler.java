package com.sith.main.util;

import java.util.Iterator;
import java.util.Map;

import android.util.Log;

import com.loopj.android.http.AsyncHttpClient;
import com.loopj.android.http.AsyncHttpResponseHandler;
import com.loopj.android.http.RequestParams;

public class AsyncHTTPHandler {

	public void get(String url, Map<String,String> parameters) throws Exception {
		RequestParams requestParams = new RequestParams();
		Iterator<String> iterator=parameters.keySet().iterator();
		while (iterator.hasNext()) {
			String s=iterator.next();
			requestParams.put(s,parameters.get(s));
			
		}

		AsyncHttpClient clientGet = new AsyncHttpClient();
		clientGet.get( url, requestParams, new AsyncHttpResponseHandler() {
			@Override
			public void onSuccess(int statusCode, String content) {
				Log.e("HttpConnection - onSuccess", content);
				super.onSuccess(statusCode, content);
			}

			@Override
			public void onFailure(Throwable error, String content) {
				Log.e("HttpConnection - onFailure", content);
				super.onFailure(error, content);
			}

			@Override
			public void onFailure(Throwable e) {
				Log.e("HttpConnection - onFailure", "OnFailure!", e);
			}

			// @Override
			// public void onFailure(Throwable e, JSONArray errorResponse) {
			// Log.e("HttpConnection - onFailure", "OnFailure!", e);
			// }
		});
	}

	public void post(String url, Map<String,String> parameters) throws Exception {

		RequestParams requestParams = new RequestParams();
		Iterator<String> iterator=parameters.keySet().iterator();
		while (iterator.hasNext()) {
			String s=iterator.next();
			requestParams.put(s,parameters.get(s));
			
		}

		AsyncHttpClient clientPost = new AsyncHttpClient();
		clientPost.post(url, requestParams,
				new AsyncHttpResponseHandler() {
					@Override
					public void onSuccess(int statusCode, String content) {
						Log.e("HttpConnection - onSuccess", content);
						super.onSuccess(statusCode, content);
					}

					@Override
					public void onFailure(Throwable error, String content) {
						Log.e("HttpConnection - onFailure", content);
						super.onFailure(error, content);
					}

					@Override
					public void onFailure(Throwable e) {
						Log.e("HttpConnection - onFailure", e.toString());
//						super.onFailure(e);
					}

					// @Override
					// public void onFailure(Throwable e, JSONArray
					// errorResponse) {
					// Log.e("HttpConnection - onFailure", "OnFailure!", e);
					// }
				});

	}

}
