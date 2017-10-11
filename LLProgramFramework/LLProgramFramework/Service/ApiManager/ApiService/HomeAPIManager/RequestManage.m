//
//  RequestManage.m
//  LLProgramFramework
//
//  Created by 奥卡姆 on 2017/10/11.
//  Copyright © 2017年 liushaohua. All rights reserved.
//


#import "RequestManage.h"
#import "XAFServicesMVC.h"
#import "LLHomeModel.h"

@interface RequestManage () <XAFAPIManager,XAFAPIManagerValidator,XAFAPIManagerCallbackDataReformer>

@property(nonatomic,copy,readwrite) NSString *errorMessage;

@end

@implementation RequestManage

@synthesize errorMessage = _errorMessage;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.validator = self;
    }
    return self;
}

//- (id)manager:(XAFAPIBaseManager *)manager reformData:(NSDictionary *)data {
//    self.errorMessage = [self errorMessageWithErrorType:manager.errorType];
//    return [HomeModel mj_objectWithKeyValues:data];
//}

- (BOOL)manager:(XAFAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data {
    //
    //    HomeModel *model = [HomeModel mj_objectWithKeyValues:data];
    //    if (!model.data) {
    //        self.errorMessage = @"返回数据为空";
    //        return NO;
    //    }
    //    NSLog(@"%@",data);
    //    self.errorMessage = [self errorMessageWithErrorType:manager.errorType];
    return YES;
}

- (BOOL)manager:(XAFAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data {
    
    //    if (!data) {
    //        self.errorMessage = @"参数检查错误";
    //        return NO;
    //    }
    //    NSLog(@"%@",data);
    return YES;
}

- (XAFAPIManagerRequestType)requestType {
    return XAFAPIManagerRequestTypeGet;
}

- (NSString *)methodName {
    
    return @"4/news/latest";
}

- (NSString *)serviceId {
    return NSStringFromClass([XAFServicesMVC class]);
}

- (NSString *)errorMessageWithErrorType:(XAFAPIManagerErrorType)errorType {
    NSString *errorMsg = nil;
    switch (errorType) {
        case XAFAPIManagerErrorTypeDefault:
            errorMsg = @"没有产生过API请求";
            break;
        case XAFAPIManagerErrorTypeSuccess:
            errorMsg = @"API请求成功且返回数据正确";
            break;
        case XAFAPIManagerErrorTypeNoContent:
            errorMsg = @"API请求成功但返回数据不正确";
            break;
        case XAFAPIManagerErrorTypeParamsError:
            errorMsg = @"请求参数错误";
            break;
        case XAFAPIManagerErrorTypeTimeout:
            errorMsg = @"请求超时";
            break;
        case XAFAPIManagerErrorTypeNoNetWork:
            errorMsg = @"网络不通";
            break;
        case XAFAPIManagerErrorTypeCancel:
            errorMsg = @"手动取消请求";
            break;
        default:
            break;
    }
    return errorMsg;
}
@end

