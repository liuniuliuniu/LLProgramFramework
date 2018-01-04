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

+ (void)initialize {
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    
    if (IOS7_OR_LATER) {
        navigationBar.barTintColor = [UIColor redColor];
        navigationBar.tintColor = [UIColor whiteColor];
    }

#ifdef __IPHONE_7_0
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]/*, NSFontAttributeName:[UIFont systemFontOfSize:18]*/}];
#else
    [navigationBar setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor whiteColor]/*, NSFontAttributeName:[UIFont systemFontOfSize:18]*/}];
#endif
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


@end
