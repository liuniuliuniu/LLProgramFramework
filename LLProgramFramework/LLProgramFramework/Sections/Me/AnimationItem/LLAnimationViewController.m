//
//  LLAnimationViewController.m
//  LLProgramFramework
//
//  Created by liushaohua02 on 2021/2/27.
//  Copyright © 2021 liushaohua. All rights reserved.
//

#import "LLAnimationViewController.h"

@interface LLAnimationViewController ()

@property (nonatomic, strong) UIView *testRedView;

@end

@implementation LLAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.testRedView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.testRedView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.testRedView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.testRedView.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
        
        
        [UIView animateWithDuration:4 animations:^{
            self.testRedView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
        
        }];
        
        
    });
    
    
        
}
@end
