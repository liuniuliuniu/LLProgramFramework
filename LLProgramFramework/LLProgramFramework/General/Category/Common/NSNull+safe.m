//
//  NSNull+safe.m
//  WangliBank
//
//  Created by xuehan on 16/7/20.
//  Copyright © 2016年 iSoftstone infomation Technology (Group) Co.,Ltd. All rights reserved.
//

#import "NSNull+safe.h"
#import <objc/runtime.h>

#ifndef NULLSAFE_ENABLED
#define NULLSAFE_ENABLED 1
#endif

@implementation NSNull (safe)

#if NULLSAFE_ENABLED
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    @synchronized([self class])
    {
        //look up method signature
        NSMethodSignature *signature = [super methodSignatureForSelector:selector];
        if (!signature)
        {
            //not supported by NSNull, search other classes
            static NSMutableSet *classList = nil;
            static NSMutableDictionary *signatureCache = nil;
            if (signatureCache == nil)
            {
                classList = [[NSMutableSet alloc] init];
                signatureCache = [[NSMutableDictionary alloc] init];
                
                //get class list
                int numClasses = objc_getClassList(NULL, 0);
                Class *classes = (Class *)malloc(sizeof(Class) * (unsigned long)numClasses);
                numClasses = objc_getClassList(classes, numClasses);
                
                //add to list for checking
                NSMutableSet *excluded = [NSMutableSet set];
                for (int i = 0; i < numClasses; i++)
                {
                    //determine if class has a superclass
                    Class someClass = classes[i];
                    Class superclass = class_getSuperclass(someClass);
                    while (superclass)
                    {
                        if (superclass == [NSObject class])
                        {
                            [classList addObject:someClass];
                            break;
                        }
                        [excluded addObject:NSStringFromClass(superclass)];
                        superclass = class_getSuperclass(superclass);
                    }
                }
                
                //remove all classes that have subclasses
                for (Class someClass in excluded)
                {
                    [classList removeObject:someClass];
                }
                
                //free class list
                free(classes);
            }
            
            //check implementation cache first
            NSString *selectorString = NSStringFromSelector(selector);
            signature = signatureCache[selectorString];
            if (!signature)
            {
                //find implementation
                for (Class someClass in classList)
                {
                    if ([someClass instancesRespondToSelector:selector])
                    {
                        signature = [someClass instanceMethodSignatureForSelector:selector];
                        break;
                    }
                }
                
                //cache for next time
                signatureCache[selectorString] = signature ?: [NSNull null];
            }
            else if ([signature isKindOfClass:[NSNull class]])
            {
                signature = nil;
            }
        }
        return signature;
    }
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    invocation.target = nil;
    [invocation invoke];
}

#endif

@end
