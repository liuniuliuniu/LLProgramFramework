//
//  BDPTeenagerPasswordView.m
//  LLProgramFramework
//
//  Created by liushaohua02 on 2021/3/2.
//  Copyright © 2021 liushaohua. All rights reserved.
//

#import "BDPTeenagerPasswordView.h"
#import <Masonry/Masonry.h>
#import "BDPTeenagerTextField.h"
#import "BDPTeenagerTextFieldItemView.h"

@interface BDPTeenagerPasswordView ()<BDPTeenagerTextFieldDelegate>

@property (nonatomic, strong) BDPTeenagerTextFieldItemView *textFieldFirstView;
@property (nonatomic, strong) BDPTeenagerTextFieldItemView *textFieldSecondView;
@property (nonatomic, strong) BDPTeenagerTextFieldItemView *textFieldThirdView;
@property (nonatomic, strong) BDPTeenagerTextFieldItemView *textFieldFourthView;
@property (nonatomic, strong) NSArray<BDPTeenagerTextFieldItemView *> *allTeenagerBgView;

@end

@implementation BDPTeenagerPasswordView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 禁止用户点击输入框
        self.userInteractionEnabled = NO;
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    BDPTeenagerTextFieldItemView *textFieldFirstView = [[BDPTeenagerTextFieldItemView alloc] init];
    self.textFieldFirstView = textFieldFirstView;
    [self addSubview:textFieldFirstView];
    
    BDPTeenagerTextFieldItemView *textFieldSecondView = [[BDPTeenagerTextFieldItemView alloc] init];
    self.textFieldSecondView = textFieldSecondView;
    [self addSubview:textFieldSecondView];
    
    BDPTeenagerTextFieldItemView *textFieldThirdView = [[BDPTeenagerTextFieldItemView alloc] init];
    self.textFieldThirdView = textFieldThirdView;
    [self addSubview:textFieldThirdView];
    
    BDPTeenagerTextFieldItemView *textFieldFourthView = [[BDPTeenagerTextFieldItemView alloc] init];
    self.textFieldFourthView = textFieldFourthView;
    [self addSubview:textFieldFourthView];
    
    self.allTeenagerBgView = @[textFieldFirstView,textFieldSecondView,textFieldThirdView,textFieldFourthView];
    CGFloat textFieldLength = 47;
    CGFloat itemMargin = 19;
    CGFloat textFieldTotalLength = textFieldLength * 4 + itemMargin * 3;
    CGFloat screenWidth =  [UIScreen mainScreen].bounds.size.width;
    CGFloat leftMargin = (screenWidth - textFieldTotalLength) * 0.5;
    [self.allTeenagerBgView mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:textFieldLength leadSpacing:0 tailSpacing:0];
    [self.allTeenagerBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.height.mas_offset(textFieldLength);
    }];
    
    __weak BDPTeenagerPasswordView *wealSelf = self;
    [self.allTeenagerBgView enumerateObjectsUsingBlock:^(BDPTeenagerTextFieldItemView * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.teenagerTextField.textFieldDelegate = wealSelf;
        [obj.teenagerTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }];
}

#pragma mark - public method
- (void)becomeKeyBoardFirstResponder {
    [self ba_setFirstResponderForIndex:1];
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry {
    [self.allTeenagerBgView  enumerateObjectsUsingBlock:^(BDPTeenagerTextFieldItemView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.teenagerTextField.secureTextEntry = secureTextEntry;
    }];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidChange:(UITextField *)textField{
    // 更新密码
    [self ba_updatePassWord];
    if ([textField isEqual:self.textFieldFirstView.teenagerTextField]) {
        [self ba_setFirstResponderForIndex:2];
    } else if ([textField isEqual:self.textFieldSecondView.teenagerTextField]) {
        [self ba_setFirstResponderForIndex:3];
    } else if ([textField isEqual:self.textFieldThirdView.teenagerTextField] ) {
        [self ba_setFirstResponderForIndex:4];
    }
}

#pragma mark - BDPTeenagerTextFieldDelegate
- (void)teenagerTextFieldDelegateBackWard:(UITextField *)textField {
    if (textField.text.length==0) {
        // 从第二个输入框开始处理
        if ([textField isEqual:self.textFieldSecondView.teenagerTextField]) {
            [self ba_setFirstResponderForIndex:1];
            self.textFieldFirstView.teenagerTextField.text = nil;
        } else if ([textField isEqual:self.textFieldThirdView.teenagerTextField] ) {
            [self ba_setFirstResponderForIndex:2];
            self.textFieldSecondView.teenagerTextField.text = nil;
        } else if ([textField isEqual:self.textFieldFourthView.teenagerTextField] ) {
            [self ba_setFirstResponderForIndex:3];
            self.textFieldThirdView.teenagerTextField.text = nil;
        }
    }
    [self ba_updatePassWord];
}


#pragma mark - private method
- (void)ba_setFirstResponderForIndex:(NSInteger)index {
    switch (index) {
        case 1:
            [self.textFieldFirstView.teenagerTextField becomeFirstResponder];break;
        case 2:
            [self.textFieldSecondView.teenagerTextField becomeFirstResponder];break;
        case 3:
            [self.textFieldThirdView.teenagerTextField becomeFirstResponder];break;
        case 4:
            [self.textFieldFourthView.teenagerTextField becomeFirstResponder];break;
        default:
            break;
    }
}

/// 更新密码
- (void)ba_updatePassWord {
    NSString *password = self.textFieldFirstView.teenagerTextField.text;
    password = [password stringByAppendingString:self.textFieldSecondView.teenagerTextField.text];
    password = [password stringByAppendingString:self.textFieldThirdView.teenagerTextField.text];
    password = [password stringByAppendingString:self.textFieldFourthView.teenagerTextField.text];
    _password = password;
    if (self.passwordBlock) {
        self.passwordBlock(_password);
    }
}


@end
