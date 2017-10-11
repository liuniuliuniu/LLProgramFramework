//
//  XAFApiProxy.m
//  XNetworking
//
//  Created by wangxi on 15/6/17.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import "XAFApiProxy.h"
#import <AFNetworking/AFNetworking.h>
#import "XAFCommonParamsGenerator.h"
#import "XAFRequestGenerator.h"
#import "XNetworkingConfiguration.h"
#import "NSURLRequest+XNetworkingMethods.h"
#import "XAFServices.h"
#import "XAFServiceFactory.h"

@interface XAFApiProxy()
@property (nonatomic, strong) NSMutableDictionary *dispatchTable;
@property (nonatomic, strong) AFHTTPSessionManager *operationManager;
@property (nonatomic, strong) NSNumber *recordedRequestId;              //记录请求的id 用来标记dispatchTable key
@end

@implementation XAFApiProxy
#pragma mark - life cycle
+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static XAFApiProxy *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[XAFApiProxy alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
}
#pragma mark - public methods
- (NSInteger)getWithParams:(NSDictionary *)params
         serbiceIdentifier:(NSString *)servieIdentifier
                methodName:(NSString *)methodName
                   success:(XCallback)success
                      fail:(XCallback)fail{
    NSURLRequest *request = [[XAFRequestGenerator sharedInstance] generateGETRequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName];
    NSNumber *requestID = [self callApiWithRequest:request success:success fail:fail serbiceIdentifier:servieIdentifier];
    return [requestID integerValue];
}

- (NSInteger)postWithParams:(NSDictionary *)params
          serbiceIdentifier:(NSString *)servieIdentifier
                 methodName:(NSString *)methodName
                    success:(XCallback)success
                       fail:(XCallback)fail{
    NSURLRequest *request = [[XAFRequestGenerator sharedInstance] generatePOSTRequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName];
    NSNumber *requestID = [self callApiWithRequest:request success:success fail:fail serbiceIdentifier:servieIdentifier];
    return [requestID integerValue];
}

- (void)cancelRequestWithRequestID:(NSNumber *)requestID{
    NSURLSessionTask *requestTask = self.dispatchTable[requestID];
    [requestTask cancel];
    [self.dispatchTable removeObjectForKey:requestID];
}
- (void)removeRequestWithID:(NSNumber *)requestID{
    [self.dispatchTable removeObjectForKey:requestID];
}
- (void)cancelAllRequest{
    NSArray *allTask = [self.dispatchTable allValues];
    for(NSURLSessionTask *task in allTask){
        [task cancel];
    }
    [self.dispatchTable removeAllObjects];
}
- (NSArray *)allTask{
    return self.dispatchTable.allValues;
}

#pragma mark - private methods
//这里用AF发起请求，如果要替换AF也在这里替换
- (NSNumber *)callApiWithRequest:(NSURLRequest *)request success:(XCallback)success fail:(XCallback)fail serbiceIdentifier:(NSString *)servieIdentifier{
    NSNumber *requestId = [self generateRequestId];      //获取请求的id
    NSURLSessionTask *task = [self.operationManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        XURLResponseStatus requestStatus = XURLResponseStatusSucess;
//        if(self.dispatchTable[requestId] == nil) {         //cancel请求会在error报错
//            requestStatus = XURLResponseStatusCancel;
//        }
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if(error){       //有错误，类请求失败
            XURLResponse *response = [[XURLResponse alloc] initWithResponseString:nil
                                                                        requestId:requestId
                                                                          request:request
                                                                     responseData:responseObject
                                                                            error:error];
            fail?fail(response):nil;
        }
        else {
            XURLResponse *response = [[XURLResponse alloc] initWithResponseString:responseString
                                                                        requestId:requestId
                                                                          request:request
                                                                     responseData:responseObject
                                                                           status:requestStatus];
            success?success(response):nil;
        
        }
    }];
    XAFServices *service = [[XAFServiceFactory sharedInstance] serviceWithIdentifier:servieIdentifier];
    if(service.certs.count > 0){
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:service.certs];
        [securityPolicy setAllowInvalidCertificates:NO];
        [securityPolicy setValidatesDomainName:YES];
        self.operationManager.securityPolicy = securityPolicy;
    }
    else {
        self.operationManager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    }
    [task resume];
    XANSLog(@"%@ -- %@",request.URL,request.requestParams);
    self.dispatchTable[requestId] = task;    //保存发出的请求
    return requestId;
}

- (NSNumber *)generateRequestId{
    if (_recordedRequestId == nil) {
        _recordedRequestId = @(1);
    } else {
        if ([_recordedRequestId integerValue] == NSIntegerMax) {
            _recordedRequestId = @(1);
        } else {
            _recordedRequestId = @([_recordedRequestId integerValue] + 1);
        }
    }
    return _recordedRequestId;
}

#pragma mark -- getters and setters

- (NSMutableDictionary *)dispatchTable{
    if(!_dispatchTable){
        _dispatchTable = [NSMutableDictionary new];
    }
    return _dispatchTable;
}

- (AFHTTPSessionManager *)operationManager{
    if(!_operationManager){
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.timeoutIntervalForRequest = kXNetworkingTimeoutSeconds;
        _operationManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:config];
        _operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        AFSecurityPolicy * tempSecurityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
//        tempSecurityPolicy.allowInvalidCertificates = YES;
//        tempSecurityPolicy.validatesDomainName = NO;
//        _operationManager.securityPolicy = tempSecurityPolicy;
    }
    return _operationManager;
}


@end
