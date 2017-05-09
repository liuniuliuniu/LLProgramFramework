//
//  ViewHelper.h
//  MVC
//
//  Created by 大影象科技 on 2017/4/5.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewHelper : NSObject

/**
 *  用于创建Label
 *
 *  @param frame    label的位置
 *  @param title    label的文字
 *  @param fontSize 文字大小
 *  @param view     父视图
 *  @param color    文字颜色
 */
+ (void)createLabelWithFrame:(CGRect)frame title:(NSString *)title fontSize:(CGFloat)fontSize parentView:(UIView *)view fontColor:(UIColor *)color;

/**
 *  创建UIButton
 *
 *  @param frame button的位置
 *  @param title button上面显示的文字
 *  @param view  父视图
 *  @param block 执行事件
 */
+ (void)createButtonWithFrame:(CGRect)frame title:(NSString *)title parentView:(UIView *)view actionBlock:(void(^)())block;

/**
 *  获取父视图的ViewController
 *
 *  @param view 可以不传值,不传值则是当前导航控制器的可见视图，传值则需要传入Controller的View
 *
 *  @return UIViewCotroller 当前可见的视图的Controller
 */
+ (UIViewController *)findViewController:(UIView *)view;

@end
