//
//  NoneDataPage.m
//  MVC
//
//  Created by 大影象科技 on 2017/4/5.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "NoneDataPage.h"

@implementation NoneDataPage

+ (void)showOnView:(UIView *)view {
    NoneDataPage *nonePage = [NoneDataPage instanceCreateNonePage];
    [view addSubview:nonePage];
    [view bringSubviewToFront:nonePage];
    
    // 增加masonry 适配页面显示效果
    [nonePage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view);
        make.right.equalTo(view);
        make.top.equalTo(view);
        make.bottom.equalTo(view);
    }];
}

#pragma mark -
+ (instancetype)instanceCreateNonePage {
    static NoneDataPage *nonePage = nil;
    nonePage = [[NSBundle mainBundle] loadNibNamed:@"NoneDataPage" owner:nil options:nil].firstObject;
    CGRect pageFrame = {CGPointZero, SCREEN_SIZE};
    nonePage.frame = pageFrame;
    return nonePage;
}

#pragma mark - DEBUG Method
#if DEBUG
- (void)dealloc {
    NSLog(@"DEALLOC ---> %@", [self class]);
}
#endif

@end
