//
//  ViewController10.m
//  LockMore1
//
//  Created by xiekunpeng on 2020/7/30.
//  Copyright © 2020 xiekunpeng. All rights reserved.
//

#import "ViewController10.h"

@interface ViewController10 ()
@property (nonatomic, strong) dispatch_semaphore_t semaphore;
@end

@implementation ViewController10


- (void)viewDidLoad {
    [super viewDidLoad];
    self.semaphore = dispatch_semaphore_create(1);
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
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    [super saveMoney];
    dispatch_semaphore_signal(self.semaphore);
}

- (void)drawMoney {
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    [super drawMoney ];
    dispatch_semaphore_signal(self.semaphore);
}


@end
