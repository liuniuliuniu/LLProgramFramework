//
//  UIView+Addition.h
//  LLProgramFramework
//
//  Created by 奥卡姆 on 2018/1/3.
//  Copyright © 2018年 liushaohua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Addition)

/// 获取当时视图控制器
- (UIViewController *)viewController;

/// 获取 xib 创建的视图
+ (UIView *)viewWithBundleName:(NSString *)name;

/// 设置圆角和边框
- (void)borderStyleWithColor:(UIColor*)color borderWidth:(CGFloat)borderWidth cornerRadiusStyleWithValue:(CGFloat)value;
/// 把当前 VIew 生成图片 
- (UIImage *)screenShot;

/**
 设置圆角

 @param rect view 的bounds
 @param corners  哪个角
 @param cornerRadii 圆角的
 */
- (void)viewWithRounded:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;


@end
