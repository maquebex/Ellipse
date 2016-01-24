/*
 * Copyright (c) 2016 Krumbs Inc
 * All rights reserved.
 *
 */
package io.krumbs.sdk.starter;

import android.Manifest;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.support.v4.app.ActivityCompat;
import android.support.v4.content.ContextCompat;
import android.support.v7.app.AppCompatActivity;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewManager;

import java.util.Map;

import io.krumbs.sdk.KrumbsSDK;
import io.krumbs.sdk.krumbscapture.KCaptureCompleteListener;


public class MainActivity extends AppCompatActivity {

  private static final String[] PERMISSIONS_LOCATION = {Manifest.permission.ACCESS_COARSE_LOCATION,
          Manifest.permission.ACCESS_FINE_LOCATION};
  private static final int REQUEST_LOCATION = 1;
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_main);
    final View startCaptureButton = findViewById(R.id.kcapturebutton);
    final View helloText = findViewById(R.id.hello_world);
    startCaptureButton.setOnClickListener(new View.OnClickListener() {
      @Override
      public void onClick(View view) {
//        NavUtils.navigateUpFromSameTask(MainActivity.this);
        if (ContextCompat.checkSelfPermission(MainActivity.this,
                Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED
                || ContextCompat.checkSelfPermission(MainActivity.this,
                Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
          requestLocationPermission();
        } else {
          startCaptureButton.setVisibility(View.INVISIBLE);
          helloText.setVisibility(View.INVISIBLE);
          startCamera();
        }
      }
    });
  }


  private void startCamera() {
    int containerId = R.id.camera_container;
    KrumbsSDK.startCapture(containerId, this, new KCaptureCompleteListener() {
      @Override
      public void captureCompleted(CompletionState completionState, boolean b, Map<String, Object> map) {
        View cameraView = findViewById(R.id.camera_container);

      }
    });
  }

  private void requestLocationPermission() {
    ActivityCompat.requestPermissions(this, PERMISSIONS_LOCATION, REQUEST_LOCATION);
  }

  @Override
  public boolean onCreateOptionsMenu(Menu menu) {
    // Inflate the menu; this adds items to the action bar if it is present.
    getMenuInflater().inflate(R.menu.menu_main, menu);
    return true;
  }

  @Override
  public boolean onOptionsItemSelected(MenuItem item) {
    // Handle action bar item clicks here. The action bar will
    // automatically handle clicks on the Home/Up button, so long
    // as you specify a parent activity in AndroidManifest.xml.
    int id = item.getItemId();

    //noinspection SimplifiableIfStatement
    if (id == R.id.action_settings) {
      return true;
    }

    return super.onOptionsItemSelected(item);
  }
}
