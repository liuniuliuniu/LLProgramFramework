//
//  XAFApiProxy.h
//  XNetworking
//  这里是做最终的网络请求的发出
//  Created by wangxi on 15/6/17.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XURLResponse.h"

typedef void(^XCallback)(XURLResponse *response);
@interface XAFApiProxy : NSObject

+ (instancetype)sharedInstance;
//get请求
- (NSInteger)getWithParams:(NSDictionary *)params
         serbiceIdentifier:(NSString *)servieIdentifier
                methodName:(NSString *)methodName
                   success:(XCallback)success
                      fail:(XCallback)fail;

//post
- (NSInteger)postWithParams:(NSDictionary *)params
         serbiceIdentifier:(NSString *)servieIdentifier
                methodName:(NSString *)methodName
                   success:(XCallback)success
                      fail:(XCallback)fail;
//
- (void)cancelAllRequest;
- (void)cancelRequestWithRequestID:(NSNumber *)requestID;                //取消请求并且从请求列表中删除
- (void)removeRequestWithID:(NSNumber *)requestID;                       //从请求列表中删除，不会对请求本身去做操作
- (NSArray *)allTask;                                                    //所有的请求列表
@end
