//
//  LLContainerViewController.m
//  LLProgramFramework
//
//  Created by liushaohua02 on 2021/2/28.
//  Copyright © 2021 liushaohua. All rights reserved.
//

#import "LLContainerViewController.h"
#import "LLContainerEventRegister.h"
#import "LLContainerViewController+Private.h"
#import "LLContainerUIComponentRegister.h"
#import "LLContainerViewController+SiblingViewLayout.h"

/**
 假设一个容器中涉及了大量的业务UI组件，同时这些业务UI组件又是不同的业务方维护，那该如何降低这些业务组件直接的依赖呢
 */
@interface LLContainerViewController ()

@end

@implementation LLContainerViewController

- (void)loadView {
    [super loadView];
    /// 注册所有需要监听首页事件的对象
    [LLContainerEventRegister registerContainerEventObserver];
    _allFlowComponents = [LLContainerUIComponentRegister containerUIComponents];
       
    if (@available(iOS 11.0, *)) {
        //nothing
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    /// 初始化所有子视图
    [self initAllSubViews];        
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}


@end
