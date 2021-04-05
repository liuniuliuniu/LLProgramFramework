//
//  BDPTeenagerTextField.m
//  LLProgramFramework
//
//  Created by liushaohua02 on 2021/3/2.
//  Copyright © 2021 liushaohua. All rights reserved.
//

#import "BDPTeenagerTextField.h"

@implementation BDPTeenagerTextField

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
    return self;    
}

- (void)deleteBackward {
    [super deleteBackward];
    BOOL conform = [self.textFieldDelegate conformsToProtocol:@protocol(BDPTeenagerTextFieldDelegate)];
    BOOL canResponse = [self.textFieldDelegate respondsToSelector:@selector(teenagerTextFieldDelegateBackWard:)];
    if (self.textFieldDelegate && conform && canResponse) {
        [self.textFieldDelegate teenagerTextFieldDelegateBackWard:self];
    }
}

- (void)setTextFieldDelegate:(id<BDPTeenagerTextFieldDelegate>)textFieldDelegate {
    _textFieldDelegate = textFieldDelegate;
    self.delegate = textFieldDelegate;
}

-(CGRect)caretRectForPosition:(UITextPosition *)position {
    CGRect nativeRect = [super caretRectForPosition:position];
    return CGRectMake(nativeRect.origin.x, nativeRect.origin.y + 2, nativeRect.size.width, nativeRect.size.height);
}

@end
