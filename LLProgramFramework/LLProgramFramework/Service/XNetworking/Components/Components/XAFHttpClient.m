//
//  XAFHttpClient.m
//  XKNetworking
//
//  Created by wangxi on 15/7/6.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import "XAFHttpClient.h"

static NSString * const kXAFHttpApiClientLockName = @"com.xaf.networking.lock";

@interface XAFHttpClient()

@property (readwrite, nonatomic, strong) NSRecursiveLock *lock;

@end

@implementation XAFHttpClient

+ (instancetype)sharedClient {
    static XAFHttpClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.requestCachePolicy = NSURLRequestReloadIgnoringCacheData;
        //
        _sharedClient = [[XAFHttpClient alloc] initWithBaseURL:nil sessionConfiguration:config];
        _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        [_sharedClient.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    });
    return _sharedClient;
}

- (instancetype)init{
    self = [super init];
    if(self){
        _lock =  [[NSRecursiveLock alloc] init];
        _lock.name = kXAFHttpApiClientLockName;
    }
    return self;
}

- (NSURLSessionDataTask *)requestUrl:(NSString *)url parameters:(id)parameters success:(requestResponseBlock)success failure:(requestErrorBlock)failure{
    if(!url){
        if(failure)
            failure(nil);
        return nil;
    }
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    self.responseSerializer.stringEncoding = NSUTF8StringEncoding;
//    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    __weak __typeof(self)weakSelf = self;
    NSURLSessionDataTask *task = [self GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(responseObject){
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf.lock lock];
            NSString *strJosn = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            [strongSelf.lock unlock];
            if(strJosn && strJosn.length >0){
                //json转换
                NSData *jsonData = [strJosn dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *jsonDict =  [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
                
                if(success){
                    success(task,jsonDict);
                    return ;
                }
            }
        }
        if(success)
            success(task,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure)
            failure(error);
    }];
    return task;
}

- (NSURLSessionDataTask *)postUrl:(NSString *)url parameters:(id)parameters success:(requestResponseBlock)success failure:(requestErrorBlock)failure{
    if(!url){
        if(failure)
            failure(nil);
        return nil;
    }
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    self.responseSerializer.stringEncoding = NSUTF8StringEncoding;
    //    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    __weak __typeof(self)weakSelf = self;
    
    NSURLSessionDataTask *task = [self POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(responseObject){
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf.lock lock];
            NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            [strongSelf.lock unlock];
            //json转换
            NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *jsonDict =  [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
            if(success)
                success(task,jsonDict);
            return ;
        }
        if(success)
            success(task,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure)
            failure(error);
    }];
    return task;
}


@end
