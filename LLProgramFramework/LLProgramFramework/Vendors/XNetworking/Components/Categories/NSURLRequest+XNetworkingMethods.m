//
//  NSURLRequest+XNetworkingMethods.m
//  XNetworking
//
//  Created by wangxi on 15/6/16.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import "NSURLRequest+XNetworkingMethods.h"
#import <objc/runtime.h>

@implementation NSURLRequest (XNetworkingMethods)

- (void)setRequestParams:(NSDictionary *)requestParams{

    objc_setAssociatedObject(self, @selector(requestParams), requestParams, OBJC_ASSOCIATION_COPY);

}

- (NSDictionary *)requestParams{

    return  objc_getAssociatedObject(self, _cmd);

}

@end
