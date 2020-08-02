//
//  ViewController3.m
//  LockMore1
//
//  Created by xiekunpeng on 2020/7/28.
//  Copyright © 2020 xiekunpeng. All rights reserved.
//

#import "ViewController3.h"
 #import <pthread.h>


@interface ViewController3 ()
@property (nonatomic, assign) pthread_mutex_t  lock;
@property (nonatomic, assign) pthread_mutex_t  recursiveLock;

@end

@implementation ViewController3
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
/******************************互斥锁验证******************************/
    self.money = 100;
        ///初始化属性
    pthread_mutexattr_t att ;
    pthread_mutexattr_init(&att);
    ///设置锁的属性
    pthread_mutexattr_settype(&att, PTHREAD_MUTEX_DEFAULT);
    ///初始化锁
    pthread_mutex_init(&_lock, &att);
    ///销毁属性
     pthread_mutexattr_destroy(&att);
    [self handleMoney];

    
/******************************递归锁验证******************************/
    ///初始化属性
    pthread_mutexattr_t recursiveAtt ;
    pthread_mutexattr_init(&recursiveAtt);
    ///设置锁的属性
    pthread_mutexattr_settype(&recursiveAtt, PTHREAD_MUTEX_RECURSIVE);
    ///初始化锁
    pthread_mutex_init(&_recursiveLock, &recursiveAtt);
    ///销毁属性
    pthread_mutexattr_destroy(&recursiveAtt);
    [self recuresiveAction];
}

 
- (void)handleMoney {
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
    pthread_mutex_lock(&_lock);
    [super saveMoney];
    pthread_mutex_unlock(&_lock);
}

- (void)drawMoney {
    pthread_mutex_lock(&_lock);
    [super drawMoney ];
    pthread_mutex_unlock(&_lock);
}




/*************************************递归锁********************************************/
- (void)recuresiveAction {
    static int count = 10;
    pthread_mutex_lock(&_recursiveLock);
    NSLog(@"count: %d", count);

    if (count > 0) {
        count --;
        [self recuresiveAction];
    }
    pthread_mutex_unlock(&_recursiveLock);
}
/*************************************递归锁********************************************/

- (void)dealloc {
    pthread_mutex_destroy(&_lock);
    pthread_mutex_destroy(&_recursiveLock);
}


@end
