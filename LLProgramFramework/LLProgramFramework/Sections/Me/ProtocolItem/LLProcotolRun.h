//
//  LLProcotolRun.h
//  LLProgramFramework
//
//  Created by liushaohua02 on 2021/2/8.
//  Copyright © 2021 liushaohua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLProtocolEat.h"
NS_ASSUME_NONNULL_BEGIN

@protocol LLProcotolRun <NSObject, LLProtocolEat>

- (void)run;

@end

NS_ASSUME_NONNULL_END
