//
//  LLLoadingView.m
//  LLProgramFramework
//
//  Created by 奥卡姆 on 2018/1/3.
//  Copyright © 2018年 liushaohua. All rights reserved.
//

#import "LLLoadingView.h"

@interface LLLoadingView ()

@property (nonatomic,weak) IBOutlet UIImageView * animImageV;
@property (nonatomic,strong) NSMutableArray * imageArrM;

@end
@implementation LLLoadingView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.imageArrM = [NSMutableArray array];
    /*此处赋值图片数组即可*/
    self.animImageV.animationImages = self.imageArrM;
}
- (void)startAnimation {
    [self.animImageV startAnimating];
}

- (void)stopAnimation {
    [self.animImageV startAnimating];
}



@end
