//
//  LLLoading.m
//  LLProgramFramework
//
//  Created by 奥卡姆 on 2018/1/3.
//  Copyright © 2018年 liushaohua. All rights reserved.
//

#import "LLLoading.h"
#import "LLLoadingView.h"

#define kLoadingWidth    [UIScreen mainScreen].bounds.size.width
#define kLoadingHeight  [UIScreen mainScreen].bounds.size.height

@interface LLLoading ()

@property (nonatomic,strong) LLLoadingView * loadingView;

@end

@implementation LLLoading

+ (instancetype)shareInstance {
    static LLLoading *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (void)showIsKeyWindow:(BOOL)isKeyWindow {    
    LLLoadingView *loadingView = [[[NSBundle mainBundle] loadNibNamed:@"LLLoadingView" owner:nil options:nil] lastObject];
    _loadingView = loadingView;
    loadingView.frame = CGRectMake(0, 0, kLoadingWidth, kLoadingHeight);
    NSArray  *windows = [UIApplication sharedApplication].windows;
    UIWindow *tempWindow = nil;
    if (isKeyWindow == NO) {
        for(NSUInteger i = windows.count; i > 0; i--){
            UIWindow *window = windows[i-1];
            if(!window.hidden) {
                tempWindow = window;
                break;
            }
        }
    }
    else {
        tempWindow = [UIApplication sharedApplication].keyWindow;
    }
    [tempWindow addSubview:loadingView];
    [self.loadingView startAnimation];
}

+ (void)show {
    [[self shareInstance] showIsKeyWindow:NO];
}

- (void)hide {
    [self.loadingView stopAnimation];
    [_loadingView removeFromSuperview];
    _loadingView = nil;
}

+ (void)hide {
    [[self shareInstance] hide];
}

+ (void)showLoadingOnKeyWindow {
    [[self shareInstance] showIsKeyWindow:YES];
}






@end
