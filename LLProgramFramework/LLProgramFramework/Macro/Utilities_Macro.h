//
//  UtilitiesMacro.h
//  BaseMVC
//
//  Created by 大影象科技 on 2017/4/5.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#ifndef Utilities_Macro_h
#define Utilities_Macro_h

#define toString(d) [NSString stringWithFormat:@"%ld", d]
#define fToString(f) [NSString stringWithFormat:@"%.2f",f]

//画一像素的线
#define SINGLE_LINE_WIDTH          (FSystemVersion >= 8.0? (1 / [UIScreen mainScreen].scale):1)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

// 当前版本
#define FSystemVersion          ([[[UIDevice currentDevice] systemVersion] floatValue])
#define DSystemVersion          ([[[UIDevice currentDevice] systemVersion] doubleValue])
#define SSystemVersion          ([[UIDevice currentDevice] systemVersion])

//Screen
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define NAVIGATION_HEIGHT (IS_IPHONEX ? 88 : 64)
#define NAVIGATION_HEIGHT_IPHONEX 88
#define TAB_BAR_HEIGHT (IS_IPHONEX ? 83 : 49)
#define STATUS_BAR_HEIGHT (IS_IPHONEX ? 44 : 20)


// MARK: 设备相关
#define IS_IPHONE4 [[UIScreen mainScreen] bounds].size.height == 480.0
#define IS_IPHONE5 [[UIScreen mainScreen] bounds].size.height == 568.0
#define IS_IPHONE6 [[UIScreen mainScreen] bounds].size.height == 667.0
#define IS_IPHONE6PLUS [[UIScreen mainScreen] bounds].size.height == 736.0
#define IS_IPHONEX (([[UIScreen mainScreen] bounds].size.height-812)?NO:YES)

#define IOS10_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define IOS9_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS6_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IOS8_OR_EARLY ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0)

/*app block 调用
 */
#define CBInvokeBlock(block, ...) \
if (block)                      \
block(__VA_ARGS__)

#define WS(weakSelf)        __weak __typeof(&*self)weakSelf = self


/** 日志输出 */
#ifdef DEBUG // 测试!
#define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define NSLog(...)
#endif

#endif /* UtilitiesMacro_h */
