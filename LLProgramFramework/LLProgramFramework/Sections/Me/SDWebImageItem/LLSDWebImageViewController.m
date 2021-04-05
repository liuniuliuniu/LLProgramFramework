//
//  LLSDWebImageViewController.m
//  LLProgramFramework
//
//  Created by liushaohua02 on 2021/2/19.
//  Copyright © 2021 liushaohua. All rights reserved.
//

#import "LLSDWebImageViewController.h"
#import <FLAnimatedImage/FLAnimatedImage.h>

@interface LLSDWebImageViewController ()

@end

@implementation LLSDWebImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/2/2c/Rotating_earth_%28large%29.gif"]]];
    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
    imageView.animatedImage = image;
    imageView.frame = CGRectMake(0.0, 0.0, 100.0, 100.0);
    [self.view addSubview:imageView];
        
    
    
    
}

@end
