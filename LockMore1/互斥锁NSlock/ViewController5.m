//
//  ViewController5.m
//  LockMore1
//
//  Created by xiekunpeng on 2020/7/28.
//  Copyright © 2020年 xiekunpeng. All rights reserved.
//

#import "ViewController5.h"

@interface ViewController5 ()
@property (nonatomic, strong) NSLock *lock;
@end

@implementation ViewController5

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lock = [[NSLock alloc] init];
    [self handleMoney];
}

- (void)handleMoney {
    self.money = 100;
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i ++) {
            [weakSelf saveMoney];
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i ++) {
            [weakSelf drawMoney];
        }
    });
}

- (void)saveMoney{
    [self.lock lock];
    [super saveMoney];
    [self.lock unlock];
}

- (void)drawMoney {
    [self.lock lock];
    [super drawMoney ];
    [self.lock unlock];
}



@end
