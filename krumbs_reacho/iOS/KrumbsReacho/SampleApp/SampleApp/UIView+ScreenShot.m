
#import "UIView+ScreenShot.h"



@implementation UIView (ScreenShot)
-(UIImage *)convertViewToImage
{
    UIGraphicsBeginImageContext(self.bounds.size);
//    CGFloat reductionFactor = 1;
//    UIGraphicsBeginImageContext(CGSizeMake(self.frame.size.width/reductionFactor, self.frame.size.height/reductionFactor));
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
