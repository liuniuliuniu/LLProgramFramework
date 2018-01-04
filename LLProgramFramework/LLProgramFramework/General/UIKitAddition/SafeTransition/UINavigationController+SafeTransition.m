//
//  UINavigationController+SafeTransition.m
//  LLProgramFramework
//
//  Created by 奥卡姆 on 2018/1/3.
//  Copyright © 2018年 liushaohua. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UINavigationController () <UINavigationControllerDelegate>

@property (nonatomic, assign) BOOL viewTransitionInProgress;

@end

@implementation UINavigationController (SafeTransition)

+ (void)load {
    
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(pushViewController:animated:)),
                                   class_getInstanceMethod(self, @selector(safePushViewController:animated:)));
    
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(popViewControllerAnimated:)),
                                   class_getInstanceMethod(self, @selector(safePopViewControllerAnimated:)));
    
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(popToRootViewControllerAnimated:)),
                                   class_getInstanceMethod(self, @selector(safePopToRootViewControllerAnimated:)));
    
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(popToViewController:animated:)),
                                   class_getInstanceMethod(self, @selector(safePopToViewController:animated:)));
}

#pragma mark - setter & getter
- (void)setViewTransitionInProgress:(BOOL)property {
    NSNumber *number = [NSNumber numberWithBool:property];
    objc_setAssociatedObject(self, @selector(viewTransitionInProgress), number, OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)viewTransitionInProgress {
    NSNumber *number = objc_getAssociatedObject(self, @selector(viewTransitionInProgress));
    return [number boolValue];
}

#pragma mark - Intercept Pop, Push, PopToRootVC
- (NSArray *)safePopToRootViewControllerAnimated:(BOOL)animated {
    if (self.viewTransitionInProgress) return nil;
    if (animated) {
        self.viewTransitionInProgress = YES;
    }
    NSArray *viewControllers = [self safePopToRootViewControllerAnimated:animated];
    if (viewControllers.count == 0) {
        self.viewTransitionInProgress = NO;
    }
    return viewControllers;
}

- (NSArray *)safePopToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 防止传入viewController为nil
    if (!viewController) return nil;
    if (self.viewTransitionInProgress) return nil;
    if (animated){
        self.viewTransitionInProgress = YES;
    }
    NSArray *viewControllers = [self safePopToViewController:viewController animated:animated];
    if (viewControllers.count == 0) {
        self.viewTransitionInProgress = NO;
    }
    return viewControllers;
}

- (UIViewController *)safePopViewControllerAnimated:(BOOL)animated {
    if (self.viewTransitionInProgress) return nil;
    
    if (animated) {
        self.viewTransitionInProgress = YES;
    }
    UIViewController *viewController = [self safePopViewControllerAnimated:animated];
    if (viewController == nil) {
        self.viewTransitionInProgress = NO;
    }
    return viewController;
}

- (void)safePushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 防止传入viewController为nil
    if (!viewController) return;
    if ([self.viewControllers containsObject:viewController]) return;
    if (self.viewTransitionInProgress == NO) {
        [self safePushViewController:viewController animated:animated];
        if (animated) {
            self.viewTransitionInProgress = YES;
        }
    }
}
@end

@implementation UIViewController (SafeTransitionLock)

+ (void)load {
    Method m1;
    Method m2;
    m1 = class_getInstanceMethod(self, @selector(safeViewDidAppear:));
    m2 = class_getInstanceMethod(self, @selector(viewDidAppear:));
    method_exchangeImplementations(m1, m2);
}

- (void)safeViewDidAppear:(BOOL)animated {
    self.navigationController.viewTransitionInProgress = NO;
    [self safeViewDidAppear:animated];
}

@end

