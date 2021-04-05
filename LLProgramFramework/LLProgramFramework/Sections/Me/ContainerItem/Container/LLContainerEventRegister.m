//
//  LLContainerEventRegister.m
//  LLProgramFramework
//
//  Created by liushaohua02 on 2021/2/28.
//  Copyright © 2021 liushaohua. All rights reserved.
//

#import "LLContainerEventRegister.h"
#import "LLContainerEventDispatch.h"
#import "LLContainerObserveEventDelegate.h"
#import "LLCommonGuide.h"

@implementation LLContainerEventRegister

+ (void)registerContainerEventObserver {    
    Protocol *service = @protocol(LLContainerObserveEventDelegate);
    
    static NSArray *object = nil;
    object = @[[[LLCommonGuide alloc] init]];
    [[LLContainerEventDispatch shareInstance] registerEventObjects:object forService:service];
}

@end
