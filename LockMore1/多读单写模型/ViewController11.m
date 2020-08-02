//
//  ViewController11.m
//  LockMore1
//
//  Created by xiekunpeng on 2020/7/31.
//  Copyright © 2020 xiekunpeng. All rights reserved.
//

#import "ViewController11.h"
#import <pthread.h>

@interface ViewController11 ()
@property (nonatomic, assign) pthread_rwlock_t lock;
@property (nonatomic, strong) dispatch_queue_t queue;
@end

@implementation ViewController11

- (void)viewDidLoad {
    [super viewDidLoad];

    /**
    如何实现一个多读单写的模型,需求如下
    同时可以有多个线程读取;
    同时只能有一个线程写入;
    同时只能执行读取或者写入的一种;
     */

    //方案1 dispatch_barrier_async
//    [self barrierAsyncType];
    //方案2 读写锁
    [self rwLockType];
 
    
}



/*********************************dispatch_barrier_async**********************************/
- (void)barrierAsyncType {
     self.queue = dispatch_queue_create("rw_queue", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 100; i ++) {
        [self barrierWriteAction];
        [self barrierWriteAction];
        [self barrierWriteAction];

        [self barrierReadAction];
        [self barrierReadAction];
        [self barrierReadAction];
    }
}

- (void)barrierReadAction {
    dispatch_async(self.queue, ^{
     sleep(1);
    NSLog(@"barrier Read Action   %@", [NSThread currentThread]);
    });
 }

- (void)barrierWriteAction {
    dispatch_barrier_async(self.queue, ^{
     sleep(1);
    NSLog(@"barrier Write Action   %@", [NSThread currentThread]);
    });
 }
/*********************************dispatch_barrier_async**********************************/





/***********************************pthread_rwlock_t*************************************/
- (void)rwLockType {
    pthread_rwlock_init(&_lock, NULL);
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    __weak typeof(self) weakSelf = self;
    for (int i = 0; i < 100; i ++) {
        dispatch_async(queue, ^{
            [weakSelf lockWriteAction];
        });
        dispatch_async(queue, ^{
            [weakSelf lockWriteAction];
        });
        dispatch_async(queue, ^{
            [weakSelf lockWriteAction];
        });
        
        
        dispatch_async(queue, ^{
            [weakSelf lockReadAction];
        });
        dispatch_async(queue, ^{
            [weakSelf lockReadAction];
        });
        dispatch_async(queue, ^{
            [weakSelf lockReadAction];
        });
    }
}



- (void)lockReadAction {
    pthread_rwlock_rdlock(&_lock);
    sleep(1);
    NSLog(@"RWLock Read Action   %@", [NSThread currentThread]);
    pthread_rwlock_unlock(&_lock);
}

- (void)lockWriteAction {
    pthread_rwlock_wrlock(&_lock);
    sleep(1);
    NSLog(@"RWLock Write Action   %@", [NSThread currentThread]);
    pthread_rwlock_unlock(&_lock);
}



- (void)dealloc {
    pthread_rwlock_destroy(&_lock);
}
/***********************************pthread_rwlock_t*************************************/


@end
