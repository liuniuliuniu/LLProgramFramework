//
//  XAFServiceMVC.m
//  MVC
//
//  Created by 大影象科技 on 2017/4/5.
//  Copyright © 2017年 liushaohua. All rights reserved.

//

#import "XAFServicesMVC.h"

@implementation XAFServicesMVC

- (BOOL)isOnline{
    return YES;
}

- (NSString *)offlineApiBaseUrl
{
    NSString *host = @"http://www.baidu.com";
    return host;
}

- (NSString *)onlineApiBaseUrl{
    return @"http://iosapi.itcast.cn/loveBeen";
}

- (NSString *)offlineApiVersion{
    
    return self.onlineApiVersion;
}
- (NSString *)onlineApiVersion{
    
    return @"";
}
- (NSString *)offlinePublicKey
{
    return self.onlinePublicKey;
}
- (NSString *)onlinePublicKey
{
    return @"";
}

- (NSSet<NSData *> *)onlineCerts
{
    return nil;
    //    return self.certificationDatas;
}

+ (NSString *)signWithSigParams:(NSDictionary *)params{
    return nil;
}

- (void)clearAllCookie{
    NSURL *url = [NSURL URLWithString:[self onlineApiBaseUrl]];
    if (url) {
        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:url];
        for (int i = 0; i < [cookies count]; i++) {
            NSHTTPCookie *cookie = (NSHTTPCookie *)[cookies objectAtIndex:i];
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        }
    }
}

@end
