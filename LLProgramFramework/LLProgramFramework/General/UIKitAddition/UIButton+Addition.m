//
//  UIButton+Addition.m
//  MVC
//
//  Created by 大影象科技 on 2017/4/5.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "UIButton+Addition.h"

@implementation UIButton (Addition)

+ (instancetype)buttonWithTitle:(NSString *)title fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor {
    NSAttributedString *attributedText = [[NSAttributedString alloc]
                                          initWithString:title
                                          attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize],
                                                       NSForegroundColorAttributeName: textColor}];
    
    return [self buttonWithAttributedText:attributedText];
}

+ (instancetype)buttonWithAttributedText:(NSAttributedString *)attributedText {
    return [self buttonWithAttributedText:attributedText imageName:nil backImageName:nil highlightSuffix:nil];
}

+ (instancetype)buttonWithImageName:(NSString *)imageName highlightSuffix:(NSString *)highlightSuffix {
    
    return [self buttonWithAttributedText:nil imageName:imageName backImageName:nil highlightSuffix:highlightSuffix];
}

+ (instancetype)buttonWithImageName:(NSString *)imageName backImageName:(NSString *)backImageName highlightSuffix:(NSString *)highlightSuffix {
    
    return [self buttonWithAttributedText:nil imageName:imageName backImageName:backImageName highlightSuffix:highlightSuffix];
}

+ (instancetype)buttonWithTitle:(NSString *)title fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor imageName:(NSString *)imageName backImageName:(NSString *)backImageName highlightSuffix:(NSString *)highlightSuffix {
    
    NSAttributedString *attributedText = [[NSAttributedString alloc]
                                          initWithString:title
                                          attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize],
                                                       NSForegroundColorAttributeName: textColor}];
    
    return [self buttonWithAttributedText:attributedText imageName:imageName backImageName:backImageName highlightSuffix:highlightSuffix];
}

+ (instancetype)buttonWithAttributedText:(NSAttributedString *)attributedText imageName:(NSString *)imageName backImageName:(NSString *)backImageName highlightSuffix:(NSString *)highlightSuffix {
    
    UIButton *button = [[self alloc] init];
    
    [button setAttributedTitle:attributedText forState:UIControlStateNormal];
    
    if (imageName != nil) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        
        NSString *highlightedImageName = [imageName stringByAppendingString:highlightSuffix];
        [button setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    }
    
    if (backImageName != nil) {
        [button setBackgroundImage:[UIImage imageNamed:backImageName] forState:UIControlStateNormal];
        
        NSString *highlightedImageName = [backImageName stringByAppendingString:highlightSuffix];
        [button setBackgroundImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    }
    
    [button sizeToFit];
    
    return button;
}

@end
