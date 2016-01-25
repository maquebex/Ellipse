#import <UIKit/UIKit.h>

@interface GradientView : UIView
{
    UIColor* topColor;
    UIColor* bottomColor;
    
    NSMutableDictionary* userInfo;
}

@property (nonatomic, retain) UIColor* topColor;
@property (nonatomic, retain) UIColor* bottomColor;
@property (nonatomic, retain) NSMutableDictionary* userInfo;

@end
