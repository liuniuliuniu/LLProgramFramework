//
//  UIImage+Color.h
//  BaseMVC
//
//  Created by liushaohua on 2017/4/5.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

/**
 根据颜色返回图片

 @param color 颜色
 @return 图片
 */
+ (UIImage*)createImageWithColor:(UIColor*) color;

@end
