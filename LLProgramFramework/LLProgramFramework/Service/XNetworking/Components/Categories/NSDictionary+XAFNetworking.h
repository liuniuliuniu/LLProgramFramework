//
//  NSDictionary+XAFNetworking.h
//  XNetworking
//
//  Created by wangxi on 15/6/18.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (XAFNetworking)
- (NSString *)xaf_urlParamsStringSignature:(BOOL)isForSignature;
- (NSString *)xaf_jsonString;
- (NSArray *)xaf_transformedUrlParamsArraySignature:(BOOL)isForSignature;
@end
