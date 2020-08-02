//
//  ViewController9.m
//  LockMore1
//
//  Created by xiekunpeng on 2020/7/30.
//  Copyright © 2020 xiekunpeng. All rights reserved.
//

#import "ViewController9.h"

@interface ViewController9 ()

@end

@implementation ViewController9

- (void)viewDidLoad {
    [super viewDidLoad];
    [self recuresiveAction];
}


- (void)recuresiveAction {
    @synchronized ([self class]) {
            static int count = 10;
        NSLog(@"count: %d", count);
        if (count > 0) {
            count --;
            [self recuresiveAction];
        }
    }
}


@end


