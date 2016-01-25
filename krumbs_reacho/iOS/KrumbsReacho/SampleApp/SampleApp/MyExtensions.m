#import "MyExtensions.h"
#import <QuartzCore/QuartzCore.h>
#import <CommonCrypto/CommonDigest.h> // Need to import for CC_MD5 access
#import "GradientView.h"

@implementation NSObject (MyExtensions)

- (NSString*)uniqueID
{
    return [NSString stringWithFormat:@"%d", [self hash]];
}

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay
{
    int64_t delta = (int64_t)(1.0e9 * delay);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delta), dispatch_get_main_queue(), block);
}

@end

@implementation NSString (MyExtensions)
- (NSString *) md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], 
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];  
}

- (BOOL)startsWith:(NSString*)prefix
{
    return [[self substringToIndex:(int)MIN(prefix.length, self.length)] isEqualToString:prefix];
}

- (NSString*)urlEncode
{
    NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                   NULL,
                                                                                   (CFStringRef)self,
                                                                                   NULL,
                                                                                   (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                   kCFStringEncodingUTF8 ));
    return encodedString;
}

- (NSString*)quotifiedString
{
    NSString* copy = [self copy];
    return [NSString stringWithFormat:@"\"%@\"", copy];
}

- (NSString*)unquotifiedString
{
    NSString* res = [self copy];
    res = [res trimmedString];
    while([res  startsWith:@"\""])
        res = [res substringFromIndex:1];
    while([[res substringWithRange:NSMakeRange(res.length-1, 1)] isEqualToString:@"\""])
        res = [res substringToIndex:res.length-1];
    if([res isEqualToString:@"\""] || [res isEqualToString:@"\"\""])
        res = @"";
    return res;
        
}

- (NSString*)trimmedString
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)matchesRegex:(NSString *)pattern
{
    /*NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    if(regex == nil || error) {
        return NO;
    }
    
    NSUInteger n = [regex numberOfMatchesInString:self options:0 range:NSMakeRange(0, [self length])];
    if(n == 1)
        NSLog(@"%@ matches %@", pattern, self);
    return n == 1;*/
    
    BOOL match = [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern] evaluateWithObject:self];
    if(!match)
        NSLog(@"%@ does not match %@", pattern, self);
    
    return match;
}

- (BOOL)isValidEmailAddress {
    NSString* emailRegex = @"[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-z0-9])?\\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?";
    return [self matchesRegex:emailRegex];
}

@end

@implementation NSData (MyExtensions)
- (NSString*)md5
{
    unsigned char result[16];
    CC_MD5( self.bytes, self.length, result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], 
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];  
}
@end

@implementation UIView (MyExtensions)
- (void)perspectiveReset
{
    CALayer *layer = self.layer;
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 0.0;
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 0.0 * M_PI / 180.0f, 1.0, 0.0, 0.0);
    layer.transform = rotationAndPerspectiveTransform;
}

- (void)perspectiveRotate:(double)degrees X:(double)x Y:(double)y Z:(double)z
{
    CALayer *layer = self.layer;
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1.0 / -500;
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, degrees * M_PI / 180.0f, x, y, z);
    layer.transform = rotationAndPerspectiveTransform;
}

+ (CGPoint) originInScreenCoordinates:(UIView *)view
{
    double x = 0;
    double y = 0;
    while(view != nil)
    {
        x += view.frame.origin.x;
        y += view.frame.origin.y;
        view = view.superview;
    }
    return CGPointMake(x, y);
}

- (CGPoint) coordinateOffsetFromView:(UIView *)fromView toView:(UIView *)toView
{
    CGPoint fromViewUniversalOrigin = [UIView originInScreenCoordinates:fromView];
    CGPoint toViewUniversalOrigin = [UIView originInScreenCoordinates:toView];
    CGPoint offset = CGPointMake(toViewUniversalOrigin.x - fromViewUniversalOrigin.x,
                                 toViewUniversalOrigin.y - fromViewUniversalOrigin.y);
    return offset;
}

+ (CGPoint) coordinateOffsetFromView:(UIView *)fromView toView:(UIView *)toView
{
    CGPoint fromViewUniversalOrigin = [UIView originInScreenCoordinates:fromView];
    CGPoint toViewUniversalOrigin = [UIView originInScreenCoordinates:toView];
    CGPoint offset = CGPointMake(toViewUniversalOrigin.x - fromViewUniversalOrigin.x,
                                 toViewUniversalOrigin.y - fromViewUniversalOrigin.y);
    return offset;
}

-(void)convertAndAddItemAsSubview:(UIView*)item
{
    CGPoint offset = [UIView coordinateOffsetFromView:item.superview toView:self];
    UIView* superview = self.superview;
    float dx = 0;
    float dy = 0;
    while(superview != nil)
    {
        if([superview isKindOfClass:[UIScrollView class]])
        {
            dx += ((UIScrollView*)superview).contentOffset.x;
            dy += ((UIScrollView*)superview).contentOffset.y;
        }
        superview = superview.superview;
    }
    item.center = CGPointMake(item.center.x - offset.x + dx, item.center.y - offset.y + dy);
    [self addSubview:item];
}

-(UIView*)getDragReceiverForItem:(UIView*)item
{
    for(int i = [self.subviews count]-1; i >= 0; i--)
    {
        UIView* view = [self.subviews objectAtIndex:i];
        if(view != item)
        {
            CGPoint localOrigin = [UIView coordinateOffsetFromView:item.superview toView:view];
            if([self.superview isKindOfClass:[UIScrollView class]])
            {
                localOrigin = CGPointMake(localOrigin.x - ((UIScrollView*)self.superview).contentOffset.x, localOrigin.y - ((UIScrollView*)self.superview).contentOffset.y);
            }
            if(CGRectContainsPoint(CGRectMake(localOrigin.x, localOrigin.y, view.frame.size.width, view.frame.size.height), item.center))
            {
                return [view getDragReceiverForItem:item];
            }
        }
    }
    return nil;
}

- (UIImage*)toImage
{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, [[UIScreen mainScreen] scale]);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void)showFrameWithColor:(UIColor*)color
{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = 2.0;
}

-(void)hideFrame
{
    self.layer.borderColor = [UIColor clearColor].CGColor;
    self.layer.borderWidth = 0.0;
}

-(UIViewController*)findFirstViewController:(UIViewController*)vc {
    
    if (vc.presentedViewController) {
        
        return [self findFirstViewController:vc.presentedViewController];
        
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findFirstViewController:svc.viewControllers.lastObject];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findFirstViewController:svc.topViewController];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        
        UITabBarController* svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findFirstViewController:svc.selectedViewController];
        else
            return vc;
        
    } else {
        
        return vc;
    }
    
}

- (UIViewController *) firstAvailableUIViewController {
    // convenience function for casting and to "mask" the recursive function
    UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self findFirstViewController:viewController];
}

- (id) traverseResponderChainForUIViewController {
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [nextResponder traverseResponderChainForUIViewController];
    } else {
        return nil;
    }
}

-(void)printViewHierarchyToDepth:(NSInteger)depth
{
    [self printViewHierarchyHelperStart:0 max:depth];
}

-(void)printViewHierarchyHelperStart:(NSInteger)start max:(NSInteger)max
{
    NSString* indent = @"";
    for(int i = 0; i < start; i++)
        indent = [NSString stringWithFormat:@"----%@", indent];
    NSLog(@"%@%@", indent, self);
    
    if(start == max || [self.subviews count] == 0)
        return;
    
    for(UIView* subview in self.subviews)
        [subview printViewHierarchyHelperStart:start+1 max:max];
}

-(void)setBackgroundGradientTop:(UIColor *)topColor bottom:(UIColor *)bottomColor
{
    GradientView* bgView = [[GradientView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    bgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    bgView.topColor = topColor;
    bgView.bottomColor = bottomColor;
    [self insertSubview:bgView atIndex:0];
}

-(CGFloat)percentageOfWidth:(CGFloat)pct
{
    pct = MAX(MIN(1.0, pct), 0.0);
    return round(pct*CGRectGetWidth(self.frame));
}

-(CGFloat)percentageOfHeight:(CGFloat)pct
{
    pct = MAX(MIN(1.0, pct), 0.0);
    return round(pct*CGRectGetHeight(self.frame));
}

@end

@implementation UIAlertView (MyExtensions)

+ (void)showMessage:(NSString *)message withTitle:(NSString *)title
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
//    [alert release];
}

@end

@implementation NSDictionary (MyExtensions)

- (BOOL)containsKey:(NSObject*)key
{
    return [self objectForKey:key] == nil ? NO : YES;
}

@end

@implementation UINavigationItem (MyExtensions)
-(UILabel*)setTitleViewWithText:(NSString*)text
{
    //Make Label
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 40)];
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    titleLabel.backgroundColor = [UIColor clearColor];
    
    
    titleLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:20.0f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithRGB:@"5D06A6" alpha:1];//[CSColorPalette currentPalette].mainToolbarText;
    titleLabel.text = text;
    titleLabel.adjustsFontSizeToFitWidth = YES;
    
    //Size Label
    CGSize textSize = [text sizeWithFont:titleLabel.font];
    titleLabel.frame = CGRectMake(0, 0, textSize.width+10, textSize.height+10);
    
    //Set Label
    self.titleView = titleLabel;
    
    //Return Label
    return titleLabel;
}
@end

@implementation UIColor (MyExtensions)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+(UIColor*)colorWithRGB:(NSString *)rgb alpha:(CGFloat)alpha
{
    if(rgb.length != 6)
        return nil;
    
    NSString* redStr = [rgb substringToIndex:2];
    NSString* greenStr = [rgb substringWithRange:NSMakeRange(2, 2)];
    NSString* blueStr = [rgb substringFromIndex:4];
    
    unsigned red = 0;
    NSScanner *scanner = [NSScanner scannerWithString:redStr];
    [scanner scanHexInt:&red];
    
    unsigned green = 0;
    scanner = [NSScanner scannerWithString:greenStr];
    [scanner scanHexInt:&green];
    
    unsigned blue = 0;
    scanner = [NSScanner scannerWithString:blueStr];
    [scanner scanHexInt:&blue];
    
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
}

-(UIColor*)adjustedColorForTranslucentBar
{
    CGFloat r,g,b,a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    CGFloat nr, ng, nb;
    nr = [UIColor adjustedValueForToolbarComponent:r];
    ng = [UIColor adjustedValueForToolbarComponent:g];
    nb = [UIColor adjustedValueForToolbarComponent:b];
    NSLog(@"adjusted from %f %f %f to %f %f %f", r,g,b,nr,ng,nb);
    return [UIColor colorWithRed:nr green:ng blue:nb alpha:a];
}

-(UIColor*)actualColorFromTranslucentBar
{
    CGFloat r,g,b,a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    r = [UIColor actualValueFromToolbarComponent:r];
    g = [UIColor actualValueFromToolbarComponent:g];
    b = [UIColor actualValueFromToolbarComponent:b];
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}

+(CGFloat)adjustedValueForToolbarComponent:(CGFloat)component
{
    if(component*255 < 102)
        NSLog(@"Color component out of adjustable range (102-255), got %f", component*255);
    CGFloat adjustedComponent = ((component*255.0) - 102) / 0.6;
    return adjustedComponent/255.0;
}

+(CGFloat)actualValueFromToolbarComponent:(CGFloat)component
{
    CGFloat actualComponent = (255 - (component*255.0)) / 2.5 + (component*255.0);
    return actualComponent;
}

@end

@implementation NSMutableArray (MyExtensions)

- (void)shuffle
{
    NSUInteger count = [self count];
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        NSInteger nElements = count - i;
        NSInteger n = (arc4random() % nElements) + i;
        [self exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

@end


@implementation UIImage (MyExtensions)
- (BOOL)isJPEGValid:(NSData *)jpeg {
    if ([jpeg length] < 4) return NO;
    const unsigned char * bytes = (const unsigned char *)[jpeg bytes];
    if (bytes[0] != 0xFF || bytes[1] != 0xD8) return NO;
    if (bytes[[jpeg length] - 2] != 0xFF ||
        bytes[[jpeg length] - 1] != 0xD9) return NO;
    return YES;
}

- (UIImage *)normalizedImage {
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [self drawInRect:(CGRect){0, 0, self.size}];
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalizedImage;
}
@end

@implementation UISearchBar (MyExtensions)

-(void)setKeyboardAppearance:(UIKeyboardAppearance)kbAppearance enablesReturnKeyAutomatically:(BOOL)enableRtKey
{
    for (UIView *searchBarSubview in [self subviews]) {
        if ([searchBarSubview conformsToProtocol:@protocol(UITextInputTraits)]) {
            @try {
                // set style of keyboard
                [(UITextField *)searchBarSubview setKeyboardAppearance:kbAppearance];
                
                // always force return key to be enabled
                [(UITextField *)searchBarSubview setEnablesReturnKeyAutomatically:enableRtKey];
            }
            @catch (NSException * e) {
                // ignore exception
            }
        }
    }
}

-(UITextField*)textField
{
    for (UIView *searchBarSubview in [self subviews]) {
        if ([searchBarSubview conformsToProtocol:@protocol(UITextInputTraits)]) {
            @try {
                return (UITextField *)searchBarSubview;
            }
            @catch (NSException * e) {
                // ignore exception
            }
        }
    }
}

@end

@implementation UIApplication (MyExtensions)
+(NSString*)bundleVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
}
@end

@implementation NSNumber (MyExtensions)
-(NSString*)abbreviateInteger {
    return [NSNumber abbreviateInteger:[self integerValue]];
}

+(NSString*)abbreviateInteger:(NSInteger)integerValue {
    NSString *valueString;
    
    NSString *abbrevNum;
    float number = (float)integerValue;
    
    //Prevent numbers smaller than 1000 to return NULL
    if (integerValue >= 1000) {
        NSArray *abbrev = @[@"K", @"M", @"B"];
        
        for (int i = (int) (abbrev.count - 1); i >= 0; i--) {
            
            // Convert array index to "1000", "1000000", etc
            int size = pow(10,(i+1)*3);
            
            if(size <= number) {
                // Removed the round and dec to make sure small numbers are included like: 1.1K instead of 1K
                number = number/size;
                NSString *numberString = [NSNumber floatToString:number];
                
                // Add the letter for the abbreviation
                abbrevNum = [NSString stringWithFormat:@"%@%@", numberString, [abbrev objectAtIndex:i]];
            }
            
        }
    } else {
        
        // Numbers like: 999 returns 999 instead of NULL
        abbrevNum = [NSString stringWithFormat:@"%d", (int)number];
    }
    
    return abbrevNum;
}

+ (NSString *) floatToString:(CGFloat) value {
    NSString *ret = [NSString stringWithFormat:@"%.1f", value];
    unichar c = [ret characterAtIndex:[ret length] - 1];
    
    while (c == 48) { // 0
        ret = [ret substringToIndex:[ret length] - 1];
        c = [ret characterAtIndex:[ret length] - 1];
        
        //After finding the "." we know that everything left is the decimal number, so get a substring excluding the "."
        if(c == 46) { // .
            ret = [ret substringToIndex:[ret length] - 1];
        }
    }
    
    return ret;
}

@end

@implementation NSDate (MyExtensions)

+ (NSDate *) dateFromISO8601String:(NSString *)iso8601String {
    if([iso8601String isKindOfClass:[NSString class]]) {
        NSDateFormatter *dateFormatter = [NSDateFormatter ISO8601Formatter];
        return [dateFormatter dateFromString:iso8601String];
    }
    else return nil;
}


- (NSString *) ISO8601String {
    NSDateFormatter *dateFormatter = [NSDateFormatter ISO8601Formatter];
    return [dateFormatter stringFromDate:self];
}

@end

@implementation NSDateFormatter (MyExtensions)

+ (NSDateFormatter *)ISO8601Formatter {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
        [formatter setLocale:enUSPOSIXLocale];
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    });
    return formatter;
}

@end
