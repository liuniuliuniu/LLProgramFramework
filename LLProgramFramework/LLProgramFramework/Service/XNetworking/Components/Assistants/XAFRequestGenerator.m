//
//  XAFRequestGenerator.m
//  XNetworking
//
//  Created by wangxi on 15/6/17.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "XAFRequestGenerator.h"
#import "XNetworkingConfiguration.h"
#import "XAFServices.h"
#import "XAFServiceFactory.h"
#import "XAFCommonParamsGenerator.h"
#import "NSDictionary+XAFNetworking.h"
#import "NSURLRequest+XNetworkingMethods.h"

@interface XAFRequestGenerator()
@property (nonatomic,strong) AFHTTPRequestSerializer *httpRequestSerializer;
@end

@implementation XAFRequestGenerator

#pragma mark - public methods
+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static XAFRequestGenerator *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[XAFRequestGenerator alloc] init];
    });
    return sharedInstance;
}
- (NSURLRequest *)generateGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                            requestParams:(NSDictionary *)requestParams
                                               methodName:(NSString *)methodName{
    if(serviceIdentifier.length<=0 || methodName.length<=0){
        return nil;
    }
    //通过ID生成对应的service
    XAFServices *service = [[XAFServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    //公共参数
    NSMutableDictionary *allParams = [NSMutableDictionary dictionaryWithDictionary:[XAFCommonParamsGenerator commonParamsDictionary]];
    [allParams addEntriesFromDictionary:requestParams];
    //询问参数是否需要修改
    if(service.child && [service.child respondsToSelector:@selector(paramsModifyWithOldParams:)]){
        [allParams setDictionary:[service.child paramsModifyWithOldParams:allParams]];
    }
    //签名
    NSString *signature = nil;
    if(service.child && [service.child respondsToSelector:@selector(signGetWithSigParams:methodName:)] ){
        signature = [service.child signGetWithSigParams:allParams methodName:methodName];
    }
    if(signature){
        [allParams setObject:signature forKey:@"sign"];
    }
    //是否需要加密
    if(service.child && [service.child respondsToSelector:@selector(paramsEncryptionWithPaeams:)]){
        [allParams setDictionary:[service.child paramsEncryptionWithPaeams:allParams]];
    }
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@", service.apiBaseUrl, service.apiVersion, methodName];
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:urlString parameters:nil error:NULL];
    request.timeoutInterval = kXNetworkingTimeoutSeconds;
    request.requestParams = requestParams;
    return request;
}

- (NSURLRequest *)generatePOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                             requestParams:(NSDictionary *)requestParams
                                                methodName:(NSString *)methodName{
    if(serviceIdentifier.length<=0 || methodName.length<=0){
        return nil;
    }
    //通过ID生成对应的service
    XAFServices *service = [[XAFServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    //公共参数
    NSMutableDictionary *allParams = [NSMutableDictionary dictionaryWithDictionary:[XAFCommonParamsGenerator commonParamsDictionary]];
    //拼起来所有的参数
    [allParams addEntriesFromDictionary:requestParams];
    //询问参数是否需要修改
    if(service.child && [service.child respondsToSelector:@selector(paramsModifyWithOldParams:)]){
        [allParams setDictionary:[service.child paramsModifyWithOldParams:allParams]];
    }
    //签名
    NSString *signature = nil;
    if(service.child && [service.child respondsToSelector:@selector(signGetWithSigParams:methodName:)] ){
        signature = [service.child signGetWithSigParams:allParams methodName:methodName];
    }
    if(signature){
        [allParams setObject:signature forKey:@"sign"];
    }
    //是否需要加密
    if(service.child && [service.child respondsToSelector:@selector(paramsEncryptionWithPaeams:)]){
        [allParams setDictionary:[service.child paramsEncryptionWithPaeams:allParams]];
    }
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@", service.apiBaseUrl, service.apiVersion, methodName];
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlString parameters:allParams error:NULL];
    request.timeoutInterval = kXNetworkingTimeoutSeconds;
    request.requestParams = allParams;
    return request;
}
#pragma mark - getters and setters

- (AFHTTPRequestSerializer *)httpRequestSerializer{
    if(!_httpRequestSerializer){
        _httpRequestSerializer = [AFJSONRequestSerializer serializer];
        _httpRequestSerializer.timeoutInterval = kXNetworkingTimeoutSeconds;
        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    return _httpRequestSerializer;
}

@end
