//
//  LLContainerUIComponentRegister.h
//  LLProgramFramework
//
//  Created by liushaohua02 on 2021/2/28.
//  Copyright © 2021 liushaohua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLContainerUIComponentAttribute.h"

NS_ASSUME_NONNULL_BEGIN

@interface LLContainerUIComponentRegister : NSObject

+ (NSArray<LLContainerUIComponentAttribute *> *)containerUIComponents;

@end

NS_ASSUME_NONNULL_END
