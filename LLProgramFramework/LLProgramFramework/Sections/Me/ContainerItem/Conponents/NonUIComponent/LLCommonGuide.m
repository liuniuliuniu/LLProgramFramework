//
//  LLCommonGuide.m
//  LLProgramFramework
//
//  Created by liushaohua02 on 2021/4/5.
//  Copyright © 2021 liushaohua. All rights reserved.
//

#import "LLCommonGuide.h"
#import "LLContainerObserveEventDelegate.h"

@interface LLCommonGuide ()<LLContainerObserveEventDelegate>

@end

@implementation LLCommonGuide

- (void)containerScrollViewYoffset:(CGFloat)yoffset {
    NSLog(@"根据Offset值进行处理 %lf", yoffset);
}

@end
