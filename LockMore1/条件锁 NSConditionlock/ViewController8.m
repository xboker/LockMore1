//
//  ViewController8.m
//  LockMore1
//
//  Created by xiekunpeng on 2020/7/29.
//  Copyright © 2020 xiekunpeng. All rights reserved.
//

#import "ViewController8.h"

@interface ViewController8 ()
@property (nonatomic, strong) NSConditionLock *lock;
@end

@implementation ViewController8

- (void)viewDidLoad {
    [super viewDidLoad];
    //    如果不设置 condition 的值则默认为0
    //    self.lock = [[NSConditionLock alloc] init];
    self.lock = [[NSConditionLock alloc] initWithCondition:0];
    [self createThreads];
}


- (void)createThreads {
    /*
     需要执行的顺序为 A-B-C, 但是因为在子线程中所以我们不能确定谁先执行, 添加 sleep 使问题更突出点;
     */
    NSThread *c = [[NSThread alloc] initWithTarget:self selector:@selector(threadC) object:nil];
    [c start];
    sleep(0.2);
    NSThread *b = [[NSThread alloc] initWithTarget:self selector:@selector(threadB) object:nil];
    [b start];
    sleep(0.2);
    NSThread *a = [[NSThread alloc] initWithTarget:self selector:@selector(threadA) object:nil];
    [a start];
}

- (void)threadA {
    [self.lock lockWhenCondition:0];
    NSLog(@"A ThreadExcute");
    [self.lock unlockWithCondition:1];
}

- (void)threadB {
    [self.lock lockWhenCondition:1];
    NSLog(@"B ThreadExcute");
    [self.lock unlockWithCondition:2];
}

- (void)threadC {
    [self.lock lockWhenCondition:2];
    NSLog(@"C ThreadExcute");
    [self.lock unlock];
}
@end
