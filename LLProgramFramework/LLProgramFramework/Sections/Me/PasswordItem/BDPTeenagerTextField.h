//
//  BDPTeenagerTextField.h
//  LLProgramFramework
//
//  Created by liushaohua02 on 2021/3/2.
//  Copyright © 2021 liushaohua. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BDPTeenagerTextFieldDelegate <UITextFieldDelegate>

@optional
- (void)teenagerTextFieldDelegateBackWard:(UITextField *)textField;

@end

@interface BDPTeenagerTextField : UITextField

@property (nonatomic, weak) id<BDPTeenagerTextFieldDelegate> textFieldDelegate;


@end

NS_ASSUME_NONNULL_END
