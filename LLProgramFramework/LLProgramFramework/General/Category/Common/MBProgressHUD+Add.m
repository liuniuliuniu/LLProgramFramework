//
//  MBProgressHUD+Add.m
//  MVC
//
//  Created by liushaohua on 2017/4/5.
//  Copyright © 2017年 liushaohua. All rights reserved.

//

#import "MBProgressHUD+Add.h"

@implementation MBProgressHUD (Add)
#pragma mark - 显示信息

+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) {
        view = [[UIApplication sharedApplication].delegate window];
    }
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Set the annular determinate mode to show task progress.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    hud.label.numberOfLines = 0;
    hud.label.font = [UIFont systemFontOfSize:17.0];
    hud.label.textColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = UIColorFromRGB(0X404040);
    hud.bezelView.alpha = 0.75;
    [hud hideAnimated:YES afterDelay:2.f];
}

#pragma mark - 显示错误信息

+ (void)showError:(NSString *)error toView:(UIView *)view
{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

#pragma mark - 显示一些信息

+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view
{
    if (view == nil) {
        view = [[UIApplication sharedApplication].delegate window];
    }
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Set the annular determinate mode to show task progress.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    hud.label.numberOfLines = 0;
    hud.label.font = [UIFont systemFontOfSize:17.0];
    hud.label.textColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = UIColorFromRGB(0X404040);
    hud.bezelView.alpha = 0.75;
    [hud hideAnimated:YES afterDelay:2.f];
    
    return hud;
}

#pragma mark - 自定义显示图片文字动画时间

+ (void)showHUDAddedTo:(UIView *)view
               message:(NSString *)message
             imageName:(NSString *)imageName
          animatedTime:(NSTimeInterval)animatedTime {
    if (view == nil) {
        view = [[UIApplication sharedApplication].delegate window];
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.mode = MBProgressHUDModeCustomView;
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.square = YES;
    hud.label.text = message;
    [hud hideAnimated:YES afterDelay:animatedTime];
}

@end
