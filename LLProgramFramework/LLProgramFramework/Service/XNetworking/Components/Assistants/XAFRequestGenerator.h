//
//  XAFRequestGenerator.h
//  XNetworking
//  助手类-生成NSURLRequest
//  Created by wangxi on 15/6/17.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XAFRequestGenerator : NSObject
+ (instancetype)sharedInstance;
- (NSURLRequest *)generateGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                            requestParams:(NSDictionary *)requestParams
                                               methodName:(NSString *)methodName;
- (NSURLRequest *)generatePOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                             requestParams:(NSDictionary *)requestParams
                                                methodName:(NSString *)methodName;
@end
