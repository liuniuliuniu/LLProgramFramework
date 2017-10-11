//
//  XAFAppContext.m
//  XNetworking
//  
//  Created by wangxi on 15/6/18.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import "XAFAppContext.h"
#import <AFNetworking/AFNetworking.h>
#import "NSObject+XNetworkingMethods.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <UICKeyChainStore/UICKeyChainStore.h>
#import "UIDevice+IdentifierAddition.h"

@interface XAFAppContext ()

@property (nonatomic, strong) UIDevice *device;
@property (nonatomic, copy, readwrite) NSString *m;
@property (nonatomic, copy, readwrite) NSString *ip;
@property (nonatomic, copy, readwrite) NSString *o;
@property (nonatomic, copy, readwrite) NSString *v;
@property (nonatomic, copy, readwrite) NSString *cv;
@property (nonatomic, copy, readwrite) NSString *uuid;
@property (nonatomic, copy, readwrite) NSString *from;
@property (nonatomic, copy, readwrite) NSString *ostype;
@property (nonatomic, copy, readwrite) NSString *qtime;
@property (nonatomic, copy, readwrite) NSString *dName;

@end

@implementation XAFAppContext
#pragma mark - public methods
+ (instancetype)sharedInstance{
    static XAFAppContext *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[XAFAppContext alloc] init];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    });
    return sharedInstance;
}


#pragma mark - getters and setters

- (NSString *)channelID{
    if (_channelID == nil) {
        _channelID = @"app store";
    }
    return _channelID;
}

- (NSString *)appName{
    if (_appName == nil) {
        _appName = @"i-nicaifu";
    }
    return _appName;
}
- (UIDevice *)device{
    if (_device == nil) {
        _device = [UIDevice currentDevice];
    }
    return _device;
}

- (NSString *)m{
    if (_m == nil) {
        _m = [UIDevice currentDevice].xaf_machineType;
    }
    return _m;
}
- (NSString *)ip{
    if (_ip == nil) {
        _ip = @"Error";
        struct ifaddrs *interfaces = NULL;
        struct ifaddrs *temp_addr = NULL;
        int success = 0;
        // retrieve the current interfaces - returns 0 on success
        success = getifaddrs(&interfaces);
        if (success == 0) {
            // Loop through linked list of interfaces
            temp_addr = interfaces;
            while(temp_addr != NULL) {
                if(temp_addr->ifa_addr->sa_family == AF_INET) {
                    // Check if interface is en0 which is the wifi connection on the iPhone
                    if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                        // Get NSString from C String
                        _ip = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    }
                }
                temp_addr = temp_addr->ifa_next;
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return _ip;
}
- (NSString *)o{
    if (_o == nil) {
        _o = [self.device.systemName X_defaultValue:@""];
    }
    return _o;
}
- (NSString *)v{
    if (_v == nil) {
        _v = [self.device systemVersion];
    }
    return _v;
}

- (NSString *)cv{
    if (_cv == nil) {
        _cv = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    }
    return _cv;
}
- (NSString *)from{
    if (_from == nil) {
        _from = @"ios";
    }
    return _from;
}
- (NSString *)uuid{
    if (_uuid == nil) {
        _uuid = [self.device.xaf_uuid X_defaultValue:@""];
    }
    return _uuid;
}
- (NSString *)ostype{
    if (_ostype == nil) {
        _ostype = [self.device.xaf_ostype X_defaultValue:@""];
    }
    return _ostype;
}
- (NSString *)qtime{
    if (_qtime == nil){
        _qtime = [NSString stringWithFormat:@"%ld",time(NULL)];
    }
    return _qtime;
}
- (NSString *)dName{
    if(_dName == nil){
        _dName = [self.device.xaf_machineType X_defaultValue:@""];
    }
    return _dName;
}

- (BOOL)isReachable{
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusUnknown) {
        return YES;
    } else {
        return [[AFNetworkReachabilityManager sharedManager] isReachable];
    }
}
@end
