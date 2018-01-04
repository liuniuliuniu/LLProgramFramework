//
//  UIView+Animation.h
//  LLProgramFramework
//
//  Created by 奥卡姆 on 2018/1/3.
//  Copyright © 2018年 liushaohua. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, LLViewTransitionType) {
    LLViewTransitionTypeFade         = 0, // 交叉淡化过渡
    LLViewTransitionTypeMoveIn       = 1, // 把新视图移到旧视图上
    LLViewTransitionTypePush         = 2, // 新视图把旧视图推出去
    LLViewTransitionTypeReveal       = 3, // 将旧视图移开，显示新视图
    LLViewTransitionTypePageCurl     = 4, // 向上翻一页
    LLViewTransitionTypePageUnCurl   = 5, // 向下翻一页
    LLViewTransitionTypeRippleEffect = 6, // 滴水效果
    LLViewTransitionTypeSuckEffect   = 7, // 收缩效果，如一块布被抽走
    LLViewTransitionTypeCube         = 8, // 立方体效果
    LLViewTransitionTypeoglFlip      = 9, // 上下翻转效果
};

typedef NS_ENUM(NSUInteger, LLViewTransitionSubtype) {
    LLViewTransitionSubtypeFromLeft   = 0,
    LLViewTransitionSubtypeFromRight  = 1,
    LLViewTransitionSubtypeFromTop    = 2,
    LLViewTransitionSubtypeFromBottom = 3,
};

@interface UIView (Animation)

- (void)ll_animate;
- (void)ll_animateDuration:(CFTimeInterval)duration;
- (void)ll_animateDuration:(CFTimeInterval)duration
                      type:(LLViewTransitionType)type
                   subtype:(LLViewTransitionSubtype)subtype;
- (void)ll_animateScaleWithView:(UIView *)subView;


@end
