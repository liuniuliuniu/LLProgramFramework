//
//  LLContainerUIComponentAttribute.m
//  LLProgramFramework
//
//  Created by liushaohua02 on 2021/2/28.
//  Copyright © 2021 liushaohua. All rights reserved.
//

#import "LLContainerUIComponentAttribute.h"
#import "LLContainerUIComponentStandardDelegate.h"
#import "LLContainerUIComponentAttribute+Private.h"

/// 检查是否是合法的首页UI组件类
/// @param componentCls 组件类
BOOL isValidContainerUIComponent(__nullable Class componentCls) {
    if (componentCls
        && [componentCls conformsToProtocol:@protocol(LLContainerUIComponentStandardDelegate)]
        && [componentCls respondsToSelector:@selector(shouldShowUIComponent)]
        && [componentCls respondsToSelector:@selector(uiComponentViewController)]) {
        return YES;
    }
    return NO;
}

@implementation LLContainerUIComponentLayoutConstraint

- (void)setPreviousUIComponent:(Class<LLContainerUIComponentStandardDelegate>)previousUIComponent {
    if (isValidContainerUIComponent(previousUIComponent)) {
        _previousUIComponent = previousUIComponent;
    }
}

- (CGFloat)margin {
    if (_dynamicMagin) {
        return _dynamicMagin();
    }
    return _margin;
}


@end

@interface LLContainerUIComponentAttribute () {
    UIViewController<LLContainerUIComponentAppearanceDelegate> *_viewController;
    NSMutableDictionary <NSString *, LLContainerUIComponentLayoutConstraint *> *_layoutConstraintMap;
}
    
@end

@implementation LLContainerUIComponentAttribute

- (void)setCurrentUIComponent:(Class<LLContainerUIComponentStandardDelegate>)currentUIComponent {
    if (isValidContainerUIComponent(currentUIComponent)) {
        _currentUIComponent = currentUIComponent;
        _identifier = [NSString stringWithFormat:@"%p", currentUIComponent];
    }
}

- (void)setLayoutConstraints:(NSArray<LLContainerUIComponentLayoutConstraint *> *)layoutConstraints {
    if (!_layoutConstraints || ![_layoutConstraints isKindOfClass:[NSArray class]] || _layoutConstraints.count <= 0) {
        return;
    }
    
    NSMutableDictionary *layoutConstraintMap = [NSMutableDictionary dictionary];
    [layoutConstraints enumerateObjectsUsingBlock:^(LLContainerUIComponentLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[LLContainerUIComponentLayoutConstraint class]] && obj.previousUIComponent) {
            NSString *key = [NSString stringWithFormat:@"%p", obj.previousUIComponent];
            layoutConstraintMap[key] = obj;
        }
    }];
    _layoutConstraintMap = layoutConstraintMap;
}

/// 是否应该展示当前组件
- (BOOL)shouldShow {
    return [_currentUIComponent shouldShowUIComponent];
}

- (UIViewController<LLContainerUIComponentAppearanceDelegate> *)viewController {
    if (_viewController) {
        return _viewController;
    }
    _viewController = [self.currentUIComponent uiComponentViewController];
    return _viewController;
}

- (LLContainerUIComponentLayoutConstraint *)layoutConstraintForIdentifier:(NSString *)identifier {
    if (identifier) {
        LLContainerUIComponentLayoutConstraint *constraint = [_layoutConstraintMap objectForKey:identifier];
        if (constraint) {
            return constraint;
        }
    }
    if (_defalutLayoutConstraint) {
        return _defalutLayoutConstraint;
    }
    // 如果约束不存在，则返回一个默认的约束
    return [LLContainerUIComponentLayoutConstraint new];
}


- (void)destory {
    _isShowed = NO;
    if (!_viewController) {
        return;
    }
    if (_viewController.view.superview) {
        [_viewController.view removeFromSuperview];
    }
    [_viewController removeFromParentViewController];
    if ([self enableContainerReleaseUIComponent]) {
        _viewController = nil;
    }
}

- (BOOL)enableContainerReleaseUIComponent {
    if ([_viewController respondsToSelector:@selector(enableContainerReleaseUIComponent)]) {
        return [_viewController enableContainerReleaseUIComponent];
    }
    return YES;
}


@end
