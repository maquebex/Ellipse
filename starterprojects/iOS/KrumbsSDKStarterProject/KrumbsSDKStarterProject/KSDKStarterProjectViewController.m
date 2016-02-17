//
//  KSDKStarterProjectViewController.m
//  Copyright © 2016 Krumbs Inc. All rights reserved.
//

#import "KSDKStarterProjectViewController.h"
#import <KrumbsSDK/KrumbsSDK.h>
extern NSString *const KCaptureControllerImageUrl;
extern NSString *const KCaptureControllerAudioUrl;
extern NSString *const KCaptureControllerMediaJsonUrl;
extern NSString *const KCaptureControllerIsAudioCaptured;

@interface KSDKStarterProjectViewController () <KCaptureViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation KSDKStarterProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)takePhotoTapped:(id)sender {
    
    
    // start the KCapture component in your view controller and register a delegate for callback when complete
    KCaptureViewController* vc = [[KrumbsSDK sharedInstance] startKCaptureViewController];
    vc.delegate = self;
    
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (void) captureController:(KCaptureViewController *)captureController
didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)media {
    self.imageView.image = [media objectForKey:KCaptureControllerImageUrl];
    NSURL *mediaJsonUrl = [media objectForKey:KCaptureControllerMediaJsonUrl];
    NSLog(@"MediaJSONUrl: %@",mediaJsonUrl);
    BOOL audioWasCaptured = [(NSString *)[media objectForKey:KCaptureControllerIsAudioCaptured] boolValue];
    NSLog(@"Audio was captured: %d",audioWasCaptured);
    if(audioWasCaptured) {
        NSURL *localAudioUrl = [media objectForKey:KCaptureControllerAudioUrl];
        NSLog(@"Local Audio Url: %@",localAudioUrl);
    }
    kCaptureCompletionState completionState = [(NSString *)[media objectForKey:KCaptureControllerCompletionState] intValue];
    NSLog(@"Capture Completion state: %d",completionState);
}

- (void)captureControllerDidCancel:(KCaptureViewController *)captureController {
    NSLog(@"User cancelled capture!");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
