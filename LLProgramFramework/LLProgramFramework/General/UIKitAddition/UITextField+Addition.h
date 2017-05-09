//
//  UITextField+Addition.h
//  MVC
//
//  Created by 大影象科技 on 2017/4/5.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Addition)

/// 实例化 UITextField
///
/// @param placeHolder     占位文本
///
/// @return UITextField
+ (nonnull instancetype)textFieldWithPlaceHolder:(nonnull NSString *)placeHolder;

@end
