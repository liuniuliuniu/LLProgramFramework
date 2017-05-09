//
//  NSString+NSJSONSerialization.h
//  BaseMVC
//
//  Created by liushaohua on 2017/4/5.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 模仿JsonKit接口，使用系统Json解析
 默认UTF-8编码
 */

@interface NSString (NSJSONSerialization)

- (id)objectFromJSONString;
- (id)objectFromJSONStringWithParseOptions:(NSJSONReadingOptions)parseOptionFlags error:(NSError **)error;

@end
