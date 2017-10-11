//
//  XAFServiceFactory.m
//  XNetworking
//
//  Created by wangxi on 15/6/17.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import "XAFServiceFactory.h"

/****************************************************************************************************/
// 这里定义对于service的ID，然后通过这个id来获取对应的service
//


//NSString * const kXAFServiceNicaifu = @"XAFServiceNicaifu";


//
/***************************************************************************************************/


@interface XAFServiceFactory()
@property (nonatomic, strong) NSMutableDictionary *serviceStorage;     //缓存service
@end

@implementation XAFServiceFactory
#pragma mark - life cycle
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static XAFServiceFactory *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[XAFServiceFactory alloc] init];
    });
    return sharedInstance;
}

- (XAFServices<XAFServicesProtocol> *)serviceWithIdentifier:(NSString *)identifier{
    if(self.serviceStorage[identifier] == nil){
        //需要创建
        self.serviceStorage[identifier] = [self newServiceWithIdentifier:identifier];
    }
    return self.serviceStorage[identifier];
}

- (XAFServices<XAFServicesProtocol> *)newServiceWithIdentifier:(NSString *)identifier{
    if(identifier){    //id是用service的class名称做标识
        return [NSClassFromString(identifier) new];
    }
    return nil;
}

#pragma mark - getters and setters
- (NSMutableDictionary *)serviceStorage{
    if(!_serviceStorage){
        _serviceStorage = [NSMutableDictionary new];
    }
    return _serviceStorage;
}



@end
