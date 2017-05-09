//
//  HomeViewController.m
//  MVC
//
//  Created by liushaohua on 2017/4/5.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "HomeViewController.h"
#import "XAFHttpClient.h"
#import "RequestManage.h"

#import "LLPlaceholderTextView.h"

@interface HomeViewController () <XAFAPIManagerParamSourceDelegate>
@property(nonatomic,strong) RequestManage *manager;
@property(nonatomic,strong) NSDictionary *sellParam;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.sellParam = @{@"call":@"2"};
//    [self.manager loadData];
    
    [self.manager startWithCompletionBlockWithSuccess:^(XAFAPIBaseManager *request) {
        NSLog(@"success%@",request.errorMessage);
        id response = [request fetchDataWithReformer:(id <XAFAPIManagerCallbackDataReformer>)self.manager];
        NSLog(@"%@",response);
    } failure:^(XAFAPIBaseManager *request) {
        NSLog(@"fail%@",request.errorMessage);
    }];
}


- (NSDictionary *)paramsForApi:(XAFAPIBaseManager *)manager {
//    NSDictionary *sellParam = @{@"call":@"1"};
    return self.sellParam;
}

- (NSDictionary *)sellParam {
    if (!_sellParam) {
        _sellParam = @{@"call":@"1"};
    }
    return _sellParam;
}

- (RequestManage *)manager {
    if (!_manager) {
        _manager = [RequestManage new];
//        _manager.validator = self;
        _manager.paramSource = self;
    }
    return _manager;
}
@end
