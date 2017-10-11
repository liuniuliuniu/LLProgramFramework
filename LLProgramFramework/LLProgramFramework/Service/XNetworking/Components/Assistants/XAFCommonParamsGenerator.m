//
//  XAFCommonParamsGenerator.m
//  XNetworking
//
//  Created by wangxi on 15/6/18.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import "XAFCommonParamsGenerator.h"
#import "XAFAppContext.h"

@implementation XAFCommonParamsGenerator
+ (NSDictionary *)commonParamsDictionary{
    XAFAppContext *context = [XAFAppContext sharedInstance];
//    return @{
//             @"channelID":context.channelID,
//             @"appName":context.appName,
//             @"v":context.v,
//             @"cv":context.cv,
//             @"from":context.from,
//             @"ostype":context.ostype,
//             @"qtime":context.qtime,
//             @"uuid":context.uuid,
//             @"ip":context.ip,
//             @"dname":context.dName
//             };
    return @{
             @"uuid":context.uuid,
             @"udevice":context.from,
             @"uversion":context.cv,
             @"channel":context.channelID,
             @"os_ver":context.v,
             @"device_type":context.m
             };
}


@end
