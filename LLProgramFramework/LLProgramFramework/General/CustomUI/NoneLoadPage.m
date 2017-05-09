//
//  NoneLoadPage.m
//  MVC
//
//  Created by 大影象科技 on 2017/4/5.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "NoneLoadPage.h"

@interface NoneLoadPage ()

@property (nonatomic, copy) dispatch_block_t reloadBlock;
@end

@implementation NoneLoadPage

#pragma mark - Private Method
- (IBAction)reloadButtonClick:(UIButton *)sender {
    if (self.reloadBlock) {
        self.reloadBlock();
        [sender.superview removeFromSuperview];
    }
}

#pragma mark - 类方法

+ (instancetype)instanceNonePage:(dispatch_block_t)reloadBlock {
    static NoneLoadPage *nonePage = nil;
    nonePage = [[NSBundle mainBundle] loadNibNamed:@"HHNonePage" owner:nil options:nil].firstObject;
    CGRect pageFrame = {CGPointZero, SCREEN_SIZE};
    nonePage.frame = pageFrame;
    nonePage.reloadBlock = reloadBlock;
    return nonePage;
}

+ (void)showOnView:(UIView *)view reloadBlock:(dispatch_block_t)reloadBlock {
    NoneLoadPage *nonePage = [NoneLoadPage instanceNonePage:reloadBlock];
    [view addSubview:nonePage];
    [view bringSubviewToFront:nonePage];
}

+ (void)removeSelfFromView:(UIView *)view {
    [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NoneLoadPage class]]) {
            [obj removeFromSuperview];
            obj = nil;
        }
    }];
}

#pragma mark - DEBUG Method
#if DEBUG
- (void)dealloc {
    NSLog(@"DEALLOC ---> %@", [self class]);
}
#endif


@end
