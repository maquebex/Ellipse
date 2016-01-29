//
//  KrumbsUserInfo.h
//  KrumbsSDK
//
//  Created by Asquith Bailey on 1/11/16.
//  Copyright © 2016 Krumbs Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KrumbsUserInfo : NSObject

@property (nonatomic,strong) NSString * _Nonnull emailAddress;
@property (nonatomic,strong) NSString * _Nullable firstName;
@property (nonatomic,strong) NSString * _Nullable lastName;
@property (nonatomic,strong) NSString * _Nonnull userDeviceID;

-(id _Nonnull) initAsAnonymousUser;

-(id _Nonnull) initWithEmail:(NSString * _Nonnull) email firstName:(NSString * _Nullable) fn lastName:(NSString * _Nullable) sn;

@end
