//
//  LLPasswordViewController.m
//  LLProgramFramework
//
//  Created by liushaohua02 on 2021/3/2.
//  Copyright © 2021 liushaohua. All rights reserved.
//

#import "LLPasswordViewController.h"
#import "BDPTeenagerPasswordView.h"
@interface LLPasswordViewController ()

@end

@implementation LLPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    BDPTeenagerPasswordView *passsWordView = [[BDPTeenagerPasswordView alloc] init];
    passsWordView.secureTextEntry = YES;
    [self.view addSubview:passsWordView];
    
    CGFloat textFieldLength = 47;
    CGFloat itemMargin = 19;
    CGFloat textFieldTotalLength = textFieldLength * 4 + itemMargin * 3;
    [passsWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.mas_offset(textFieldTotalLength);
        make.height.mas_equalTo(47);
    }];
    
    __weak LLPasswordViewController *weakSelf = self;
    passsWordView.passwordBlock = ^(NSString * _Nonnull password) {
        if (password.length == 4) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
        NSLog(@"当前输出密码为%@",password);
    };
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [passsWordView becomeKeyBoardFirstResponder];
    });
    
}

- (void)dealloc {
    NSLog(@">>>>>>>>>>>>>>>>>>>>dealloc");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
