//
//  LLBaseModel.h
//  MVC
//
//  Created by liushaohua on 2016/10/5.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^LLClickCallBack)(UIView *targetView);

@interface LLBaseModel : NSObject
/// 标题名称
@property (nonatomic, copy) NSString *titleName;
/// 类名
@property (nonatomic, copy) NSString *className;

@property (nonatomic, copy) LLClickCallBack clickCallBack;

@end
