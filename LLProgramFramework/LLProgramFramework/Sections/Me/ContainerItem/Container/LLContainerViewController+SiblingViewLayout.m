//
//  LLContainerViewController+SiblingViewLayout.m
//  LLProgramFramework
//
//  Created by liushaohua02 on 2021/3/9.
//  Copyright © 2021 liushaohua. All rights reserved.
//

#import "LLContainerViewController+SiblingViewLayout.h"
#import "LLContainerBackgroundViewController.h"
#import "LLContainerViewController+FlowViewLayout.h"

@implementation LLContainerViewController (SiblingViewLayout)

/// 初始化所有子视图
- (void)initAllSubViews {
    // 以下顺序决定了添加的视图层级
    [self initContainerBackgroundView];
    [self initFlowLayoutComponent];
}


- (void)initContainerBackgroundView {
    LLContainerBackgroundViewController *bgVC = [[LLContainerBackgroundViewController alloc] init];
    [self addChildViewController:bgVC];
    bgVC.view.frame = self.view.bounds;
    bgVC.view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:bgVC.view];
    [bgVC didMoveToParentViewController:self];
}


@end
