//
//  XAFAppContext.h
//  XNetworking
//  app用到所有公用参数
//  Created by wangxi on 15/6/18.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XNetworkingConfiguration.h"

@interface XAFAppContext : NSObject

@property (nonatomic, copy) NSString *channelID;              //渠道号
@property (nonatomic, copy) NSString *appName;                //应用名称
@property (nonatomic, assign) XAFAppType appType;
@property (nonatomic, copy, readonly) NSString *m;            //设备名称
@property (nonatomic, copy, readonly) NSString *o;            //系统名称
@property (nonatomic, copy, readonly) NSString *v;            //系统版本
@property (nonatomic, copy, readonly) NSString *cv;           //app版本
@property (nonatomic, copy, readonly) NSString *from;         //请求来源，值都是@"mobile"
@property (nonatomic, copy, readonly) NSString *ostype;       //操作系统类型
@property (nonatomic, copy, readonly) NSString *qtime;        //发送请求的时间
@property (nonatomic, copy, readonly) NSString *uuid;
@property (nonatomic, copy, readonly) NSString *ip;           //ip地址
@property (nonatomic, copy, readonly) NSString *dName;        //设备名称
@property (nonatomic, readonly) BOOL isReachable;              //网络是否通


+ (instancetype)sharedInstance;
@end
