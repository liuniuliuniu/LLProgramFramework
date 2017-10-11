//
//  XNetworkingConfiguration.h
//  XNetworking
//
//  Created by wangxi on 15/6/16.
//  Copyright (c) 2015年 x. All rights reserved.
//

#ifndef XNetworking_XNetworkingConfiguration_h
#define XNetworking_XNetworkingConfiguration_h

typedef NS_ENUM(NSInteger, XAFAppType) {
    XAFAppTypeXXX,
    XAFAppTypeOther
};

//请求状态
typedef NS_ENUM (NSUInteger, XURLResponseStatus){
    XURLResponseStatusSucess,                          //网络请求成功，不管服务器返回的数据是否正确
    XURLResponseStatusErrorTimeout,                    //请求超时
    XURLResponseStatusCancel,                          //请求需求
    XURLResponseStatusErrorNoNetwork                   //请求失败，所有的请求失败
};

static NSTimeInterval kXNetworkingTimeoutSeconds = 20.0f;

static NSString *XAFKeychainServiceName = @"me.iloss";
static NSString *XAF_UUIDName = @"XAF_UUID";



#ifdef DEBUG
#define XANSLog(...) NSLog(__VA_ARGS__)
#else
#define XANSLog(...) do{}while(0)
#endif

#endif
