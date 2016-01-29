//
//  KIntentPanelConfiguration.h
//  KrumbsSDK
//
//  Created by Asquith Bailey on 1/22/16.
//  Copyright © 2016 Krumbs Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/*!
 * @class KIntentPanelConfiguration.h
  This class provides UI customization properties for the K-Intent Panel component.
  It offers the ability to customize the panel color, and the various text fonts and text colors
  of the Intent Category names and Intent Emoji intent labels
 *
 */

@interface KIntentPanelConfiguration : NSObject
/*!
 * @brief Set this property to change the font of the IntentEmoji text label
 * @param emojiFont - a UIFont to use. Defaults to [UIFont fontWithName:@"AvenirNext-MediumItalic" size:15]
 */
@property (nonatomic, strong) UIFont* emojiFont;
/*!
 * @brief Set this property to change the font color of the IntentEmoji text label
 * @discussion It defaults to [UIColor whiteColor]
 */
@property (nonatomic, strong) UIColor* emojiTextColor;
/*!
 * @brief Set this property to change the background color of the Intent Panel header bar
 * @discussion It defaults to [UIColor colorWithRed:0.020 green:0.612 blue:0.482 alpha:1.00]
 * (or #059c7b). This color will be distributed across the panel in the following way:
 *  the header (Intent Category tabs) of the Intent Panel will use 80% alpha of this value
 *  and the emoji panel will use this color with 25% alpha.
 */
@property (nonatomic, strong) UIColor* intentPanelBarColor;
/*!
 * @brief Set this property to change the font style of the Intent Categories in the Intent Panel
 * @discussion It defaults to [UIFont fontWithName:@"AvenirNext-Medium" size:16]
 *
 */
@property (nonatomic, strong) UIFont* intentPanelBarFont;
/*!
 * @brief Set this property to change the font color of the Intent Categories labels in the Intent Panel
 * @discussion It defaults to [UIColor whiteColor] and will invert to intentPanelBarColor when selected
 *
 */
@property (nonatomic, strong) UIColor* intentPanelBarTextColor;
@end
