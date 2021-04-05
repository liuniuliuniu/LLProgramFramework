//
//  BDPTeenagerPasswordView.h
//  LLProgramFramework
//
//  Created by liushaohua02 on 2021/3/2.
//  Copyright © 2021 liushaohua. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^BDPTeenagerPasswordBlock)(NSString *password);

@interface BDPTeenagerPasswordView : UIView

/// 设置是否暗文显示
@property (assign, nonatomic) BOOL secureTextEntry;
/// 支付密码
@property (copy, nonatomic, readonly) NSString *password;
/// 输入完成block
@property (copy, nonatomic) BDPTeenagerPasswordBlock passwordBlock;

/// 让第一个输入框成为键盘第一响应者
- (void)becomeKeyBoardFirstResponder;

@end

NS_ASSUME_NONNULL_END
