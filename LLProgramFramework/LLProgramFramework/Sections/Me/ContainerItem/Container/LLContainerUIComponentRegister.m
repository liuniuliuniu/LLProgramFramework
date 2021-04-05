//
//  LLContainerUIComponentRegister.m
//  LLProgramFramework
//
//  Created by liushaohua02 on 2021/2/28.
//  Copyright © 2021 liushaohua. All rights reserved.
//

#import "LLContainerUIComponentRegister.h"
#import "LLContainerTopViewController.h"
#import "LLContainerMiddleViewController.h"
#import "LLContainerDownViewController.h"

@implementation LLContainerUIComponentRegister

+ (NSArray<LLContainerUIComponentAttribute *> *)containerUIComponents {
    // top组件
    LLContainerUIComponentAttribute *topAttribute = [LLContainerUIComponentAttribute new];
    topAttribute.componentType = LLContainerUIConponentTypeTop;
    topAttribute.currentUIComponent = LLContainerTopViewController.class;
    topAttribute.isFixedWhenPull = YES;
    
    
    /// middle组件
    LLContainerUIComponentAttribute *middleAttribute = [LLContainerUIComponentAttribute new];
    middleAttribute.componentType = LLContainerUIConponentTypeMiddle;
    middleAttribute.currentUIComponent = LLContainerMiddleViewController.class;
    // top与middle之间的约束
    LLContainerUIComponentLayoutConstraint *middleToTopConstraint = [LLContainerUIComponentLayoutConstraint new];
    middleToTopConstraint.previousUIComponent = topAttribute.currentUIComponent;
    middleToTopConstraint.margin = 10;
    middleAttribute.layoutConstraints = @[middleToTopConstraint];

    
    /// down组件
    LLContainerUIComponentAttribute *downAttribute = [LLContainerUIComponentAttribute new];
    downAttribute.componentType = LLContainerUIConponentTypeDown;
    downAttribute.currentUIComponent = LLContainerDownViewController.class;
    LLContainerUIComponentLayoutConstraint *downToMiddleConstraint = [LLContainerUIComponentLayoutConstraint new];
    downToMiddleConstraint.previousUIComponent = middleAttribute.currentUIComponent;
    downToMiddleConstraint.dynamicMagin = ^CGFloat{
        if (topAttribute.isShowed) {
            return 20.f;
        }
        return 50.f;
    };    
    return @[topAttribute, middleAttribute, downAttribute];
}

@end
