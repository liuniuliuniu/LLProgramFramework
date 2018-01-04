//
//  NSObject+swizzling.m
//  TestNSArraySafe
//
//  Created by xuehan on 16/7/20.
//  Copyright © 2016年 xuehan. All rights reserved.
//

#import "NSObject+swizzling.h"
#import <objc/runtime.h>

@implementation NSObject (swizzling)
+ (void)swizzleSelector:(SEL)originalSelector withSwizzledSelector:(SEL)swizzledSelector
{
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    // 若已经存在，则添加会失败
    BOOL isAdd = class_addMethod(class,originalSelector,method_getImplementation(swizzledMethod),method_getTypeEncoding(swizzledMethod));
    
    // 若原来的方法并不存在，则添加即可
    if (isAdd) {
        class_replaceMethod(class,swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
@end
