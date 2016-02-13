//
//  AppDelegate.m
//  KrumbsSDK
//
//  Copyright © 2016 Krumbs Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "KSDKStarterProjectViewController.h"
#import <KrumbsSDK/KrumbsSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    NSString *appID = @"YOUR_APPLICATION_ID";
    NSString *clientKey = @"YOUR_CLIENT_KEY";
    
    NSString *testEmail = @"starterproject@krumbs.net";
    NSString *testFN = @"JohnQ";
    NSString *testSN = @"Public";
    
    // Initialize the API

    KrumbsSDK *sharedInstance = [KrumbsSDK initWithApplicationID:appID andClientKey:clientKey];

    // Register your user (if you don't have anonymous access)
    [sharedInstance registerUserWithEmail:testEmail firstName:testFN lastName:testSN];
    
    // Register the Intent Category model with JSON files in a NSBundle, and XC AssetBundle with emoji images
    // The AssetBundle can be generated from the SDK tool 'asset-generator'
    [sharedInstance registerIntentCategories:[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"IntentResourcesExample" ofType:@"bundle"]] withAssetResourceName:@"IntentAssetsExample"];
    
    
    // Configure the color scheme of the IntentPanel
    KIntentPanelConfiguration *uiConfig = [[KrumbsSDK sharedInstance] getIntentPanelViewConfigurationDefaults];
    [uiConfig setIntentPanelBarColor:[UIColor colorWithRed:0.008 green:0.620 blue:0.882 alpha:1.00]];
    [uiConfig setIntentPanelBarTextColor:[UIColor yellowColor]];
    
    [[KrumbsSDK sharedInstance] setIntentPanelViewConfigurationDefaults:uiConfig];

    
    self.window=[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    KSDKStarterProjectViewController* vc = [[KSDKStarterProjectViewController alloc] init];
    [[self window] setRootViewController:vc];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  [KrumbsSDK shutdown];
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
