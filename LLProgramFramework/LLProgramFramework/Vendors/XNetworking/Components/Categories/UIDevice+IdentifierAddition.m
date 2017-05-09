//
//  UIDevice+IdentifierAddition.m
//  XNetworking
//
//  Created by wangxi on 15/6/18.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import "UIDevice+IdentifierAddition.h"
#import <UICKeyChainStore/UICKeyChainStore.h>
#import "NSString+XAFNetworking.h"
#include <sys/utsname.h>
#import "XNetworkingConfiguration.h"

@implementation UIDevice (IdentifierAddition)


- (NSString *)xaf_createUUID
{
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge NSString *)string;
}

- (NSString *)xaf_uuid{

    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:XAFKeychainServiceName];
    NSString *UUID = keychain[XAF_UUIDName];
    if(UUID.length <=0){
        NSString *tempUuid = [self xaf_createUUID];
        keychain[XAF_UUIDName] = tempUuid;
        return tempUuid;
    }
    else{
        return UUID;
    }
}


- (NSString *) xaf_ostype{
    UIDevice *device = [UIDevice currentDevice];
    NSString *os = [device systemVersion];
    NSArray *array = [os componentsSeparatedByString:@"."];
    NSString *ostype = @"ios";
    if (array.count>0) {
        ostype = [NSString stringWithFormat:@"%@%@", ostype, [array objectAtIndex:0]];
    }
    return ostype;
}

- (NSString *) xaf_machineType{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *machineType = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //iPhone
    if ([machineType isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([machineType isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([machineType isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([machineType isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([machineType isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([machineType isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([machineType isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([machineType isEqualToString:@"iPhone5,1"])    return @"iPhone 5(AT&T)";
    if ([machineType isEqualToString:@"iPhone5,2"])    return @"iPhone 5(GSM/CDMA)";
    if ([machineType isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([machineType isEqualToString:@"iPhone5,3"])    return @"iPhone 5c";
    if ([machineType isEqualToString:@"iPhone5,4"])    return @"iPhone 5c";
    if ([machineType isEqualToString:@"iPhone6,1"])    return @"iPhone 5s";
    if ([machineType isEqualToString:@"iPhone6,2"])    return @"iPhone 5s";
    if ([machineType isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([machineType isEqualToString:@"iPhone7,1"])    return @"iPhone 6Plus";
    if ([machineType isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([machineType isEqualToString:@"iPhone8,2"])    return @"iPhone 6sPlus";
    if ([machineType isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([machineType isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([machineType isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([machineType isEqualToString:@"iPhone9,2"])    return @"iPhone 7Plus";
    if ([machineType isEqualToString:@"iPhone9,4"])    return @"iPhone 7Plus";

    //iPod Touch
    if ([machineType isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([machineType isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([machineType isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([machineType isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([machineType isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    //iPad
    if ([machineType isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([machineType isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([machineType isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([machineType isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([machineType isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([machineType isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([machineType isEqualToString:@"iPad2,7"])      return @"iPad Mini (CDMA)";
    if ([machineType isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([machineType isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM)";
    if ([machineType isEqualToString:@"iPad3,3"])      return @"iPad 3 (CDMA)";
    if ([machineType isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([machineType isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([machineType isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    if ([machineType isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([machineType isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([machineType isEqualToString:@"iPad4,4"])      return @"iPad MiniRetina";
    if ([machineType isEqualToString:@"iPad4,5"])      return @"iPad MiniRetina";
    //Simulator
    if ([machineType isEqualToString:@"i386"])         return @"Simulator";
    if ([machineType isEqualToString:@"x86_64"])       return @"Simulator";
    
    return machineType;
}

@end
