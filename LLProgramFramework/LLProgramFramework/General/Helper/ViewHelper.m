//
//  ViewHelper.m
//  MVC
//
//  Created by 大影象科技 on 2017/4/5.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "ViewHelper.h"
#import "UIButton+Block.h"

@implementation ViewHelper
+ (void)createLabelWithFrame:(CGRect)frame title:(NSString *)title fontSize:(CGFloat)fontSize parentView:(UIView *)view fontColor:(UIColor *)color {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = color;
    [view addSubview:label];
}

+ (void)createButtonWithFrame:(CGRect)frame title:(NSString *)title parentView:(UIView *)view actionBlock:(void (^)())block {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTargetControlEvent:UIControlEventTouchUpInside actionBlock:block];
    [view addSubview:btn];
}

+ (UIViewController *)findViewController:(UIView *)view {
    if (view == nil) {
        UINavigationController *nvc = (UINavigationController *)[[UIApplication sharedApplication].delegate window].rootViewController;
        return nvc.visibleViewController;
    }else{
        id target = view;
        while (target) {
            target = ((UIResponder *)target).nextResponder;
            if ([target isKindOfClass:[UIViewController class]]) {
                break;
            }
        }
        return (UIViewController *)target;
    }
    return nil;
}

@end
