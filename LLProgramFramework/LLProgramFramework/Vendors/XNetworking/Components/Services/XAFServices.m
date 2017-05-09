//
//  XAFServices.m
//  XNetworking
//  
//  Created by wangxi on 15/6/17.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import "XAFServices.h"

@implementation XAFServices
- (instancetype)init{
    self = [super init];
    if(self){
        if([self conformsToProtocol:@protocol(XAFServicesProtocol)]){
            self.child = (id<XAFServicesProtocol>)self;
        }
    }
    return self;
}

#pragma mark - getters and setters
- (NSString *)publicKey{
    return self.child.isOnline ? self.child.onlinePublicKey : self.child.offlinePublicKey;
}
- (NSString *)apiBaseUrl{
    return self.child.isOnline ? self.child.onlineApiBaseUrl : self.child.offlineApiBaseUrl;
}
- (NSString *)apiVersion{
    return self.child.isOnline ? self.child.onlineApiVersion : self.child.offlineApiVersion;
}
- (NSSet *)certs{
    return self.child.onlineCerts;
}



@end
