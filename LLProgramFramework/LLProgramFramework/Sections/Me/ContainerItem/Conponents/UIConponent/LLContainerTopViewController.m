//
//  LLContainerTopViewController.m
//  LLProgramFramework
//
//  Created by liushaohua02 on 2021/2/28.
//  Copyright © 2021 liushaohua. All rights reserved.
//

#import "LLContainerTopViewController.h"
#import "LLContainerUIComponentStandardDelegate.h"

@interface LLContainerTopViewController () <LLContainerUIComponentStandardDelegate,LLContainerUIComponentAppearanceDelegate>

@end

@implementation LLContainerTopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"topView";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
