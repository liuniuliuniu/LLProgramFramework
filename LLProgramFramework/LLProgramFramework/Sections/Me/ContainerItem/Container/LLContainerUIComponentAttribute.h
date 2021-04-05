//
//  LLContainerUIComponentAttribute.h
//  LLProgramFramework
//
//  Created by liushaohua02 on 2021/2/28.
//  Copyright © 2021 liushaohua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLContainerUIComponentStandardDelegate.h"

NS_ASSUME_NONNULL_BEGIN


typedef CGFloat(^LLContainerUIComponentDynamicMagin)(void);

typedef NS_ENUM(NSInteger, LLContainerUIComponentHierarchyType) {
    /// 默认类型，从上至下的组件，越靠下的组件视图层级越高
    LLContainerUIComponentHierarchyTypeUp,
    LLContainerUIComponentHierarchyTypeBelow
};

typedef NS_ENUM(NSInteger, LLContainerUIConponentType) {
    /// 默认组件类型，无效
    LLContainerUIConponentTypeInvaild = 0,
    /// 上
    LLContainerUIConponentTypeTop = 1,
    /// 中
    LLContainerUIConponentTypeMiddle = 2,
    /// 下
    LLContainerUIConponentTypeDown = 3,
};


@interface LLContainerUIComponentLayoutConstraint : NSObject

/// 相对LLContainerUIComponentAttribute类中currentUIComponent属性的UI组件
@property (nonatomic) Class<LLContainerUIComponentStandardDelegate> previousUIComponent;
/// 间距currentUIComponent与previousUIComponent间距
@property (nonatomic, assign) CGFloat margin;
/// 动态间距
@property (nonatomic, copy) LLContainerUIComponentDynamicMagin dynamicMagin;
/// 视图层级，默认LLContainerUIComponentHierarchyType，即下方的UI组件视觉层级比上方UI组件视觉层级高
@property (nonatomic, assign) LLContainerUIComponentHierarchyType hierarchyType;

@end

// 容器的基本配置，可根据业务需求策略进行调整
@interface LLContainerUIComponentAttribute : NSObject

// 下拉容器是，位置是否固定不变
@property (nonatomic, assign) BOOL isFixedWhenPull;
// 设置每一个组件的类型，通过类型进行识别，方便解耦
@property (nonatomic, assign) LLContainerUIConponentType componentType;
/// 当前UI组件
@property (nonatomic) Class<LLContainerUIComponentStandardDelegate> currentUIComponent;
/// 当前UI组件与上方UI组件之间约束
@property (nonatomic) NSArray<LLContainerUIComponentLayoutConstraint *> *layoutConstraints;
/// 当前UI组件与上方UI组件默认约束，如果layoutConstraints没有设置，则返回该默认约束
@property (nonatomic, nullable) LLContainerUIComponentLayoutConstraint *defalutLayoutConstraint;
/// 组件是否已经显示
@property (nonatomic, assign) BOOL isShowed;

@end

NS_ASSUME_NONNULL_END
