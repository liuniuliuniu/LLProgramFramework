//
//  LLContainerUIComponentAttribute+Private.h
//  LLProgramFramework
//
//  Created by liushaohua02 on 2021/2/28.
//  Copyright © 2021 liushaohua. All rights reserved.
//



#ifndef LLContainerUIComponentAttribute_Private_h
#define LLContainerUIComponentAttribute_Private_h

#import "LLContainerUIComponentAttribute.h"

NS_ASSUME_NONNULL_BEGIN

@interface LLContainerUIComponentAttribute ()

/// 组件的唯一标示
@property (nonatomic, copy, nullable) NSString *identifier;
/// 组件固定 frame
@property (nonatomic, assign) CGRect fixedFrame;

/// 组件是否应该展示
- (BOOL)shouldShow;
/// 组件viewController
- (nullable UIViewController<LLContainerUIComponentAppearanceDelegate> *)viewController;
/// 通过组件的标示获取组件的约束
- (nullable LLContainerUIComponentLayoutConstraint *)layoutConstraintForIdentifier:(nullable NSString *)identifier;
/// 销毁组件
- (void)destory;

@end

NS_ASSUME_NONNULL_END

#endif /* LLContainerUIComponentAttribute_Private_h */
