//
//  XAFAPIBaseManager.h
//  XNetworking
//
//  Created by wangxi on 15/6/19.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XAFAPIBaseManager;
// 在调用成功之后的params字典里面，用这个key可以取出requestID
static NSString * const kXAPAPIBaseManagerRequestID = @"kXAPAPIBaseManagerRequestID";


/***************************************************************************************/
/* XAFAPImanagerParamSourceDelegate //让manager能够获取调用API所需要的数据                 */
/***************************************************************************************/

@protocol XAFAPIManagerParamSourceDelegate <NSObject>
@required
- (NSDictionary *)paramsForApi:(XAFAPIBaseManager *)manager;
@end

/***************************************************************************************/
/*      XAFAPIManagerValidator 验证请求参数和请求返回的数据的正确性检查                       */
/***************************************************************************************/

@protocol XAFAPIManagerValidator <NSObject>
@required
//所有请求返回的数据都在这里检查，不用在controller的delegate里面在进行判断了
- (BOOL)manager:(XAFAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data;

//检测请求参数的正确性，特殊情况下需要检测，比如用户输入的，比如检测手机号码是否正确
- (BOOL)manager:(XAFAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data;

@end
/***************************************************************************************/
/*       这里可以做一个拦截器的   @protocol 但是暂时没用到所以先不做处理                       */
/***************************************************************************************/




/***************************************************************************************/
/*                 XAFAPIBaseManager 请求回调delegate                                   */
/***************************************************************************************/

@protocol XAFAPIManagerApiCallBackDelegate <NSObject>
@required
- (void)managerCallApiDidSuccess:(XAFAPIBaseManager *)manager;
- (void)managerCallApiDidFailed:(XAFAPIBaseManager *)manager;
@end


/***************************************************************************************/
/*                 DataReformer 负责重新组装API数据的对象                                  */
/***************************************************************************************/

/*
 
 下面描述一下使用reformer的流程。
 1.controller获得view的reformer
 2.controller给获得的reformer提供一些辅助数据，如果没有辅助数据，这一步可以省略。
 3.controller调用manager的 fetchDataWithReformer: 获得数据
 4.将数据交给view
 
 如何使用reformer：
 ContentRefomer *reformer = self.topView.contentReformer;    //reformer是属于需求方的，此时的需求方是topView
 reformer.contentParams = self.filter.params;                //如果不需要controller提供辅助数据的话，这一步可以不要。
 id data = [self.manager fetchDataWithReformer:reformer];
 [self.view configWithData:data];
 
 */


@protocol XAFAPIManagerCallbackDataReformer <NSObject>
- (id)manager:(XAFAPIBaseManager *)manager reformData:(NSDictionary *)data;
@end

/*
 当产品要求返回数据不正确或者为空的时候显示一套UI，请求超时和网络不通的时候显示另一套UI时，使用这个enum来决定使用哪种UI。（安居客PAD就有这样的需求，sigh～）
 你不应该在回调数据验证函数里面设置这些值，事实上，在任何派生的子类里面你都不应该自己设置manager的这个状态，baseManager已经帮你搞定了。
 强行修改manager的这个状态有可能会造成程序流程的改变，容易造成混乱。
 */
typedef NS_ENUM (NSUInteger, XAFAPIManagerErrorType){
    XAFAPIManagerErrorTypeDefault,       //没有产生过API请求，这个是manager的默认状态。
    XAFAPIManagerErrorTypeSuccess,       //API请求成功且返回数据正确，此时manager的数据是可以直接拿来使用的。
    XAFAPIManagerErrorTypeNoContent,     //API请求成功但返回数据不正确。如果回调数据验证函数返回值为NO，manager的状态就会是这个。
    XAFAPIManagerErrorTypeParamsError,   //请求参数错误，此时manager不会调用API，因为参数验证是在调用API之前做的。
    XAFAPIManagerErrorTypeTimeout,       //请求超时。RTApiProxy设置的是20秒超时，具体超时时间的设置请自己去看RTApiProxy的相关代码。
    XAFAPIManagerErrorTypeNoNetWork,      //网络不通。在调用API之前会判断一下当前网络是否通畅，这个也是在调用API之前验证的，和上面超时的状态是有区别的。
    XAFAPIManagerErrorTypeCancel         //手动取消请求
};

typedef NS_ENUM (NSUInteger, XAFAPIManagerRequestType){
    XAFAPIManagerRequestTypeGet,
    XAFAPIManagerRequestTypePost
};

/***************************************************************************************/
/*                 XAFAPIManager XAFAPIBaseManager的派生类必须符合这些protocal                                  */
/***************************************************************************************/

@protocol XAFAPIManager <NSObject>
@required
- (NSString *)methodName;
- (NSString *)serviceId;
- (XAFAPIManagerRequestType)requestType;
@optional
- (NSDictionary *)reformParams:(NSDictionary *)params;
- (void)cleanData;
@end


@interface XAFAPIBaseManager : NSObject
@property (nonatomic, weak) id<XAFAPIManagerApiCallBackDelegate> delegate;
@property (nonatomic, weak) id<XAFAPIManagerParamSourceDelegate> paramSource;
@property (nonatomic, weak) id<XAFAPIManagerValidator> validator;
@property (nonatomic, weak) NSObject <XAFAPIManager> *child;
//@property (nonatomic, strong) NSMutableArray *requestIdList;          //存储请求的id
/*
 baseManager是不会去设置errorMessage的，派生的子类manager可能需要给controller提供错误信息。所以为了统一外部调用的入口，设置了这个变量。
 派生的子类需要通过extension来在保证errorMessage在对外只读的情况下使派生的manager子类对errorMessage具有写权限。
 */
@property (nonatomic, copy, readonly) NSString *errorMessage;
@property (nonatomic, readonly) XAFAPIManagerErrorType errorType;
//状态
@property (nonatomic, assign, readonly) BOOL isReachable;
@property (nonatomic, assign, readonly) BOOL isLoading;
//回调
@property (nonatomic, copy) void (^successCompletionBlock)(XAFAPIBaseManager *);
@property (nonatomic, copy) void (^failureCompletionBlock)(XAFAPIBaseManager*);

+ (instancetype)sharedInstance;
/// block回调
- (void)startWithCompletionBlockWithSuccess:(void (^)(XAFAPIBaseManager *request))success
                                    failure:(void (^)(XAFAPIBaseManager *request))failure;
- (void)setCompletionBlockWithSuccess:(void (^)(XAFAPIBaseManager *request))success
                              failure:(void (^)(XAFAPIBaseManager *request))failure;

/// 把block置nil来打破循环引用
- (void)clearCompletionBlock;
//通过传进去的对应的reformer 来解析数据，返回reformer对应的数据结构 内部会调用XAFAPIManagerCallbackDataReformer函数
- (id)fetchDataWithReformer:(id<XAFAPIManagerCallbackDataReformer>)reformer;

//尽量使用loadData这个方法,这个方法会通过param source来获得参数，这使得参数的生成逻辑位于controller中的固定位置
- (NSInteger)loadData;

+ (void)cancelAllRequests;
- (void)cancelRequestWithRequestId:(NSInteger)requestID;

- (void)cleanData;
@end
