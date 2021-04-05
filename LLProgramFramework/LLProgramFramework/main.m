//
//  main.m
//  LLProgramFramework
//
//  Created by 大影象科技 on 2017/4/5.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSLog(@"************* main **************");
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

__attribute__((constructor))
static void registerModule(void) {
    NSLog(@"*************__attribute__((constructor)) 修饰的方法 main之前 **************");
}

