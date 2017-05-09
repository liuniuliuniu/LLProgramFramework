//
//  NSObject+XNetworkingMethods.m
//  XNetworking
//
//  Created by wangxi on 15/6/16.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import "NSObject+XNetworkingMethods.h"

@implementation NSObject (XNetworkingMethods)

- (id)X_defaultValue:(id)defaltData{
    if(![defaltData isKindOfClass:[self class]]){
        return defaltData;
    }
    if([self X_isEmptyObject]){
        return defaltData;
    }
    return self;
}

- (BOOL)X_isEmptyObject{
    if ([self isEqual:[NSNull null]]) {
        return YES;
    }
    if ([self isKindOfClass:[NSString class]]) {
        if ([(NSString *)self length] == 0) {
            return YES;
        }
    }
    if ([self isKindOfClass:[NSArray class]]) {
        if ([(NSArray *)self count] == 0) {
            return YES;
        }
    }
    if ([self isKindOfClass:[NSDictionary class]]) {
        if ([(NSDictionary *)self count] == 0) {
            return YES;
        }
    }
    return NO;
}


@end
