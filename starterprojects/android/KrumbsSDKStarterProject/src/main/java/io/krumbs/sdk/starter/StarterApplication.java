/*
 * Copyright (c) 2016 Krumbs Inc.
 * All rights reserved.
 *
 */
package io.krumbs.sdk.starter;

import android.app.Application;
import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;

import java.io.IOException;

import io.krumbs.sdk.KrumbsSDK;


public class StarterApplication extends Application {
    public static final String KRUMBS_SDK_APPLICATION_ID = "io.krumbs.sdk.APPLICATION_ID";
    public static final String KRUMBS_SDK_CLIENT_KEY = "io.krumbs.sdk.CLIENT_KEY";

    @Override
    public void onCreate() {
        super.onCreate();

        String appID = StarterApplication.getMetadata(getApplicationContext(), KRUMBS_SDK_APPLICATION_ID);
        String clientKey = StarterApplication.getMetadata(getApplicationContext(), KRUMBS_SDK_CLIENT_KEY);
        if (appID != null && clientKey != null) {
            KrumbsSDK.initialize(getApplicationContext(), appID, clientKey);

            String assetPath = "IntentResourcesExample";
            try {
                KrumbsSDK.registerIntentCategories(assetPath);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

    }

    public static String getMetadata(Context context, String name) {
        try {
            ApplicationInfo appInfo = context.getPackageManager().getApplicationInfo(
                    context.getPackageName(), PackageManager.GET_META_DATA);
            if (appInfo.metaData != null) {
                return appInfo.metaData.getString(name);
            }
        } catch (PackageManager.NameNotFoundException e) {
// if we can’t find it in the manifest, just return null
        }

        return null;
    }


}
