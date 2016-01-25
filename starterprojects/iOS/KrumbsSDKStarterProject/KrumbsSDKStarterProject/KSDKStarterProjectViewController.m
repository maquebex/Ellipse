//
//  KSDKStarterProjectViewController.m
//  Copyright © 2016 Krumbs Inc. All rights reserved.
//

#import "KSDKStarterProjectViewController.h"
#import <KrumbsSDK/KrumbsSDK.h>
extern NSString *const KCaptureControllerImageUrl;

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
didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)captureData {
    self.imageView.image = [captureData objectForKey:KCaptureControllerImageUrl];
    [[KrumbsSDK sharedInstance] stopKCaptureViewController];
}

- (void)captureControllerDidCancel:(KCaptureViewController *)captureController {
    [[KrumbsSDK sharedInstance] stopKCaptureViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
