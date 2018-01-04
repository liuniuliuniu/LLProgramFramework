//
//  UIView+Animation.m
//  LLProgramFramework
//
//  Created by 奥卡姆 on 2018/1/3.
//  Copyright © 2018年 liushaohua. All rights reserved.
//

#import "UIView+Animation.h"


static NSArray *typesArr;
static NSArray *subtypesArr;

@implementation UIView (Animation)

+ (void)initialize {
    typesArr = @[kCATransitionFade, kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal, @"pageCurl", @"pageUnCurl", @"rippleEffect", @"suckEffect", @"cube", @"oglFlip"];
    subtypesArr = @[kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom];
}

- (void)ll_animate {
    [self ll_animateDuration:0.5];
}

- (void)ll_animateDuration:(CFTimeInterval)duration {
    [self ll_animateDuration:duration type:LLViewTransitionTypeFade subtype:LLViewTransitionSubtypeFromLeft];
}

- (void)ll_animateDuration:(CFTimeInterval)duration
                      type:(LLViewTransitionType)type
                   subtype:(LLViewTransitionSubtype)subtype {
    CATransition *transition = [CATransition animation];
    transition.type = typesArr[type];
    transition.subtype = subtypesArr[subtype];
    transition.duration = duration;
    [self.layer addAnimation:transition forKey:@"transition"];
}

- (void)ll_animateScaleWithView:(UIView *)subView {
    self.alpha = 0;
    [UIView animateWithDuration:0.25f animations:^{
        self.alpha = 1;
    }];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@0.95,@1.0,@1.05,@1.0];
    animation.duration = 0.25;
    [subView.layer addAnimation:animation forKey:@""];
}




@end
