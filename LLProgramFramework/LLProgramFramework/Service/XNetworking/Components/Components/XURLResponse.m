//
//  XURLResponse.m
//  XNetworking
//
//  Created by wangxi on 15/6/16.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import "XURLResponse.h"
#import "NSURLRequest+XNetworkingMethods.h"
#import "NSObject+XNetworkingMethods.h"

@implementation XURLResponse

//+(instancetype)configurationWithblock:(xurlResponseConfiguration)block{
//
//    return [[[self class] alloc] initWithBlock:block];
//}
//
//- (instancetype)initWithBlock:(xurlResponseConfiguration)block{
//
//    NSParameterAssert(block);
//    
//    self = [super init];
//    if(self){
//    
//        block(self);
//    }
//    
//    return self;
//}

#pragma mark - life cycle
- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData status:(XURLResponseStatus)status{
    self = [super init];
    if (self) {
        self.contentString = responseString;
        if (responseData) {
            self.content = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
        } else {
            self.content = nil;
        }
        self.status = status;
        self.requestId = [requestId integerValue];
        self.request = request;
        self.responseData = responseData;
        self.requestParams = request.requestParams;
    }
    return self;
}

- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData error:(NSError *)error{
    self = [super init];
    if (self) {
        self.contentString = [responseString X_defaultValue:@"s"];
        self.status = [self responseStatusWithError:error];
        self.requestId = [requestId integerValue];
        self.request = request;
        self.responseData = responseData;
        self.requestParams = request.requestParams;
        if (responseData) {
            self.content = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
        } else {
            self.content = nil;
        }
    }
    return self;
}


#pragma mark - private methods
- (XURLResponseStatus)responseStatusWithError:(NSError *)error{
    if (error) {
        XURLResponseStatus result = XURLResponseStatusErrorNoNetwork;
        // 除了超时以外，所有错误都当成是无网络
        if (error.code == NSURLErrorTimedOut) {
            result = XURLResponseStatusErrorTimeout;
        }
        else if (error.code == NSURLErrorCancelled){
            result = XURLResponseStatusCancel;
        }
        return result;
    } else {
        return XURLResponseStatusSucess;
    }
}

@end
