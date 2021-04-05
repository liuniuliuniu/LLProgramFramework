//
//  UIView+Addition.m
//  LLProgramFramework
//
//  Created by 奥卡姆 on 2018/1/3.
//  Copyright © 2018年 liushaohua. All rights reserved.
//

#import "UIView+Addition.h"
#import <objc/runtime.h>

@implementation UIView (Addition)

+ (void)load {
    Method origin = class_getInstanceMethod(self, @selector(hitTest:withEvent:));
    Method swizMethod = class_getInstanceMethod(self, @selector(LL_hitTest:withEvent:));
    method_exchangeImplementations(origin, swizMethod);
    
    Method pointOrigin = class_getInstanceMethod(self, @selector(pointInside:withEvent:));
    Method pointSwized = class_getInstanceMethod(self, @selector(LL_pointInside:withEvent:));
    method_exchangeImplementations(pointOrigin, pointSwized);
}

- (UIView *)LL_hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *v = [self LL_hitTest:point withEvent:event];
    return v;
}

- (BOOL)LL_pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return [self LL_pointInside:point withEvent:event];
}

- (UIViewController *)viewController {
    
    return (UIViewController *)[self traverseResponderChainForUIViewController];
}

- (id) traverseResponderChainForUIViewController {
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [nextResponder traverseResponderChainForUIViewController];
    } else {
        return nil;
    }
}

+ (UIView *)viewWithBundleName:(NSString *)name {
    return [[[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil] objectAtIndex:0];
}

- (void)borderStyleWithColor:(UIColor*)color borderWidth:(CGFloat)borderWidth cornerRadiusStyleWithValue:(CGFloat)value {
    self.layer.cornerRadius = value;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = color.CGColor;
}

- (UIImage *)screenShot {    
    CGSize s = self.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数。
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)viewWithRounded:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)size {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
@end
