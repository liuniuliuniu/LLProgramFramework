//
//  LLContainerViewController+FlowViewLayout.m
//  LLProgramFramework
//
//  Created by liushaohua02 on 2021/4/5.
//  Copyright © 2021 liushaohua. All rights reserved.
//

#import "LLContainerViewController+FlowViewLayout.h"
#import "LLContainerViewController+Private.h"
#import "LLContainerUIComponentAttribute+Private.h"
#import "LLContainerUIComponentStandardDelegate.h"
#import "LLContainerEventDispatch.h"
#import "LLContainerObserveEventDelegate.h"

typedef void(^LLContainerNoParamBlock)(void);

@implementation LLContainerViewController (FlowViewLayout)

- (void)initFlowLayoutComponent {
    self.contentScrollView = [[LLContainerRootScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:self.contentScrollView];
    self.contentScrollView.showsVerticalScrollIndicator = NO;
    self.contentScrollView.delegate = self;
    
    if (@available(iOS 11.0, *)) {
        if ([self.contentScrollView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            self.contentScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    
    [self refreshAllFlowUIComponentInMainThreadWithAnimated:YES];
    
}

- (void)refreshAllFlowUIComponentInMainThreadWithAnimated:(BOOL)animated {
    /// 如果是在主线程，且当前没有正在刷新UI，则立即刷新，否则放在下一个runloop
    if ([NSThread isMainThread] && !self.isRefreshingAllFlowUI) {
        [self checkAndRefreshAllFlowUIComponentInMainThreadWithAnimated:animated];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self checkAndRefreshAllFlowUIComponentInMainThreadWithAnimated:animated];
        });
    }
}

- (void)checkAndRefreshAllFlowUIComponentInMainThreadWithAnimated:(BOOL)animated {
    self.isRefreshingAllFlowUI = YES;
    
    CGFloat statusBarHeight = STATUS_BAR_HEIGHT;
    CGFloat yOffset = statusBarHeight;
    
    NSMutableArray<LLContainerNoParamBlock> *frameAnimationOperations = [NSMutableArray array];
    NSMutableArray<LLContainerNoParamBlock> *alphaAnimationOperations = [NSMutableArray array];
    NSMutableArray<LLContainerNoParamBlock> *frameCompletionOperations = [NSMutableArray array];
    NSMutableArray<LLContainerNoParamBlock> *alphaCompletionOperations = [NSMutableArray array];
    LLContainerUIComponentAttribute *lastComponentAttribute = nil;
    
    for (LLContainerUIComponentAttribute *component in self.allFlowComponents) {
        BOOL shouldShow = [self shouldShowUIComponent:component
                             frameAnimationOperations:frameAnimationOperations
                              frameCompleteOperations:frameCompletionOperations
                             alphaAnimationOperations:alphaAnimationOperations
                              alphaCompleteOperations:alphaCompletionOperations];
        
        /// 如果不需要展示当前组件的话，则继续下一个组件
        if (!shouldShow) {
            continue;
        }
        
        
        BOOL showSuccess = [self updateAndShowUIComponent:component
                                           currentYOffset:&yOffset
                                   lastComponentAttribute:lastComponentAttribute
                                          frameOperations:frameAnimationOperations
                                frameCompletionOperations:frameCompletionOperations
                                          alphaOperations:alphaAnimationOperations
                                alphaCompletionOperations:alphaCompletionOperations];
        
        if (showSuccess) {
            lastComponentAttribute = component;
        }
    }
    
    [self finishLayoutForFrameOperations:frameAnimationOperations
               frameCompletionOperations:frameCompletionOperations
                         alphaOperations:alphaAnimationOperations
               alphaCompletionOperations:alphaCompletionOperations animated:YES];
    self.isRefreshingAllFlowUI = NO;
    
    self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, yOffset);
}

- (BOOL)shouldShowUIComponent:(LLContainerUIComponentAttribute *)component
     frameAnimationOperations:(NSMutableArray<LLContainerNoParamBlock> *)frameAnimationOperations
      frameCompleteOperations:(NSMutableArray<LLContainerNoParamBlock> *)frameCompleteOperations
     alphaAnimationOperations:(NSMutableArray<LLContainerNoParamBlock> *)alphaAnimationOperations
      alphaCompleteOperations:(NSMutableArray<LLContainerNoParamBlock> *)alphaCompleteOperations {
    /// 应该展示当前组件
    if ([component shouldShow]) {
        return YES;
    }
    
    /// .....中间各做业务的互斥显示逻辑
    
    
    // 如果组件已经正在展示&&允许在当前状态刷新UI，则做组件消失逻辑处理，并返回不允许展示组件
    LLContainerNoParamBlock aniamtionBlock = ^(void){
        CGRect frame = component.viewController.view.frame;
        frame.size.height = 0.f;
        component.viewController.view.frame = frame;
        component.viewController.view.alpha = 0.f;
    };
    [frameAnimationOperations addObject:aniamtionBlock];
    LLContainerNoParamBlock aniamtionCompletionBlock = ^(void){
        [component.viewController.view removeFromSuperview];
        // 通知业务方组件已销毁
        [component destory];
    };
    component.isShowed = NO;
    [frameCompleteOperations addObject:aniamtionCompletionBlock];
    return NO;
}


- (BOOL)updateAndShowUIComponent:(LLContainerUIComponentAttribute *)component
                  currentYOffset:(CGFloat *)currentYOffset
          lastComponentAttribute:(LLContainerUIComponentAttribute *)lastComponentAttribute
                 frameOperations:(NSMutableArray<LLContainerNoParamBlock> *)frameOperations
       frameCompletionOperations:(NSMutableArray<LLContainerNoParamBlock> *)frameCompletionOperations
                 alphaOperations:(NSMutableArray<LLContainerNoParamBlock> *)alphaOperations
       alphaCompletionOperations:(NSMutableArray<LLContainerNoParamBlock> *)alphaCompletionOperations {
    UIViewController<LLContainerUIComponentAppearanceDelegate> *viewController = [component viewController];
    if (!viewController) {
        /// 初始化VC失败
        return NO;
    }
    
    LLContainerUIComponentLayoutConstraint *constraint = [component layoutConstraintForIdentifier:lastComponentAttribute.identifier];
    
    CGFloat yOffset = *currentYOffset;
    yOffset += constraint.margin;
    CGRect bounds = viewController.view.bounds;
    
    bounds = viewController.view.bounds;
    if ([viewController respondsToSelector:@selector(boundsOfUIComponentWithContainerSize:)]) {
        bounds = [viewController boundsOfUIComponentWithContainerSize:self.contentScrollView.bounds.size];
    }
        
    if (!component.isShowed) {
        component.isShowed = YES;
        [self.contentViewController addChildViewController:viewController];
        [self.contentScrollView addSubview:viewController.view];
        [viewController didMoveToParentViewController:self.contentViewController];
        viewController.view.frame = CGRectMake((self.contentScrollView.frame.size.width - bounds.size.width)/2.f, yOffset, bounds.size.width, bounds.size.height);
        
        /// alpha动画
        viewController.view.alpha = 0.f;
        LLContainerNoParamBlock alphaChangeBlock = ^(void){
            viewController.view.alpha = 1.f;
        };
        [alphaOperations addObject:alphaChangeBlock];
        LLContainerNoParamBlock alphaCompletionBlock = ^(void){
            if ([viewController respondsToSelector:@selector(componentDidAddToContainer)]) {
                [viewController componentDidAddToContainer];
            }
        };
        [alphaCompletionOperations addObject:alphaCompletionBlock];
    }
    
    // frame动画
    CGRect frame = CGRectMake((self.contentScrollView.frame.size.width - bounds.size.width)/2.f, yOffset, bounds.size.width, bounds.size.height);
    component.fixedFrame = frame;
    LLContainerNoParamBlock frameChangeBlock = ^(void){
        viewController.view.frame = frame;
    };
    [frameOperations addObject:frameChangeBlock];
    
    yOffset += bounds.size.height;
    *currentYOffset = yOffset;
    return YES;
}


/// @param animated 是否以动画形式执行刷新结果
- (void)finishLayoutForFrameOperations:(NSArray<LLContainerNoParamBlock> *)frameOperations
             frameCompletionOperations:(NSArray<LLContainerNoParamBlock> *)frameCompletionOperations
                       alphaOperations:(NSArray<LLContainerNoParamBlock> *)alphaOperations
             alphaCompletionOperations:(NSArray<LLContainerNoParamBlock> *)alphaCompletionOperations
                              animated:(BOOL)animated {
    if (animated) {
        self.contentScrollView.userInteractionEnabled = NO;
        [UIView animateWithDuration:0.28f animations:^{
            [self executeBlocks:frameOperations];
        } completion:^(BOOL finished) {
            [self executeBlocks:frameCompletionOperations];
        }];
        
        [UIView animateWithDuration:0.16 delay:0.2f options:UIViewAnimationOptionCurveLinear animations:^{
            [self executeBlocks:alphaOperations];
        } completion:^(BOOL finished) {
            [self executeBlocks:alphaCompletionOperations];
            self.contentScrollView.userInteractionEnabled = YES;
        }];
    } else {
        [self executeBlocks:frameOperations];
        [self executeBlocks:frameCompletionOperations];
        [self executeBlocks:alphaOperations];
        [self executeBlocks:alphaCompletionOperations];                
    }
    
}

- (void)executeBlocks:(NSArray<LLContainerNoParamBlock> *)blocks {
    if (!blocks) {
        return;
    }
    [blocks enumerateObjectsUsingBlock:^(LLContainerNoParamBlock _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj();
    }];
}

#pragma mark - scrollview delagate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat yOffset = scrollView.contentOffset.y;
   NSArray<id<LLContainerObserveEventDelegate>> *eventObjects =  [[LLContainerEventDispatch shareInstance] eventObjectsForService:@protocol(LLContainerObserveEventDelegate)];
    [eventObjects enumerateObjectsUsingBlock:^(id<LLContainerObserveEventDelegate>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(containerScrollViewYoffset:)]) {
            [obj containerScrollViewYoffset:yOffset];
        }
    }];    
}


@end
