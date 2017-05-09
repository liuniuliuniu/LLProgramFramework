//
//  HomeModel.h
//  MVC
//
//  Created by 大影象科技 on 2017/4/5.
//  Copyright © 2017年 liushaohua. All rights reserved.

//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject

@property(nonatomic,assign) NSInteger code;
@property(nonatomic,strong) NSDictionary *data;
@property(nonatomic,copy) NSString *msg;

@end
