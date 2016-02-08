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
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;

import java.util.Map;

import io.krumbs.sdk.KrumbsSDK;
import io.krumbs.sdk.krumbscapture.KCaptureCompleteListener;


public class MainActivity extends AppCompatActivity {

  private static final String[] PERMISSIONS_LOCATION = {Manifest.permission.ACCESS_COARSE_LOCATION,
          Manifest.permission.ACCESS_FINE_LOCATION};
  private static final int REQUEST_LOCATION = 1;
  private View cameraView;
  private View startCaptureButton;
  private View helloText;
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_main);
    startCaptureButton = findViewById(R.id.kcapturebutton);
    helloText = findViewById(R.id.hello_world);
    cameraView = findViewById(R.id.camera_container);
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
                cameraView.setVisibility(View.VISIBLE);
                startCapture();
            }
        }
    });
  }


  private void startCapture() {
    int containerId = R.id.camera_container;
// SDK usage step 4 - Start the K-Capture component and add a listener to handle returned images and URLs
    KrumbsSDK.startCapture(containerId, this, new KCaptureCompleteListener() {
        @Override
        public void captureCompleted(CompletionState completionState, boolean audioCaptured, Map<String, Object> map) {
            // DEBUG LOG
            if (completionState != null) {
                Log.d("KRUMBS-CALLBACK", completionState.toString());
            }
            if (completionState == CompletionState.CAPTURE_SUCCESS) {
// The local image url for your capture
                String imagePath = (String) map.get(KCaptureCompleteListener.CAPTURE_MEDIA_IMAGE_PATH);
                if (audioCaptured) {
// The local audio url for your capture (if user decided to record audio)
                    String audioPath = (String) map.get(KCaptureCompleteListener.CAPTURE_MEDIA_AUDIO_PATH);
                }
// The mediaJSON url for your capture
                String mediaJSONUrl = (String) map.get(KCaptureCompleteListener.CAPTURE_MEDIA_JSON_URL);
                Log.i("KRUMBS-CALLBACK", mediaJSONUrl + ", " + imagePath);
                cameraView.setVisibility(View.INVISIBLE);
                startCaptureButton.setVisibility(View.VISIBLE);
                helloText.setVisibility(View.VISIBLE);
            } else if (completionState == CompletionState.CAPTURE_CANCELLED ||
                    completionState == CompletionState.SDK_NOT_INITIALIZED) {
                cameraView.setVisibility(View.INVISIBLE);
                startCaptureButton.setVisibility(View.VISIBLE);
                helloText.setVisibility(View.VISIBLE);
            }
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
