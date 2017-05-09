//
//  BaseNavigationController.m
//  MVC
//
//  Created by liushaohua on 2016/10/5.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

+ (void)initialize
{
    // 1.取出设置主题的对象
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    
    // 2.设置导航栏的返回按钮颜色及背景图片
    if (IOS7_OR_LATER) {
        navigationBar.barTintColor = [UIColor redColor];
        navigationBar.tintColor = [UIColor whiteColor];
    }
    
    //    UIImage *navBarBg = [[UIImage imageNamed:@"icon_daohang_640"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    //    UIImage *navBarBg = [UIImage imageNamed:@"icon_daohang_640"];
    //    [navigationBar setBackgroundImage:navBarBg forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //    [navigationBar setShadowImage:[[UIImage alloc] init]];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // 3.标题
#ifdef __IPHONE_7_0
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]/*, NSFontAttributeName:[UIFont systemFontOfSize:18]*/}];
#else
    [navigationBar setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor whiteColor]/*, NSFontAttributeName:[UIFont systemFontOfSize:18]*/}];
#endif
}


@end
