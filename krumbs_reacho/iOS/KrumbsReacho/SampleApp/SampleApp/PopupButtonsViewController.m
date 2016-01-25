//
//  PopupButtonsViewController.m
//  SampleApp
//
//  Created by Asquith Bailey on 11/24/15.
//  Copyright © 2015 Krumbs. All rights reserved.
//

#import "PopupButtonsViewController.h"
#import "FAKFontAwesome.h"
#import "UIFontHelper.h"
#import "MyExtensions.h"

@interface PopupButtonsViewController ()

@end

@implementation PopupButtonsViewController

-(id) initAtPoint: (CGPoint) pos {
    self = [super init];
    if(self) {
        self.basePoint = pos;
        self.menuButtons = [[NSMutableArray alloc ]init];
    }
    return self;
}


-(UIView *) makeButtonView:(NSString *)title withIcon: (FAKFontAwesome *)faIcon
           backgroundColor: (UIColor *)backColor
                   yOffset: (CGFloat) yPos
{
    UIView *buttonContainer = [[UIView new] init];
    buttonContainer.userInteractionEnabled = YES;

    MDButton *but = [MDButton new];
    float diam = 50.0f;
    CGPoint pos = self.basePoint;
    CGRect buttonFrame = CGRectMake(pos.x, pos.y - yPos, diam, diam);
    [but setFrame:buttonFrame];
    [but setType:MDButtonTypeFloatingAction];
    [but setBackgroundColor:backColor];
    [but setRippleColor:backColor];
    [faIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
    UIImage *buttonIcon = [[faIcon imageWithSize:CGSizeMake(20, 20)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [but setImageNormal:buttonIcon];
    

//    but.userInteractionEnabled = YES;
//    but.layer.borderColor = [UIColor blueColor].CGColor;
//    but.layer.borderWidth = 1.0;
//    but.clipsToBounds = NO;
    
    [but addTarget:self action:@selector(actionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [buttonContainer addSubview:but];

    UILabel *butCaption = [[UILabel new] init];
    UIFont *txtFont = [UIFontHelper robotoFontOfSize:36];
    [butCaption setText:title];
    [butCaption setTextAlignment:NSTextAlignmentRight];
    [butCaption setTextColor:[UIColor whiteColor]];
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName: txtFont}];
    float offset = 10.0f;
    CGRect labelFrame = CGRectMake(pos.x - (titleSize.width + offset), pos.y - yPos, titleSize.width, titleSize.height);
    [butCaption setFrame:labelFrame];
//    butCaption.userInteractionEnabled = NO;
//    butCaption.layer.borderColor = [UIColor redColor].CGColor;
//    butCaption.layer.borderWidth = 1.0;
//    butCaption.clipsToBounds = NO;
    [buttonContainer addSubview:butCaption];
    
    [buttonContainer setFrame:CGRectMake(labelFrame.origin.x, labelFrame.origin.y,
                                         labelFrame.size.width+ buttonFrame.size.width + offset,
                                         buttonFrame.size.height)];
    buttonContainer.layer.borderColor = [UIColor greenColor].CGColor;
    buttonContainer.layer.borderWidth = 1.0;
    buttonContainer.clipsToBounds = NO;
   
    

//    return buttonContainer;
    return but;
}

- (void)actionButtonPressed:(MDButton*)button {
//    NSLog(@"action Button pressed");

    if(self.blackView != nil) {
        [self.blackView removeFromSuperview];
        self.blackView = nil;
    }
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"CreateItem" bundle:nil] instantiateViewControllerWithIdentifier:@"CreateItemViewController"];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    switch(button.tag) {
        case 0:
            NSLog(@"Humans");
            break;
        case 1:
            NSLog(@"News");
            break;
        case 2:
            NSLog(@"Causes");
            break;
        case 3:
            NSLog(@"Jobs");
            break;
        case 4:
            NSLog(@"Bites");
            break;
        default:
            NSLog(@"unknown button!");
    }
    [self.presentingViewController presentViewController:vc animated:YES completion:nil];

}

- (void)createCloseButtonPressed:(MDButton*)button {
    
//    NSLog(@"close Button pressed");

    if([button isRotated] == NO)
    [button setRotated:YES];
    else {
        [button setRotated:NO];
    }
}

-(void) setupView {

    self.createCloseButton = [MDButton new];
    float diam = 65.0f;
    float offset = 0.25*diam;
    CGRect buttonFrame = CGRectMake(self.view.frame.size.width - (diam + offset),
                                    self.view.frame.size.height - (diam + offset), diam, diam);
    [self.createCloseButton setFrame:buttonFrame];
    [self.createCloseButton setType:MDButtonTypeFloatingAction];
    [self.createCloseButton setBackgroundColor:[UIColor colorWithRGB:@"2A69F3" alpha:1.0f]];
    [self.createCloseButton setRippleColor:[UIColor colorWithRGB:@"2A69F3" alpha:1.0f]];
    FAKIcon *faIcon = [FAKFontAwesome closeIconWithSize:30.0f];
    [faIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
    UIImage *buttonIcon = [[faIcon imageWithSize:CGSizeMake(30, 30)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.createCloseButton setImageRotated:buttonIcon];

    faIcon = [FAKFontAwesome plusIconWithSize:30.0f];
    [faIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
    buttonIcon = [[faIcon imageWithSize:CGSizeMake(30, 30)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.createCloseButton setImageNormal:buttonIcon];

    self.createCloseButton.mdButtonDelegate = self;
//    [self.createCloseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    self.createCloseButton.titleLabel.font = [UIFontHelper boldRobotoFontOfSize:30];
    
    [self.view addSubview:self.createCloseButton];
    [self createMenuButtons];
    [self.createCloseButton setRotated:YES]; // spin out initially
    
    [self.createCloseButton addTarget:self action:@selector(createCloseButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void) createMenuButtons {
    int numButtons = 5;
    NSArray *buttonTitles = [NSArray arrayWithObjects:@"Humans",@"News",@"Causes",@"Jobs",@"Bites", nil];
    float iconSize = 20.0f;
    NSArray *buttonIcons = [NSArray arrayWithObjects:
                            [FAKFontAwesome usersIconWithSize:iconSize], // Humans
                            [FAKFontAwesome newspaperOIconWithSize:iconSize], // News
                            [FAKFontAwesome handODownIconWithSize:iconSize], // Causes
                            [FAKFontAwesome briefcaseIconWithSize:iconSize], // Jobs
                            [FAKFontAwesome spoonIconWithSize:iconSize], // Bites
                            nil];
    NSArray *buttonColors = [NSArray arrayWithObjects:
                             [UIColor colorWithRGB:@"25AC86" alpha:1.0f], //Humans
                             [UIColor colorWithRGB:@"885B83" alpha:1.0f], // News
                             [UIColor colorWithRGB:@"FC8944" alpha:1.0f], // Causes
                             [UIColor colorWithRGB:@"D4B354" alpha:1.0f], // Jobs
                             [UIColor colorWithRGB:@"FB4D4E" alpha:1.0f], // Bites
                             nil];
    
    float baseOffset = 80.0f;
    for(int i = 0; i < numButtons; i++) {
        float yDelta = 70.0f;
        UIView *buttonContainer = [self makeButtonView:(NSString *)[buttonTitles objectAtIndex:i]
                                              withIcon:[buttonIcons objectAtIndex:i]
                                       backgroundColor:[buttonColors objectAtIndex:i] yOffset:(yDelta * i)+baseOffset];
        buttonContainer.alpha = 0.0f; // make initially hidden
        buttonContainer.tag = i;
        [self.menuButtons insertObject:buttonContainer atIndex:i];
        [self.view addSubview:buttonContainer];
    }

}

-(void) displayMenuButtons: (BOOL) show
{
    float alpha = 1.0f;
    if(show == YES)
        alpha = 1.0f;
    else
        alpha = 0.0f;

    for(int i=0; i < [self.menuButtons count]; i++ ){
        UIView *bc = [self.menuButtons objectAtIndex:i];
        bc.alpha = alpha;
    }

}

#pragma MDButtonDelegate
-(void)rotationStarted:(id)sender {
    
}

-(void)rotationCompleted:(id)sender {
    // create and hide buttons ready for animation

    MDButton *but = sender;
    if([but isRotated] == YES) {
        [self displayMenuButtons: YES];
    }
    else {
        [self displayMenuButtons: NO];
    }


}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(self.blackView == nil) {
        self.blackView = self.view;
    }
    else {
        [self.view addSubview:self.blackView];
    }
    
    [self setupView];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    NSLog(@"Popupbuttons view will appear");
    if(self.blackView != nil && ![self.blackView isDescendantOfView:self.view]) {
//        NSLog(@"blackView not added to this view");
       [self.view addSubview:self.blackView];
       [self.view sendSubviewToBack:self.blackView];
    }
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
