//
//  NSDictionary+XAFNetworking.m
//  XNetworking
//
//  Created by wangxi on 15/6/18.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import "NSDictionary+XAFNetworking.h"
#import "NSArray+XAFNetworking.h"

@implementation NSDictionary (XAFNetworking)

/** 字符串前面是没有问号的，如果用于POST，那就不用加问号，如果用于GET，就要加个问号 */
- (NSString *)xaf_urlParamsStringSignature:(BOOL)isForSignature
{
    NSArray *sortedArray = [self xaf_transformedUrlParamsArraySignature:isForSignature];
    return [sortedArray xaf_paramsString];
}

/** 字典变json */
- (NSString *)xaf_jsonString
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:NULL];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

/** 转义参数 */
- (NSArray *)xaf_transformedUrlParamsArraySignature:(BOOL)isForSignature
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (![obj isKindOfClass:[NSString class]]) {
            obj = [NSString stringWithFormat:@"%@", obj];
        }
        if (!isForSignature) {
            
            obj = (NSString *)[obj stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//            obj = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,  (CFStringRef)obj,  NULL,  (CFStringRef)@"!*'();:@&;=+$,/?%#[]",  kCFStringEncodingUTF8));
        }
        if ([obj length] > 0) {
            [result addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
        }
    }];
    NSArray *sortedResult = [result sortedArrayUsingSelector:@selector(compare:)];
    return sortedResult;
}


@end
