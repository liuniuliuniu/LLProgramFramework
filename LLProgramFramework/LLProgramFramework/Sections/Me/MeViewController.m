//
//  MeViewController.m
//  MVC
//
//  Created by 大影象科技 on 2017/4/5.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "MeViewController.h"
#import "LLThreadViewController.h"
#import "LLProtocolViewController.h"
#import "LLSDWebImageViewController.h"
#import "LLAnimationViewController.h"
#import "LLContainerViewController.h"
#import "LLPasswordViewController.h"

@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试功能列表";
    LLBaseModel *threadItem = [[LLBaseModel alloc] init];
    threadItem.titleName = @"多线程操作";
    threadItem.className = NSStringFromClass([LLThreadViewController class]);
    [self.menuItemModels addObject:threadItem];
    
    LLBaseModel *protocolItem = [[LLBaseModel alloc] init];
    protocolItem.titleName = @"协议操作";
    protocolItem.className = NSStringFromClass([LLProtocolViewController class]);
    [self.menuItemModels addObject:protocolItem];
        
    LLBaseModel *SDWebImageItem = [[LLBaseModel alloc] init];
    SDWebImageItem.titleName = @"SDWebImage 相关测试";
    SDWebImageItem.className = NSStringFromClass([LLSDWebImageViewController class]);
    [self.menuItemModels addObject:SDWebImageItem];
    
    LLBaseModel *animationItem = [[LLBaseModel alloc] init];
    animationItem.titleName = @"Animation";
    animationItem.className = NSStringFromClass([LLAnimationViewController class]);
    [self.menuItemModels addObject:animationItem];
        
    LLBaseModel *containerItem = [[LLBaseModel alloc] init];
    containerItem.titleName = @"复杂业务容器解耦";
    containerItem.className = NSStringFromClass([LLContainerViewController class]);
    [self.menuItemModels addObject:containerItem];
    
    LLBaseModel *passwordItem = [[LLBaseModel alloc] init];
    passwordItem.titleName = @"密码界面";
    passwordItem.className = NSStringFromClass([LLPasswordViewController class]);
    [self.menuItemModels addObject:passwordItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
