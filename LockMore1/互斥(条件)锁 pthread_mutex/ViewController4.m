//
//  ViewController4.m
//  LockMore1
//
//  Created by xiekunpeng on 2020/7/28.
//  Copyright © 2020 xiekunpeng. All rights reserved.
//

#import "ViewController4.h"
#import <pthread.h>


@interface ViewController4 ()
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, assign) pthread_mutex_t lock;
@property (nonatomic, assign) pthread_cond_t condition;
@end

@implementation ViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     首先设定以下使用场景, 两条线程 A和B, A线程中执行删除数组元素, B 线程中执行添加数组元素;
     由于不知道哪个线程会先执行, 所以需要加锁实现, 只有在添加后才能执行删除操作;为互斥锁添加条件可以实现;
     */
    
    ///初始化锁
    pthread_mutexattr_t att;
    pthread_mutexattr_init(&att);
    pthread_mutexattr_settype(&att, PTHREAD_MUTEX_DEFAULT);
    pthread_mutex_init(&_lock, &att);
    pthread_mutexattr_destroy(&att);
    
    ///初始化条件
    pthread_cond_init(&_condition, NULL);
    
    
    NSThread *deThread = [[NSThread alloc] initWithTarget:self selector:@selector(deleteObj) object:nil];
    [deThread start];
    ///sleep一秒. 确保删除元素的线程先获得锁;
    sleep(1);
    NSThread *adThread = [[NSThread alloc] initWithTarget:self selector:@selector(addObj) object:nil];
    [adThread start];
    
}

- (void)deleteObj {
    pthread_mutex_lock(&_lock);
    NSLog(@"delete begin");
    ///添加判断, 如果没有数据则添加条件
    if (self.dataArr.count < 1) {
        /**
         添加条件, 如果数组为空, 则添加等待线程休眠, 将锁让出;  接受到信号时会再次加锁, 然后继续向下执行;
         */
        pthread_cond_wait(&_condition, &_lock);
    }
    
    [self.dataArr removeLastObject];
    NSLog(@"数组执行删除元素操作");
    pthread_mutex_unlock(&_lock);
}

- (void)addObj {
    pthread_mutex_lock(&_lock);
    NSLog(@"add begin");
    [self.dataArr addObject:@"HTI"];
    ///发送新号, 说明已经添加元素了;
    pthread_cond_signal(&_condition);
    NSLog(@"数组执行添加元素操作");
    pthread_mutex_unlock(&_lock);
}


- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return  _dataArr;
}

- (void)dealloc {
    pthread_mutex_destroy(&_lock);
    pthread_cond_destroy(&_condition);
}



@end
