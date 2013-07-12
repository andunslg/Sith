package com.sith.login;

import org.json.JSONException;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.Menu;
import android.view.View;
import android.widget.EditText;

import com.loopj.android.http.AsyncHttpClient;
import com.loopj.android.http.AsyncHttpResponseHandler;
import com.loopj.android.http.RequestParams;
import com.sith.main.MainActivity;
import com.sith.main.R;
import com.sith.main.SithAPI;
import com.sith.main.SithApplication;
import com.sith.main.util.UIutil;
import com.sith.model.Parser;

public class SithLoginActivity extends Activity {

	private EditText editTextUserName;
	private EditText editTextPassword;
	private ProgressDialog progress;
	private SharedPreferences pref;
	private RequestParams requestParams;
	private SithApplication sithApplication;
	private AsyncHttpClient client = new AsyncHttpClient();
	private String userName;
	private String userPassword;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_sith_login);

		progress = new ProgressDialog(this);

		pref = this.getSharedPreferences("SITH_PREF", Context.MODE_PRIVATE);
		sithApplication = (SithApplication) getApplication();

		editTextUserName = (EditText) findViewById(R.id.editText_login_userName);
		editTextPassword = (EditText) findViewById(R.id.editText_login_password);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.sith_login, menu);
		return true;
	}

	public void onClickSithLogin(View v) {
		userName = editTextUserName.getText().toString();
		userPassword = editTextPassword.getText().toString();

		requestParams = new RequestParams();
		requestParams.put("userName", userName);
		requestParams.put("password", userPassword);

		client.post(SithAPI.AUTHENTICATE_USER, requestParams,
				new AsyncHttpResponseHandler() {

					@Override
					public void onStart() {
						super.onStart();
						progress.setTitle("Loggin in");
						progress.setMessage("Please wait....");
						progress.show();
					};

					@Override
					public void onSuccess(String response) {

						try {
							if (Parser.parseResponse(response)) {
								progress.dismiss();
								pref.edit().putString("userID", userName)
										.commit();
								pref.edit().putBoolean("isFB", false).commit();
								sithApplication.setUserID(userName);
								sithApplication.setFB(false);
								Intent intent = new Intent(
										SithLoginActivity.this,
										MainActivity.class);
								startActivity(intent);
								SithLoginActivity.this.finish();
							}else{
								UIutil.showAlert(SithLoginActivity.this, "Login Failed", "Invalid usename or password");
							}
						} catch (JSONException e) {
							UIutil.showExceptionAlert(SithLoginActivity.this, e);
						}

					}
					
					@Override
					public void onFailure(Throwable arg0, String arg1) {
						UIutil.showExceptionAlert(SithLoginActivity.this, new Exception(arg0.toString()));
					}

					@Override
					public void onFinish() {
						progress.dismiss();
						super.onFinish();
					}
				});

	}

	public void onClickFacebook(View v) {
		Intent intent = new Intent(SithLoginActivity.this,
				FBLoginActivity.class);
		intent.putExtra("isConnect", false);
		this.startActivityForResult(intent, 1);
	}

	public void onClickRegister(View v) {
		this.startActivity(new Intent(SithLoginActivity.this,
				SithSignUpActivity.class));
	}

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {

		if (requestCode == 1) {
			if (resultCode == 45) {
				this.finish();

			}
		}
	}

}
