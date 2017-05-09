//
//  XURLResponse.h
//  XNetworking
//  网络请求状态以及请求结果类 
//  Created by wangxi on 15/6/16.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XNetworkingConfiguration.h"

//@class XURLResponse;
//typedef void(^xurlResponseConfiguration)(XURLResponse *xurlResponse);

@interface XURLResponse : NSObject

@property (nonatomic, assign) XURLResponseStatus status;
@property (nonatomic, copy ) NSString *contentString;
@property (nonatomic, copy) id content;                //转换为NSDictionary 的数据或者原始数据
@property (nonatomic, assign) NSInteger requestId;
@property (nonatomic, copy) NSURLRequest *request;     //请求
@property (nonatomic, copy) NSData *responseData;      //请求回来原始数据
@property (nonatomic, copy) NSDictionary *requestParams;         //请求参数

//+ (instancetype)configurationWithblock:(xurlResponseConfiguration)block;
//- (instancetype)initWithBlock:(xurlResponseConfiguration)block;

- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData status:(XURLResponseStatus)status;
- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData error:(NSError *)error;

@end
