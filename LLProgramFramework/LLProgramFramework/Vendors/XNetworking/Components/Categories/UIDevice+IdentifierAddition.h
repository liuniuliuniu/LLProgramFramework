//
//  UIDevice+IdentifierAddition.h
//  XNetworking
//
//  Created by wangxi on 15/6/18.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (IdentifierAddition)

- (NSString *) xaf_uuid;
- (NSString *) xaf_ostype;
- (NSString *) xaf_machineType;

@end
