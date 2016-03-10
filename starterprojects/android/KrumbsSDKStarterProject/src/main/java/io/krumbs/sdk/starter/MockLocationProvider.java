package io.krumbs.sdk.starter;

import android.content.Context;
import android.location.Location;
import android.location.LocationManager;
import android.os.Build;
import android.os.SystemClock;

/**
 * Created by phani on 3/10/16.
 */

/* Picked from "https://github.com/joninvski/android_content_provider/blob/master/ContentProviderLabUser/src/main/java/course/labs/contentproviderlab/MockLocationProvider.java" */
public class MockLocationProvider {
    private String mProviderName;
    private LocationManager mLocationManager;

    private static float mockAccuracy = 5;

    public MockLocationProvider(String name, Context ctx) {
        this.mProviderName = name;

        mLocationManager = (LocationManager) ctx
                .getSystemService(Context.LOCATION_SERVICE);
        mLocationManager.addTestProvider(mProviderName, false, false, false,
                false, true, true, true, 0, 5);
        mLocationManager.setTestProviderEnabled(mProviderName, true);
    }

    public void pushLocation(double lat, double lon) {

        Location mockLocation = new Location(mProviderName);
        mockLocation.setLatitude(lat);
        mockLocation.setLongitude(lon);
        mockLocation.setAltitude(0);
        mockLocation.setTime(System.currentTimeMillis());
        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.JELLY_BEAN) {
            mockLocation.setElapsedRealtimeNanos(SystemClock.elapsedRealtimeNanos());
            //mockLocation.makeComplete();
        }
        //mockLocation.setElapsedRealtimeNanos(SystemClock.elapsedRealtimeNanos());
        mockLocation.setAccuracy(mockAccuracy);

        mLocationManager.setTestProviderLocation(mProviderName, mockLocation);

    }

    public void shutdown() {
        mLocationManager.removeTestProvider(mProviderName);
    }
}