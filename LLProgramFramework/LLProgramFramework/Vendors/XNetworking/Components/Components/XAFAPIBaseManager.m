//
//  XAFAPIBaseManager.m
//  XNetworking
//
//  Created by wangxi on 15/6/19.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import "XAFAPIBaseManager.h"
#import "XAFAppContext.h"
#import "XAFApiProxy.h"
#import "XURLResponse.h"

@interface XAFAPIBaseManager()
@property (nonatomic, strong, readwrite) id fetchedRawData;
@property (nonatomic, copy, readwrite) NSString *errorMessage;
@property (nonatomic, readwrite) XAFAPIManagerErrorType errorType;
@property (nonatomic, assign) NSInteger currentRequestId;      //当前请求id
//@property (nonatomic, strong) NSMutableArray *requestIdList;          //存储请求的id
@end


@implementation XAFAPIBaseManager
+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static XAFAPIBaseManager *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[XAFAPIBaseManager alloc] init];
    });
    return sharedInstance;
}

#pragma mark - life cycle
- (instancetype)init{
    self = [super init];
    if (self) {
        _delegate = nil;
        _validator = nil;
        _paramSource = nil;
        _fetchedRawData = nil;
        _errorMessage = nil;
        _errorType = XAFAPIManagerErrorTypeDefault;
        //判断子类有没有去实现XAFAPIManager 协议
        if ([self conformsToProtocol:@protocol(XAFAPIManager)]) {
            self.child = (NSObject <XAFAPIManager>*)self;
        }
    }
    return self;
}
- (void)dealloc{
    //删除自己的请求
    [self cancelRequestWithRequestId:self.currentRequestId];   //cancel 请求
    [[XAFApiProxy sharedInstance]cancelRequestWithRequestID:@(self.currentRequestId)];
//    [[XAFAPIBaseManager sharedInstance].requestIdList removeObject:@(self.currentRequestId)]; //整个队列中移除
}


#pragma mark - public methods
+ (void)cancelAllRequests{
    [[XAFApiProxy sharedInstance] cancelAllRequest];
//    [[XAFApiProxy sharedInstance] cancelRequestWithRequestIDList:[XAFAPIBaseManager sharedInstance].requestIdList];
//    [[XAFAPIBaseManager sharedInstance].requestIdList removeAllObjects];
}

- (void)cancelRequestWithRequestId:(NSInteger)requestID{
//    [self removeRequestIdWithRequestID:requestID];
    [[XAFApiProxy sharedInstance] cancelRequestWithRequestID:@(requestID)];
}

- (id)fetchDataWithReformer:(id<XAFAPIManagerCallbackDataReformer>)reformer{
    id resultData = nil;
    if ([reformer respondsToSelector:@selector(manager:reformData:)]) {
        resultData = [reformer manager:self reformData:self.fetchedRawData];
    } else {
        resultData = [self.fetchedRawData mutableCopy];
    }
    return resultData;
}

- (void)startWithCompletionBlockWithSuccess:(void (^)(XAFAPIBaseManager *))success failure:(void (^)(XAFAPIBaseManager *))failure{
    [self setCompletionBlockWithSuccess:success failure:failure];
    [self loadData];

}

- (void)setCompletionBlockWithSuccess:(void (^)(XAFAPIBaseManager *))success failure:(void (^)(XAFAPIBaseManager *))failure{
    self.successCompletionBlock = success;
    self.failureCompletionBlock = failure;
}

- (void)clearCompletionBlock {
    // nil out to break the retain cycle.
    self.successCompletionBlock = nil;
    self.failureCompletionBlock = nil;
}

#pragma mark - calling api
- (NSInteger)loadData{
    NSDictionary *params = [self.paramSource paramsForApi:self];  //获取请求参数
    NSInteger requestId = [self loadDataWithParams:params];
    self.currentRequestId = requestId;
    return requestId;
}
//通过请求参数去发起请求
- (NSInteger)loadDataWithParams:(NSDictionary *)params{
    NSInteger requestId = 0;
    if([self.validator manager:self isCorrectWithParamsData:params]){
        if([self isReachable]){  //判断是否有网络
            switch (self.child.requestType) {
                case XAFAPIManagerRequestTypeGet:{
                    requestId = [[XAFApiProxy sharedInstance] getWithParams:params serbiceIdentifier:self.child.serviceId methodName:self.child.methodName success:^(XURLResponse *response) {
                        [self successedOnCallingAPI:response];
                    } fail:^(XURLResponse *response) {
                        [self failedOnCallingAPI:response withErrorType:[self responseErrorWithResponseStatus:response.status]];
                    }];
//                    [self.requestIdList addObject:@(requestId)];
//                    [[XAFAPIBaseManager sharedInstance].requestIdList addObject:@(requestId)];
                }
                    break;
                case XAFAPIManagerRequestTypePost:{
                    requestId = [[XAFApiProxy sharedInstance] postWithParams:params serbiceIdentifier:self.child.serviceId methodName:self.child.methodName success:^(XURLResponse *response) {
                        [self successedOnCallingAPI:response];
                    } fail:^(XURLResponse *response) {
                        [self failedOnCallingAPI:response withErrorType:[self responseErrorWithResponseStatus:response.status]];
                    }];
//                    [self.requestIdList addObject:@(requestId)];
//                    [[XAFAPIBaseManager sharedInstance].requestIdList addObject:@(requestId)];
                }
                    break;
                    
                default:
                    break;
            }
        
            NSMutableDictionary *aparams = [params mutableCopy];
            aparams[kXAPAPIBaseManagerRequestID] = @(requestId);
            return requestId;
        }
        else{  //没有网络
            [self failedOnCallingAPI:nil withErrorType:XAFAPIManagerErrorTypeNoNetWork];
            return requestId;
        }
    }
    else{
        [self failedOnCallingAPI:nil withErrorType:XAFAPIManagerErrorTypeParamsError];
    }
    return requestId;
}

#pragma mark - method for child
- (void)cleanData{
    IMP childIMP = [self.child methodForSelector:@selector(cleanData)];
    IMP selfIMP = [self methodForSelector:@selector(cleanData)];
    
    if (childIMP == selfIMP) {
        self.fetchedRawData = nil;
        self.errorMessage = nil;
        self.errorType = XAFAPIManagerErrorTypeDefault;
    } else {
        if ([self.child respondsToSelector:@selector(cleanData)]) {
            [self.child cleanData];
        }
    }
}
#pragma mark - api callbacks
//- (void)apiCallBack:(XURLResponse *)response
//{
//    if (response.status == XURLResponseStatusSucess) {
//        [self successedOnCallingAPI:response];
//    }else{
//        [self failedOnCallingAPI:response withErrorType:XAFAPIManagerErrorTypeDefault];
//    }
//}
//成功回调
- (void)successedOnCallingAPI:(XURLResponse *)response{
    if (response.content) {
        self.fetchedRawData = [response.content copy];
    } else {
        self.fetchedRawData = [response.responseData copy];
    }
//    [self removeRequestIdWithRequestID:response.requestId];
    [[XAFApiProxy sharedInstance] removeRequestWithID:@(response.requestId)];
    if ([self.validator manager:self isCorrectWithCallBackData:response.content]) {
        
        self.errorType = XAFAPIManagerErrorTypeSuccess;
        if([_delegate respondsToSelector:@selector(managerCallApiDidSuccess:)]){
            [_delegate managerCallApiDidSuccess:self];
        }
        
        if(_successCompletionBlock){
            _successCompletionBlock(self);
        }
        [self clearCompletionBlock];
        
    } else {
        [self failedOnCallingAPI:response withErrorType:XAFAPIManagerErrorTypeNoContent];
    }
}
//失败回调
- (void)failedOnCallingAPI:(XURLResponse *)response withErrorType:(XAFAPIManagerErrorType)errorType{
    self.errorType = errorType;
//    [self removeRequestIdWithRequestID:response.requestId];
    [[XAFApiProxy sharedInstance] removeRequestWithID:@(response.requestId)];
    if([_delegate respondsToSelector:@selector(managerCallApiDidFailed:)]){
        [_delegate managerCallApiDidFailed:self];
    }
    
    if(_failureCompletionBlock){
        _failureCompletionBlock(self);
    }
    [self clearCompletionBlock];
}

#pragma mark - private methods
- (XAFAPIManagerErrorType)responseErrorWithResponseStatus:(XURLResponseStatus )status{
    XAFAPIManagerErrorType type = XAFAPIManagerErrorTypeDefault;
    switch (status) {
        case XURLResponseStatusSucess:
            type = XAFAPIManagerErrorTypeSuccess;
            break;
        case XURLResponseStatusErrorTimeout:
            type = XAFAPIManagerErrorTypeTimeout;
            break;
        case XURLResponseStatusCancel:
            type = XAFAPIManagerErrorTypeCancel;
            break;
        case XURLResponseStatusErrorNoNetwork:
            type = XAFAPIManagerErrorTypeNoNetWork;
            break;
        default:
            break;
    }
    return type;
}
#pragma mark - getters and setters
//- (NSMutableArray *)requestIdList{
//    if (_requestIdList == nil) {
//        _requestIdList = [[NSMutableArray alloc] init];
//    }
//    return _requestIdList;
//}

- (BOOL)isReachable{
    BOOL isReachability = [XAFAppContext sharedInstance].isReachable;
    if (!isReachability) {
        self.errorType = XAFAPIManagerErrorTypeNoNetWork;
    }
    return isReachability;
}

- (BOOL)isLoading{
    return [[[XAFApiProxy sharedInstance] allTask] count] > 0;
//    return [XAFAPIBaseManager sharedInstance].requestIdList.count > 0;
//    return [self.requestIdList count] > 0;
}
@end
