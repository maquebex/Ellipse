/*
 * Copyright (c) 2016 Krumbs Inc.
 * All rights reserved.
 *
 */
package io.krumbs.sdk.starter;

import android.app.Application;


public class StarterApplication extends Application {

  @Override
  public void onCreate() {
    super.onCreate();
    /*
          KrumbsSDK.initialize(getApplicationContext(), APPLICATION_ID, CLIENT_KEY);
        String userEmail = DeviceUtils.getPrimaryUserID(getApplicationContext());
        KrumbsSDK.registerUser(new KrumbsUser.KrumbsUserBuilder()
                .email(userEmail)
                .firstName(SDK_DEFAULT_USER_FN)
                .lastName(SDK_DEFAULT_USER_SN).build());
        String assetPath = "IntentResourcesCleanIndia";
        try {
            KrumbsSDK.registerIntentCategories(assetPath);
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    */
  }
}
