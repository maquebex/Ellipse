//
//  MainViewController
//  SampleApp
//
//  Created by Asquith Bailey on 11/13/15.
//  Copyright © 2015 Krumbs. All rights reserved.
//

#import "MainViewController.h"
#import "MyExtensions.h"
#import "MDButton.h"
#import "UIFontHelper.h"
#import "UIView+ScreenShot.h"
#import "UIImageEffects.h"

#define IOS_NAVIGATION_BAR_HEIGHT 44.0f
#define IOS_NAV_STATUS_HEIGHT 64.0f
@interface MainViewController ()

@end

@implementation MainViewController
static MainViewController *singletonVC = nil;

-(id)init
{
    self=[super init];
    if(self)
    {
        [self setupView];
    }
    return self;
}

-(void) setupView
{

    self.navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0f,
                                                                     0.0f,
                                                                     self.view.frame.size.width,
                                                                     IOS_NAV_STATUS_HEIGHT)];
    self.navBar.translucent = YES;
    [self.view addSubview:self.navBar];
    [self.navBar setBarTintColor:[UIColor colorWithRGB:@"E53539" alpha:1.0f]];
    self.hamburgerButton = [[JTHamburgerButton alloc] initWithFrame:CGRectMake(10.0f, IOS_NAV_STATUS_HEIGHT - IOS_NAVIGATION_BAR_HEIGHT, 40.0f, 50.0f)];
    [self.hamburgerButton setTintColor:[UIColor whiteColor]];
    [self.navBar addSubview:self.hamburgerButton];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.hamburgerButton.frame.size.width+self.hamburgerButton.frame.origin.x,
                      self.hamburgerButton.frame.origin.y, 80.0f, IOS_NAVIGATION_BAR_HEIGHT)];
    label.font = [UIFontHelper boldRobotoFontOfSize:18];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"Nagpur";
    [self.navBar addSubview:label];

    
    [self.navBar.superview bringSubviewToFront:self.navBar];

    self.tabBar = [MDTabBar new];
    [self.tabBar setItems:[NSArray arrayWithObjects:@"News",@"Causes",@"Humans", @"Bites", nil]];
    [self.tabBar setBackgroundColor:[UIColor colorWithRGB:@"F4F4F4" alpha:1.0f]];
    [self.tabBar setTextColor:[UIColor colorWithRGB:@"E1363E" alpha:1.0f]];
    [self.tabBar setIndicatorColor:[UIColor colorWithRGB:@"D74D19" alpha:1.0f]];
    [self.tabBar setSelectedIndex:0];
    [self.tabBar setFrame:CGRectMake(0, self.navBar.frame.size.height, self.view.frame.size.width, kMDTabBarHeight)];

    self.createButton = [MDButton new];
    float diam = 65.0f;
    float offset = 0.25*diam;
    CGRect buttonFrame = CGRectMake(self.view.frame.size.width - (diam + offset),
                                    self.view.frame.size.height - (diam + offset), diam, diam);
    [self.createButton setFrame:buttonFrame];
    [self.createButton setType:MDButtonTypeFloatingAction];
    [self.createButton setBackgroundColor:[UIColor colorWithRGB:@"2A69F3" alpha:1.0f]];
    [self.createButton setRippleColor:[UIColor colorWithRGB:@"2A69F3" alpha:1.0f]];
    [self.createButton setTitle:@"+" forState:UIControlStateNormal];
    [self.createButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.createButton.titleLabel.font = [UIFontHelper boldRobotoFontOfSize:30];

    [self.view addSubview:self.tabBar];
    [self.view addSubview:self.createButton];
    
    [self.createButton addTarget:self action:@selector(createButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.popupButtonVC = [[PopupButtonsViewController new] initAtPoint:self.createButton.frame.origin];
}

- (void)createButtonPressed:(MDButton*)button {

    NSLog(@"create Button pressed");
    
    if(!self.blackView) {
        self.blackView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        self.blackView.userInteractionEnabled = YES;
//        UITapGestureRecognizer* tapBackground = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makeSelectorButtonPushed:)];
//        [self.blackView addGestureRecognizer:tapBackground];
    }
    UIImage *backgroundImage = [self.view convertViewToImage];
    
    UIColor *tintColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    UIImage *blurredBackgroundImage = [UIImageEffects imageByApplyingBlurToImage:backgroundImage withRadius:30 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
    
    self.blackView.image = blurredBackgroundImage;
    [self.blackView setContentMode:UIViewContentModeScaleToFill];

    [self.view addSubview:self.blackView];
    self.blackView.alpha = 0.0f;
    
    [UIView animateWithDuration:0.25f
                     animations:^{
                         self.blackView.alpha = 1.0f;
                     } completion:^(BOOL finished) {
                         self.popupButtonVC.blackView = self.blackView;
                         [self presentViewController:self.popupButtonVC animated:YES
                                          completion:nil];

                     }
     ];
    

    
}


+ (MainViewController *) singleton
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
         singletonVC = [[super alloc] init];
    });
    return singletonVC;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
