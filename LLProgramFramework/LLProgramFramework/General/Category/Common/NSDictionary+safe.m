//
//  NSDictionary+safe.m
//  TestNSArraySafe
//
//  Created by xuehan on 16/7/20.
//  Copyright © 2016年 xuehan. All rights reserved.
//

#import "NSDictionary+safe.h"
#import "NSObject+swizzling.h"
#import <objc/runtime.h>

@implementation NSDictionary (safe)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [objc_getClass("__NSPlaceholderDictionary") swizzleSelector:@selector(initWithObjects:forKeys:count:) withSwizzledSelector:@selector(zpSwizzing_initWithObjects:forKeys:count:)];
        [self swizzleSelector:@selector(dictionaryWithObjects:forKeys:count:) withSwizzledSelector:@selector(zpSwizzingClass_dictionaryWithObjects:forKeys:count:)];
    });
}

- (instancetype)zpSwizzing_initWithObjects:(const id  _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt{
    id safeObjects[cnt];
    id safeKeys[cnt];
    
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt ; i++) {
        id key = keys[i];
        id obj = objects[i];
        if (!key || !obj) {
            continue;
        }
        safeObjects[j] = obj;
        safeKeys[j] = key;
        j++;
    }
    return  [self zpSwizzing_initWithObjects:safeObjects forKeys:safeKeys count:j];
}


+ (instancetype)zpSwizzingClass_dictionaryWithObjects:(const id  _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt
{
    id safeObjects[cnt];
    id safeKeys[cnt];
    
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt ; i++) {
        id key = keys[i];
        id obj = objects[i];
        if (!key || !obj) {
            continue;
        }
        safeObjects[j] = obj;
        safeKeys[j] = key;
        j++;
    }
    return [self zpSwizzingClass_dictionaryWithObjects:safeObjects forKeys:safeKeys count:j];
}
@end
