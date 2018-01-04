//
//  LLScaleLayoutConstraint.m
//  LLProgramFramework
//
//  Created by 奥卡姆 on 2018/1/3.
//  Copyright © 2018年 liushaohua. All rights reserved.
//

#import "LLScaleLayoutConstraint.h"

@implementation LLScaleLayoutConstraint

- (void)awakeFromNib {
    [super awakeFromNib];
    CGFloat scale = MAIN_SCALE;
    self.constant = ceilf(self.constant * scale);
}

@end
