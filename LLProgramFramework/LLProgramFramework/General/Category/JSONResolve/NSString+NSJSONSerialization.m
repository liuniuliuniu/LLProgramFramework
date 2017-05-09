//
//  NSString+NSJSONSerialization.m
//  BaseMVC
//
//  Created by liushaohua on 2017/4/5.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "NSString+NSJSONSerialization.h"

@implementation NSString (NSJSONSerialization)

- (id)objectFromJSONString
{
  return [self objectFromJSONStringWithParseOptions:NSJSONReadingMutableLeaves error:nil];
}

- (id)objectFromJSONStringWithParseOptions:(NSJSONReadingOptions)parseOptionFlags error:(NSError **)error
{
  NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
  return [NSJSONSerialization JSONObjectWithData:jsonData options:parseOptionFlags error:error];
}

@end
