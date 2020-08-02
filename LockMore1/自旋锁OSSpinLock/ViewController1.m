//
//  ViewController1.m
//  LockMore1
//
//  Created by xiekunpeng on 2020/7/26.
//  Copyright © 2020年 xiekunpeng. All rights reserved.
//

#import "ViewController1.h"
#import <libkern/OSAtomic.h>


@interface ViewController1 ()
@property (nonatomic, assign) NSInteger money;
@property (nonatomic, assign) OSSpinLock lock;
@end

@implementation ViewController1
- (void)viewDidLoad {
    [super viewDidLoad];
    self.money = 100;
    self.lock = OS_SPINLOCK_INIT;
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
    OSSpinLockLock(&_lock);
    [super saveMoney];
    OSSpinLockUnlock(&_lock);
}

- (void)drawMoney {
    OSSpinLockLock(&_lock);
    [super drawMoney ];	
    OSSpinLockUnlock(&_lock);
}





@end
