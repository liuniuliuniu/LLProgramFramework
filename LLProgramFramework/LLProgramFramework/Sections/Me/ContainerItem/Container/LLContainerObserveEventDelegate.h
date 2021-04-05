//
//  LLContainerObserveEventDelegate.h
//  LLProgramFramework
//
//  Created by liushaohua02 on 2021/4/5.
//  Copyright © 2021 liushaohua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@protocol LLContainerObserveEventDelegate <NSObject>

- (void)containerScrollViewYoffset:(CGFloat)yoffset;

@end

NS_ASSUME_NONNULL_END
