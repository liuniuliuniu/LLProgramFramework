//
//  NSDictionary+NSJSONSerialization.m
//  BaseMVC
//
//  Created by liushaohua on 2017/4/5.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "NSDictionary+NSJSONSerialization.h"

@implementation NSDictionary (NSJSONSerialization)

- (NSString *)JSONString
{
  return [self JSONStringWithOptions:NSJSONWritingPrettyPrinted error:nil];
}

- (NSString *)JSONStringWithOptions:(NSJSONWritingOptions)serializeOptions error:(NSError **)error
{
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:serializeOptions error:nil];
  return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
