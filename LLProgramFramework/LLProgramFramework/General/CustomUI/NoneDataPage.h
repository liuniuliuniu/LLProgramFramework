//
//  NoneDataPage.h
//  MVC
//
//  Created by 大影象科技 on 2017/4/5.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 无数据展示界面
 */
@interface NoneDataPage : UIView

// 直接使用页面
+ (void)showOnView:(UIView *)view;

// 创建无数据页面
+ (instancetype)instanceCreateNonePage;

@end
