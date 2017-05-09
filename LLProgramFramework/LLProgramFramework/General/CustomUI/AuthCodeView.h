//
//  AuthCodeView.h
//  MVC
//
//  Created by 大影象科技 on 2017/4/5.
//  Copyright © 2017年 liushaohua. All rights reserved.

//

#import <UIKit/UIKit.h>
/*本类用于生成随机验证码*/
@interface AuthCodeView : UIView

@property (strong, nonatomic) NSArray *dataArray;//字符素材数组
@property (strong, nonatomic) NSMutableString *authCodeStr;//验证码字符串

@end
