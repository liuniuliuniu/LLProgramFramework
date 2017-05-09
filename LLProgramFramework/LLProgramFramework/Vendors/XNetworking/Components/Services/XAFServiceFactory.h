//
//  XAFServiceFactory.h
//  XNetworking
//  通过这个工厂方法来获取具体的srvice 
//  Created by wangxi on 15/6/17.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XAFServices.h"

@interface XAFServiceFactory : NSObject

+ (instancetype)sharedInstance;

//通过ID获取对于的XAFServices
- (XAFServices<XAFServicesProtocol> *)serviceWithIdentifier:(NSString *)identifier;

@end
