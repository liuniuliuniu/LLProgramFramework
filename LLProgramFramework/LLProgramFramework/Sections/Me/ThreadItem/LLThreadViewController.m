//
//  LLThreadViewController.m
//  LLProgramFramework
//
//  Created by liushaohua02 on 2021/2/8.
//  Copyright © 2021 liushaohua. All rights reserved.
//

#import "LLThreadViewController.h"

@interface LLThreadViewController ()

@end

@implementation LLThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    LLBaseModel *testOne = [LLBaseModel new];
    testOne.titleName = @"GCD组任务";
    __weak LLThreadViewController *weakSelf = self;
    testOne.clickCallBack = ^(UIView *targetView) {
        [weakSelf ba_GCDGroupTest];
    };
    [self.menuItemModels addObject:testOne];
            
}

- (void)ba_GCDGroupTest {
    
    
    
}


@end
