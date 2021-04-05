//
//  LLContainerMiddleViewController.m
//  LLProgramFramework
//
//  Created by liushaohua02 on 2021/2/28.
//  Copyright © 2021 liushaohua. All rights reserved.
//

#import "LLContainerMiddleViewController.h"
#import "LLContainerUIComponentStandardDelegate.h"

@interface LLContainerMiddleViewController () <LLContainerUIComponentStandardDelegate,LLContainerUIComponentAppearanceDelegate>

@end

@implementation LLContainerMiddleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"middleView";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
    }];
}

+ (BOOL)shouldShowUIComponent {
    return YES;
}

+ (nonnull UIViewController<LLContainerUIComponentAppearanceDelegate> *)uiComponentViewController {
    return [[self alloc] init];
}

/// UI组件大小，如果不实现默认读取view大小
- (CGRect)boundsOfUIComponentWithContainerSize:(CGSize)containerSize {
    return CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
}

@end
