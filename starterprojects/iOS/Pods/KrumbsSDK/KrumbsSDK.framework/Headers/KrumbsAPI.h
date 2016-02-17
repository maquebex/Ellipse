//  KrumbsAPI.h
//  KrumbsSDK
//
//  Copyright © 2016 Krumbs Inc. All rights reserved.
//  Created by Asquith Bailey on 12/19/15.
//
//

#import <Foundation/Foundation.h>
#import "KCaptureViewController.h"
#import "KIntentPanelConfiguration.h"

@class IntentsManager;
@class KrumbsUserInfo;
@class KrumbsEngine;
/*!
 @class KrumbsSDK
 This is the primary interface class for the Krumbs iOS SDK.
 API methods in this class allow you to build applications that utilize "Participatory Sensing"
 to capture moments with multisensory aggregation, and connect this captured data to
 cloud servers for analytics and situation detection.
 <pre>
 // Initialize the API
 KrumbsSDK *ksdk = [KrumbsSDK initWithApplicationID:@"YOUR APPLICATION ID" andClientKey:@"YOUR CLIENT KEY"];
 
 // Register the Intent Category model with JSON files in a NSBundle, and XC AssetBundle with emoji images
 // The AssetBundle can be generated from the SDK tool 'asset-generator'
 [ksdk registerIntentCategories:jsonBundle withAssetResourceName: assetResourceName];

 // Register your user (if you don't have anonymous access)
 [ksdk registerUserWithEmail:emailAddress firstName:fn lastName:sn];

 // Configure the color scheme of the IntentPanel
 IntentPanelConfiguration defaults = [ksdk getIntentPanelViewConfigurationDefaults];
 defaults.intentPanelBarColor = KSDK_RED_PALETTE_COLOR;
 [ksdk setIntentPanelViewConfigurationDefaults:defaults];

 // start the KCapture component in your view controller and register a delegate for callback when complete
 KCaptureViewController* vc = [[KrumbsSDK sharedInstance] startKCaptureViewController];
 vc.delegate = self;
 
 [self presentViewController:vc animated:YES completion:nil];

 // Optionally register for media upload complete notification:
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kCaptureMediaUploadCompleted:)
      name:kCaptureMediaUploadCompletedNotification object:nil];
 
 
 </pre>
 @updated 2016-01-22
 */
@interface KrumbsSDK : NSObject

/*!
 * @brief The main initialization method for the KrumbsSDK.
 * @discussion Use the provided applicationID and clientKey to initialize the SDK.
  e.g.[[KrumbsSDK alloc] initWithApplicationID:<your-app-id> andClientKey:<your-client-key>]
  This will setup the SDK with an anonymous user identity and device ID only.
 * @param applicationID - your application ID
 * @param clientKey - your client key
 * @return the KrumbsSDK initialized for your use
 */
+(id) initWithApplicationID:(NSString *)applicationID andClientKey:(NSString *) clientKey;

/*!
 * @brief Identifies the current user with Krumbs SDK.
 * @discussion If your application collects email and name of user, use this API to register the user's email
  with the SDK. This will act as your unique identifier for this user, for future queries and Krumbs analytics.
 * @param userEmail - email address of your user
 * @param firstName - User first name 
 * @param lastName - User last name
 * @return none
 */
-(void) registerUserWithEmail:(NSString *)userEmail firstName: (NSString *)fn lastName:(NSString *)sn;


/*!
 * @brief Returns the singleton of the KrumbsSDK.
 * @discussion Calling this static method without calling  +initWithApplicationID: will cause an exception to be thrown.
 * @return sharedInstance the shared instance of the KrumbsSDK class
 *
 */
+(KrumbsSDK *) sharedInstance;

/*!
 * @brief Returns the applicationID used to initialize the Krumbs SDK
 * @return applicationID - the registered applicationID
 */
+(NSString *) applicationID;

/*!
 * @brief This shutdown method should be called on app exit to release any resources (e.g internal DB) created by the KrumbsSDK framework.
 */
+(void) shutdown;


-(BOOL) isSDKAuthorized;

/*!
 * @brief Configures the model of the Krumbs SDK K-Intent Panel component
 * @discussion This method is the primary configuration point for the Krumbs K-Intent Panel model and defines the custom Intent Categories and
  Intent Emojis (and location of image resources) to be used during a capture.
  The image resources (XCAsset bundle) can be auto-generated using the SDK tool 'asset-generator' from your 'intent-categories.json' file-set.
 * @param jsonBundle - the name of the resource bundle where the 'intent-categories.json' file can be found.
 * @param assetResourceName - the name of the Asset (XCAssets) resource bundle where the associated images for Intent Emojis can be found
 */
-(void) registerIntentCategories:(NSBundle *)jsonBundle withAssetResourceName: (NSString *)assetResourceName;

/*!
 * @brief Returns the UI configuration settings (defaults) of the K-Intent Panel.
 * @discussion Set values on the returned object, and then call setIntentPanelConfigurationDefaults
  These settings must be applied before the startKCaptureViewController is invoked.
 */
-(KIntentPanelConfiguration *) getIntentPanelViewConfigurationDefaults;

/*!
 * @brief Call this method to apply your changes to the IntentPanel UI
 * @discussion These settings must be applied before the startKCaptureViewController is invoked.
   You can get the SDK defaults with -getIntentPanelViewConfigurationDefaults and then update that object
   to be used in this method.
 * @param panelConfig - the provided panel configuration object.
 */
-(void) setIntentPanelViewConfigurationDefaults: (KIntentPanelConfiguration *)panelConfig;


-(IntentsManager *) intentsManager;

/*!
 * @brief Returns the user info currently registered with the KrumbsSDK shared instance
 * @return registeredUser - the currently registered user (or nil if none registered)
 */
-(KrumbsUserInfo *) registeredUser;



/*!
 * @brief Initialize, starts and returns the K-Capture component ViewController. You must present the returned view controller in
 * order to make the camera visible and start the capture workflow.
 * @discussion 'Starting' this view controller initializes location tracking and other sensors related
 * to the K-Capture component (e.g. reverse geo etc).
 * Location tracking will only be done while the K-Capture is active.
 * When capture is complete, the KCaptureViewController delegate (KCaptureViewControllerDelegate *) will be invoked with results.
 *
 * You must register a KCaptureViewControllerDelegate delegate with the returned ViewController
 * Additionally, when all media (image/audio) file upload to server-side storage is completed
 * a NSNotification will be sent on the topic "K-CaptureMediaUploadCompleted"
 * Note that media upload will occur in the background and retries will happen if network connection is lost.
 * @see KCaptureViewControllerDelegate /@see
 * @return captureController - the ViewController to use for situation capture.
 */
-(KCaptureViewController *) startKCaptureViewController;

/*!
 * @brief Stops any previously started background processing that was started on
 * the 'start' method of the KCaptureViewController
 * @discussion call this method to forcibly stop any background processing being done by the K-Capture component
 * (This does not include background upload of media files)
 */
-(void) stopKCaptureViewController;

@end
