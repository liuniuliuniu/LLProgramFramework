//
//  XAFServices.h
//  XNetworking
//  接口对于的服务，我们可以把一个模块或者独立的api提供者看做一个服务，比如google地图，比如先看模块，比如社交中的sina，qq等
//  Created by wangxi on 15/6/17.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XAFServices;

//所有的XAFServices子类都需要符合这个protocal
@protocol XAFServicesProtocol <NSObject>
@property (nonatomic,readonly) BOOL isOnline;
@property (nonatomic, readonly) NSString *offlineApiBaseUrl;
@property (nonatomic, readonly) NSString *onlineApiBaseUrl;
@property (nonatomic, readonly) NSString *offlineApiVersion;
@property (nonatomic, readonly) NSString *onlineApiVersion;
@property (nonatomic, readonly) NSString *onlinePublicKey;
@property (nonatomic, readonly) NSString *offlinePublicKey;
@property (nonatomic, readonly) NSSet<NSData *> *onlineCerts;

@optional
// 每个service实现自己的签名(没个service有可能签名方式不一样)
- (NSString *)signGetWithSigParams:(NSDictionary *)allParams methodName:(NSString *)methodName;
- (NSDictionary *)paramsModifyWithOldParams:(NSDictionary *)oldParams;   //参数是否需要修改
- (NSDictionary *)paramsEncryptionWithPaeams:(NSDictionary *)params;   //参数是否要加密
@end


//服务相关的信息(比如签名用到的数据，api host)

@interface XAFServices : NSObject
@property (nonatomic, copy, readonly) NSString *publicKey;
@property (nonatomic, copy, readonly) NSString *apiBaseUrl;
@property (nonatomic, copy, readonly) NSString *apiVersion;
@property (nonatomic, strong, readonly) NSSet<NSData *> *certs;
//为了强制让子类实现XAFServicesProtocol
@property (nonatomic, weak) id<XAFServicesProtocol> child;
@end
