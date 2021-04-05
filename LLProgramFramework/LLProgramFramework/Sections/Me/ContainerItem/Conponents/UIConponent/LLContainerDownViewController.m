//
//  LLContainerDownViewController.m
//  LLProgramFramework
//
//  Created by liushaohua02 on 2021/2/28.
//  Copyright © 2021 liushaohua. All rights reserved.
//

#import "LLContainerDownViewController.h"
#import "LLContainerUIComponentStandardDelegate.h"
#import "LLContainerObserveEventDelegate.h"
#import "LLContainerEventDispatch.h"

@interface LLContainerDownViewController () <LLContainerUIComponentStandardDelegate,LLContainerUIComponentAppearanceDelegate, LLContainerObserveEventDelegate>

@end

@implementation LLContainerDownViewController

- (void)loadView {
    [super loadView];
    [[LLContainerEventDispatch shareInstance] registerEventObject:self forService:@protocol(LLContainerObserveEventDelegate)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"downView";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
    }];
}


#pragma mark -  LLContainerObserveEventDelegate

- (void)containerScrollViewYoffset:(CGFloat)yoffset {
    NSLog(@">>>>>>%lf",yoffset);
}

#pragma mark -  LLContainerUIComponentStandardDelegate
+ (BOOL)shouldShowUIComponent {
    return YES;
}

+ (nonnull UIViewController<LLContainerUIComponentAppearanceDelegate> *)uiComponentViewController {
    return [[self alloc] init];
}

/// UI组件大小，如果不实现默认读取view大小
- (CGRect)boundsOfUIComponentWithContainerSize:(CGSize)containerSize {
    return CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, SCREEN_HEIGHT);
}


@end
