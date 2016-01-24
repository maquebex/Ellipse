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
import android.graphics.Color;


import io.krumbs.sdk.KIntentPanelConfiguration;
import io.krumbs.sdk.KrumbsSDK;
import io.krumbs.sdk.KrumbsUser;


public class StarterApplication extends Application {
    public static final String KRUMBS_SDK_APPLICATION_ID = "io.krumbs.sdk.APPLICATION_ID";
    public static final String KRUMBS_SDK_CLIENT_KEY = "io.krumbs.sdk.CLIENT_KEY";
    public static final String SDK_STARTER_PROJECT_USER_FN = "JohnQ";
    public static final String SDK_STARTER_PROJECT_USER_SN = "Public";

    @Override
    public void onCreate() {
        super.onCreate();

        String appID = getMetadata(getApplicationContext(), KRUMBS_SDK_APPLICATION_ID);
        String clientKey = getMetadata(getApplicationContext(), KRUMBS_SDK_CLIENT_KEY);
        if (appID != null && clientKey != null) {
            KrumbsSDK.initialize(getApplicationContext(), appID, clientKey);

            try {

                // Register the Intent Panel model
                // the emoji image assets will be looked up by name when the KCapture camera is started
                // Make sure to include the images in your resource directory before starting the KCapture
                String assetPath = "IntentResourcesExample";
                KrumbsSDK.registerIntentCategories(assetPath);


                // Configure the IntentPanel View (colors & fonts)
                KIntentPanelConfiguration defaults = KrumbsSDK.getIntentPanelViewConfigurationDefaults();
                KIntentPanelConfiguration.IntentPanelCategoryTextStyle ts = defaults.getIntentPanelCategoryTextStyle();
                ts.setTextColor(Color.YELLOW);
                KIntentPanelConfiguration newDefaults = new KIntentPanelConfiguration.KIntentPanelConfigurationBuilder()
                        .intentPanelBarColor("#029EE1")
                        .intentPanelTextStyle(ts)
                        .build();

                KrumbsSDK.setIntentPanelViewConfigurationDefaults(newDefaults);

                // Register user information (if your app requires login)
                // to improve security on the mediaJSON created.
                String userEmail = DeviceUtils.getPrimaryUserID(getApplicationContext());
                KrumbsSDK.registerUser(new KrumbsUser.KrumbsUserBuilder()
                        .email(userEmail)
                        .firstName(SDK_STARTER_PROJECT_USER_FN)
                        .lastName(SDK_STARTER_PROJECT_USER_SN).build());




            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }

    public String getMetadata(Context context, String name) {
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
