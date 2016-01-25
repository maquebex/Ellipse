
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSObject (MyExtensions)
- (NSString*)uniqueID;
- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
@end

@interface NSString (MyExtensions)
- (NSString *) md5;
- (BOOL)startsWith:(NSString*)prefix;
- (NSString*) urlEncode;
- (NSString*)quotifiedString;
- (NSString*)unquotifiedString;
- (NSString*)trimmedString;
- (BOOL)matchesRegex:(NSString *)regex;
- (BOOL)isValidEmailAddress;
@end

@interface NSData (MyExtensions)
- (NSString*)md5;
@end


@interface UIView (MyExtensions)
- (void)perspectiveReset;
- (void)perspectiveRotate:(double)radians X:(double)x Y:(double)y Z:(double)z;
+ (CGPoint) originInScreenCoordinates:(UIView*)view;
- (CGPoint) coordinateOffsetFromView:(UIView*)view toView:(UIView*)view;
+ (CGPoint) coordinateOffsetFromView:(UIView*)view toView:(UIView*)view;
-(UIImage*)toImage;
-(void)showFrameWithColor:(UIColor*)color;

-(void)convertAndAddItemAsSubview:(UIView*)item;
-(UIView*)getDragReceiverForItem:(UIView*)item;

- (UIViewController *) firstAvailableUIViewController;
- (id) traverseResponderChainForUIViewController;
-(void)hideFrame;

-(void)printViewHierarchyToDepth:(NSInteger)depth;
-(void)printViewHierarchyHelperStart:(NSInteger)start max:(NSInteger)max;

-(void)setBackgroundGradientTop:(UIColor*)topColor bottom:(UIColor*)bottomColor;

-(CGFloat)percentageOfWidth:(CGFloat)pct;
-(CGFloat)percentageOfHeight:(CGFloat)pct;

@end

@interface UIAlertView (MyExtensions)
+ (void)showMessage:(NSString*)message withTitle:(NSString*)title;
@end

@interface NSDictionary (MyExtensions)
- (BOOL)containsKey:(NSObject*)key;
@end

@interface UINavigationItem (MyExtensions)
-(UILabel*)setTitleViewWithText:(NSString*)text;
@end

@interface UIColor (MyExtensions)
+ (UIImage *)imageWithColor:(UIColor *)color;
+(UIColor*)colorWithRGB:(NSString *)rgb alpha:(CGFloat)alpha;
-(UIColor*)adjustedColorForTranslucentBar;
-(UIColor*)actualColorFromTranslucentBar;
+(CGFloat)adjustedValueForToolbarComponent:(CGFloat)component;
+(CGFloat)actualValueFromToolbarComponent:(CGFloat)component;
@end

@interface NSMutableArray (MyExtensions)
-(void)shuffle;
@end

@interface UIImage (MyExtensions)
- (BOOL)isJPEGValid:(NSData *)jpeg;
- (UIImage *)normalizedImage;
@end

@interface UISearchBar (MyExtensions)
-(void)setKeyboardAppearance:(UIKeyboardAppearance)kbAppearance enablesReturnKeyAutomatically:(BOOL)enableRtKey;
-(UITextField*)textField;
@end

@interface UIApplication (MyExtensions)
+(NSString*)bundleVersion;
@end

@interface NSNumber (MyExtensions)
-(NSString*)abbreviateInteger;
+(NSString*)abbreviateInteger:(NSInteger)integerValue;
+(NSString*)floatToString:(CGFloat)value;
@end

@interface NSDate (MyExtensions)
+(NSDate *)dateFromISO8601String:(NSString *)iso8601;
-(NSString *)ISO8601String;
@end

@interface NSDateFormatter (MyExtensions)
+ (NSDateFormatter *)ISO8601Formatter;
@end
