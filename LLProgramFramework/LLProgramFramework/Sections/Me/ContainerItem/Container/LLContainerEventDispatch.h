//
//  LLContainerEventDispatch.h
//  LLProgramFramework
//
//  Created by liushaohua02 on 2021/2/28.
//  Copyright © 2021 liushaohua. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 事件传输总线
@interface LLContainerEventDispatch : NSObject

+ (instancetype)shareInstance;

/// 注册事件
/// @param eventObject 事件对象，注册完成后不会影响 eventObject 的生命周期
/// @param eventService 事件服务，即 eventObject 实现的事件协议
- (void)registerEventObject:(id)eventObject forService:(Protocol *)eventService;

/// 注册事件
/// @param eventObjects 事件对象数组，注册完成后不会影响 eventObject 的生命周期
/// @param eventService 事件服务，即 eventObject 实现的事件协议
- (void)registerEventObjects:(NSArray<id> *)eventObjects forService:(Protocol *)eventService;

/// 移除事件对象
/// @param eventObject  事件对象
/// @param eventService 事件服务，即 eventObject 实现的事件协议
- (void)removeEventObject:(id)eventObject forService:(Protocol *)eventService;


/// 移除所有事件对象
/// @param eventService 事件服务
- (void)removeAllEventObjectsForService:(Protocol *)eventService;


/// 获取所有事件对象
/// @param eventService 事件服务
- (NSArray *)eventObjectsForService:(Protocol *)eventService;


/// 获取第一个事件对象
/// @param eventService 事件服务
- (id)firstEventObjectForService:(Protocol *)eventService;


@end

NS_ASSUME_NONNULL_END
