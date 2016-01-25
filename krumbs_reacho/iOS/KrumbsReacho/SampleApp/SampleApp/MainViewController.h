//
//  MainViewController
//  SampleApp
//
//  Created by Asquith Bailey on 11/13/15.
//  Copyright © 2015 Krumbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDButton.h"
#import "MDTabBar.h"
#import "JTHamburgerButton.h"
#import "PopupButtonsViewController.h"

@interface MainViewController : UIViewController

@property (nonatomic, retain) MDButton *createButton;

@property (nonatomic, retain) MDTabBar *tabBar;
@property (nonatomic, retain) JTHamburgerButton *hamburgerButton;
@property (nonatomic, retain) PopupButtonsViewController *popupButtonVC;
@property (nonatomic, retain) UINavigationBar *navBar;
@property (nonatomic, strong) UIImageView* blackView;

+ (MainViewController *) singleton;

@end

