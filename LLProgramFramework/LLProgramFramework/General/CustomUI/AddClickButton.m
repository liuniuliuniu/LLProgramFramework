//
//  AddClickButton.m
//  MVC
//
//  Created by 大影象科技 on 2017/4/5.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "AddClickButton.h"

@implementation AddClickButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect bounds = self.bounds;
    CGFloat widthDelta = 44.0 - bounds.size.width;
    CGFloat heightDelta = 44.0 - bounds.size.height;
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);	//注意这里是负数，扩大了之前的bounds的范围
    return CGRectContainsPoint(bounds, point);
}

@end
