//
//  LLHomeCell.m
//  LLProgramFramework
//
//  Created by 奥卡姆 on 2017/10/11.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "LLHomeCell.h"
#import "LLHomeModel.h"

@interface LLHomeCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end

@implementation LLHomeCell

- (void)setHomeModel:(LLHomeModel *)homeModel{
    _homeModel = homeModel;
    
    self.titleLbl.text = homeModel.title;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:homeModel.image]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

