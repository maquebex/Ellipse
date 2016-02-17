//
//  KCaptureViewController.h
//  KrumbsSDK
//
//  Created by Jeremy Levine on 12/5/15.
//  Copyright © 2016 Krumbs Inc. All rights reserved.
//


#import <UIKit/UIKit.h>

/*!
 *@class KCaptureViewController
 This class is the ViewController that manages the Krumbs SDK K-Capture component.
 You get an instance of this controller from the KrumbsSDK sharedInstance
 The KCaptureViewControllerDelegate
 *
 */
@class KCaptureViewController;

typedef enum {
    kCameraDirectionNone = -1,
    kCameraDirectionBack,
    kCameraDirectionFront,
} kCameraDirection;

typedef enum {
    kSDKNotInitialized = -1,
    kCaptureSuccess,
    kCaptureCancelled
} kCaptureCompletionState;

extern NSString *const KCaptureControllerImageUrl;
extern NSString *const KCaptureControllerMediaJsonUrl;
extern NSString *const KCaptureControllerCompletionState;
extern NSString *kCaptureMediaUploadCompletedNotification;

/*!
 *@class KCaptureViewControllerDelegate
 This is the delegate interface of the KCaptureViewController
 Implement this delegate to receive a callback when capture is completed
 *
 */
@protocol KCaptureViewControllerDelegate <NSObject>
/*!
 * @brief The success callback method of the KCaptureViewControllerDelegate
 * @discussion  The returned NSDictionary will contain several keys with the captured data
        <pre>
              KCaptureControllerImageUrl  => Local image url of captured photo. It is already saved to the camera roll
              KCaptureControllerAudioUrl  => If Audio was captured, this is the local audio file url
              KCaptureControllerMediaJsonUrl => The URL of the mediaJSON that is created for your capture. The associated media files may not be available until you receive the UploadCompleted notification message from the KrumbsSDK
        </pre>
 */
-(void)captureController:(KCaptureViewController*)captureController didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id>*) media;

/*!
   @brief The cancel callback method of the KCaptureViewControllerDelegate. This method is called when the user cancelled capture.
   @discussion No data is returned in this callback. It is signal for you to dismiss the camera. The user has decided not to capture any data.
 */
- (void)captureControllerDidCancel:(KCaptureViewController *)captureController;


@end

/*!
 *@class KCaptureViewController
 This KCaptureViewController is the class that initiates capture via the K-Intent Panel and displays the camera view.
 It provides an image preview workflow, audio recording capability, and editing of the smart caption that is associated with the capture.
 Implement the delegate (KCaptureViewControllerDelegate) to receive a callback when capture is completed
 *
 */
@interface KCaptureViewController : UIViewController

/*!
  @brief set this property to receive callback. If unset, no callback will be invoked when the camera is done.
 */
@property (nonatomic, weak) NSObject<KCaptureViewControllerDelegate>* delegate;
-(void) shutdown;
@end
