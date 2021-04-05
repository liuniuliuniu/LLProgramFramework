//
//  LLContainerUIComponentStandardDelegate.h
//  LLProgramFramework
//
//  Created by liushaohua02 on 2021/2/28.
//  Copyright © 2021 liushaohua. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef LLContainerUIComponentStandardDelegate_h
#define LLContainerUIComponentStandardDelegate_h

NS_ASSUME_NONNULL_BEGIN

@protocol LLContainerUIComponentAppearanceDelegate <NSObject>

@optional

/// UI组件大小，如果不实现默认读取view大小
- (CGRect)boundsOfUIComponentWithContainerSize:(CGSize)containerSize;


/// 是否允许跟随容器的滚动改变组件的alpha，不实现该方法默认允许。组件通常需要跟随框架滚动做alpha动画，因此此处默认是YES
- (BOOL)enableChangeUIComponentAlphaFollowContainerScroll;

/// 组件已经被添加到容器
- (void)componentDidAddToContainer;

/// 组件已经从容器中移除
- (void)componentDidRemovedFormContainer;

/// 是否允许框架容器释放UI组件，在调用componentDidRemovedFormContainer之后将回调该方法，
/// YES:不实现该方法的默认值，首页容器组件将不在持有该UI组件，如果没有其它对象持有该组件，该组件将被释放；
/// NO:首页容器将继续持有该UI组件，该UI组件不会被释放，在后续需要展示该UI组件时候，将继续使用持有的该UI组件对象
- (BOOL)enableContainerReleaseUIComponent;

@end

@protocol LLContainerUIComponentStandardDelegate <NSObject>

@required

/// 是否在容器中展示该组件，不保证一定调用该方法，因为有不同的容器类型，有的组件在某些类型下一定不展示，则不会调用该方法
+ (BOOL)shouldShowUIComponent;

/// UI组件ViewController
+ (UIViewController<LLContainerUIComponentAppearanceDelegate> *)uiComponentViewController;

@end

NS_ASSUME_NONNULL_END

#endif /* LLContainerUIComponentStandardDelegate_h */
