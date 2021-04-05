//
//  LLContainerViewController+Private.h
//  LLProgramFramework
//
//  Created by liushaohua02 on 2021/2/28.
//  Copyright © 2021 liushaohua. All rights reserved.
//

#ifndef LLContainerViewController_Private_h
#define LLContainerViewController_Private_h

#import "LLContainerViewController.h"
#import "LLContainerUIComponentAttribute.h"
#import "LLContainerRootScrollView.h"
@interface LLContainerViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIViewController *contentViewController;

@property (nonatomic, strong) NSArray<LLContainerUIComponentAttribute *> *allFlowComponents;

@property (nonatomic, strong) LLContainerRootScrollView *contentScrollView;

@property (nonatomic, assign) BOOL isRefreshingAllFlowUI;

@end

#endif /* LLContainerViewController_Private_h */
