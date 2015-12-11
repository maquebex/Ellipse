//
//  PopupButtonsViewController.h
//  SampleApp
//
//  Created by Asquith Bailey on 11/24/15.
//  Copyright © 2015 Krumbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDButton.h"
@interface PopupButtonsViewController : UIViewController<MDButtonDelegate>
@property (nonatomic) CGPoint basePoint;
@property (nonatomic, weak) UIView* blackView;
@property (nonatomic, retain) MDButton *createCloseButton;
@property (nonatomic, retain) NSMutableArray *menuButtons;

-(id) initAtPoint: (CGPoint)base;

@end
