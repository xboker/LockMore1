//
//  ViewController2.m
//  LockMore1
//
//  Created by xiekunpeng on 2020/7/26.
//  Copyright © 2020年 xiekunpeng. All rights reserved.
//

#import "ViewController2.h"
#import <os/lock.h>

@interface ViewController2 ()
@property (nonatomic, assign) NSInteger money;
@property (nonatomic, assign) os_unfair_lock  lock;
@end

@implementation ViewController2
- (void)viewDidLoad {
    [super viewDidLoad];
    self.money = 100;
    self.lock = OS_UNFAIR_LOCK_INIT;
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
    os_unfair_lock_lock(&_lock);
    [super saveMoney];
    os_unfair_lock_unlock(&_lock);
}

- (void)drawMoney {
    os_unfair_lock_lock(&_lock);
    [super drawMoney ];
    os_unfair_lock_unlock(&_lock);
}





@end
