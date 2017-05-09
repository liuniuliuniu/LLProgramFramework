//
//  NSDictionary+NSJSONSerialization.h
//  BaseMVC
//
//  Created by liushaohua on 2017/4/5.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NSJSONSerialization)

- (NSString *)JSONString;
- (NSString *)JSONStringWithOptions:(NSJSONWritingOptions)serializeOptions error:(NSError **)error;

@end
