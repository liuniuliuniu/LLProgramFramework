//
//  LLProtocolViewController.m
//  LLProgramFramework
//
//  Created by liushaohua02 on 2021/2/8.
//  Copyright © 2021 liushaohua. All rights reserved.
//

#import "LLProtocolViewController.h"
#import "LLProcotolRun.h"

@interface LLProtocolViewController () <LLProcotolRun>

@end

@implementation LLProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)eat {
    NSLog(@">>>>>吃饭");
}

- (void)run {
    NSLog(@">>>>>跑步");
}


@end
