//
//  BDPTeenagerTextFieldItemView.m
//  LLProgramFramework
//
//  Created by liushaohua02 on 2021/3/2.
//  Copyright © 2021 liushaohua. All rights reserved.
//

#import "BDPTeenagerTextFieldItemView.h"
#import "BDPTeenagerTextField.h"
#import <Masonry/Masonry.h>

@implementation BDPTeenagerTextFieldItemView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.backgroundColor = [UIColor blueColor];
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowColor = [UIColor blueColor].CGColor;
    self.layer.shadowRadius = 9;
    self.layer.shadowOffset = CGSizeMake(0, 5);
    self.layer.cornerRadius = 9;
    
    BDPTeenagerTextField *textField = [[BDPTeenagerTextField alloc] init];
    self.teenagerTextField = textField;
    [self addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_offset(13);
        make.height.mas_offset(21);
    }];
}

@end
