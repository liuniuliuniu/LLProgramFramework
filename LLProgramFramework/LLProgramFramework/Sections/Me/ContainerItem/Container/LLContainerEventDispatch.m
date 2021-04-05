//
//  LLContainerEventDispatch.m
//  LLProgramFramework
//
//  Created by liushaohua02 on 2021/2/28.
//  Copyright © 2021 liushaohua. All rights reserved.
//

#import "LLContainerEventDispatch.h"

@interface LLContainerEventDispatch ()

@property (nonatomic, strong) NSMutableDictionary <NSString *, NSHashTable *> *eventMap;

@end

@implementation LLContainerEventDispatch

+ (instancetype)shareInstance {
    static LLContainerEventDispatch *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LLContainerEventDispatch alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        _eventMap = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)registerEventObject:(id)eventObject forService:(Protocol *)eventService {
    if (!eventObject || !eventService) {
        return;
    }
    [self registerEventObjects:@[eventObject] forService:eventService];
}

- (void)registerEventObjects:(NSArray<id> *)eventObjects forService:(Protocol *)eventService {
    if (!eventService || !eventObjects || ![eventObjects isKindOfClass:[NSArray class]]) {
        return;
    }
    @synchronized (self) {
        NSString *eventKey = NSStringFromProtocol(eventService);
        NSHashTable *mapEventObjects = [_eventMap valueForKey:eventKey];
        if (!mapEventObjects) {
            mapEventObjects = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
            [_eventMap setObject:mapEventObjects forKey:eventKey];
        }
        [eventObjects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [mapEventObjects addObject:obj];
        }];
    }
}

- (void)removeEventObject:(id)eventObject forService:(Protocol *)eventService {
    if (!eventService || !eventObject) {
        return;
    }
    @synchronized (self) {
        NSString *eventKey = NSStringFromProtocol(eventService);
        NSHashTable *mapEventObjects = [_eventMap valueForKey:eventKey];
        if (mapEventObjects) {
            [mapEventObjects removeObject:eventObject];
        }
    }
}

- (void)removeAllEventObjectsForService:(Protocol *)eventService {
    if (!eventService) {
        return;
    }
    @synchronized (self) {
        NSString *eventKey = NSStringFromProtocol(eventService);
        [_eventMap removeObjectForKey:eventKey];
    }
}

- (NSArray *)eventObjectsForService:(Protocol *)eventService {
    if (!eventService) {
        return nil;
    }
    NSArray *eventObejcts = nil;
    @synchronized (self) {
        NSString *eventKey = NSStringFromProtocol(eventService);
        eventObejcts = [_eventMap objectForKey:eventKey].allObjects;
    }
    return eventObejcts;
}

- (id)firstEventObjectForService:(Protocol *)eventService {
    if (!eventService) {
        return nil;
    }
    return [self eventObjectsForService:eventService].firstObject;
}

@end
