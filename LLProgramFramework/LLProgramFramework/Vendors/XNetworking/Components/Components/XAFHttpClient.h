//
//  XAFHttpClient.h
//  XKNetworking
//  一个简单的http请求工具
//  Created by wangxi on 15/7/6.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import <AFHTTPSessionManager.h>

@interface XAFHttpClient : AFHTTPSessionManager
typedef void (^requestResponseBlock)(NSURLSessionDataTask *task, id responseObject);
typedef void (^requestErrorBlock)(NSError* error);

+ (instancetype)sharedClient;
- (NSURLSessionDataTask *)postUrl:(NSString *)url
                       parameters:(id)parameters
                          success:(requestResponseBlock)success
                          failure:(requestErrorBlock)failure;
- (NSURLSessionDataTask *)requestUrl:(NSString *)url
                          parameters:(id)parameters
                             success:(requestResponseBlock)success
                             failure:(requestErrorBlock)failure;

@end
