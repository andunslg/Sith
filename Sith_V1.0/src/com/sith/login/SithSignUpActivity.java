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

public class SithSignUpActivity extends Activity {

	private EditText editTextUserName;
	private EditText editTextPassword;
	private EditText editTextPassword2;
	private AsyncHttpClient client = new AsyncHttpClient();
	private RequestParams requestParams;
	private ProgressDialog progress;
	private SharedPreferences pref;
	private SithApplication sithApplication;
	private String userName;
	private String userPassword;
	private String userPassword2;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_sith_sign_up);

		progress = new ProgressDialog(this);

		pref = this.getSharedPreferences("SITH_PREF", Context.MODE_PRIVATE);
		sithApplication = (SithApplication) getApplication();

		editTextUserName = (EditText) findViewById(R.id.editText_signup_userName);
		editTextPassword = (EditText) findViewById(R.id.editText_signup_password);
		editTextPassword2 = (EditText) findViewById(R.id.editText_signup_password2);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.sith_sign_up, menu);
		return true;
	}

	public void onCLickSignUp(View v) {
		userName = editTextUserName.getText().toString();
		userPassword = editTextPassword.getText().toString();
		userPassword2 = editTextPassword2.getText().toString();
		requestParams = new RequestParams();
		requestParams.put("userName", userName);
		requestParams.put("password", userPassword);

		if (userPassword.equals(userPassword2)) {
			client.post(SithAPI.REGISTER_USER, requestParams,
					new AsyncHttpResponseHandler() {

						@Override
						public void onStart() {
							super.onStart();
							progress.setTitle("Loading");
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
									pref.edit().putBoolean("isFB", false)
											.commit();
									sithApplication.setUserID(userName);
									sithApplication.setFB(false);
									Intent intent = new Intent(
											SithSignUpActivity.this,
											MainActivity.class);
									intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
									startActivity(intent);
								} else {
									UIutil.showAlert(SithSignUpActivity.this,
											"Login Failed",
											"Invalid usename or password");
								}
							} catch (JSONException e) {
								UIutil.showExceptionAlert(
										SithSignUpActivity.this, e);
							}

						}
						
						@Override
						public void onFailure(Throwable arg0, String arg1) {
							UIutil.showExceptionAlert(SithSignUpActivity.this, new Exception(arg0.toString()));
						}

						@Override
						public void onFinish() {
							progress.dismiss();
							super.onFinish();
						}
					});

		} else {
			UIutil.showAlert(SithSignUpActivity.this, "Unable to Sign Up.",
					"Passwords do not match");
		}
	}

}
