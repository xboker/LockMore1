
//
//  ViewController6.m
//  LockMore1
//
//  Created by xiekunpeng on 2020/7/28.
//  Copyright © 2020年 xiekunpeng. All rights reserved.
//

#import "ViewController6.h"

@interface ViewController6 ()
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSCondition *condition;

@end

@implementation ViewController6

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     首先设定以下使用场景, 两条线程 A和B, A线程中执行删除数组元素, B 线程中执行添加数组元素;
     由于不知道哪个线程会先执行, 所以需要加锁实现, 只有在添加后才能执行删除操作;为互斥锁添加条件可以实现;
     */
    
    self.condition = [[NSCondition alloc] init];
    NSThread *deThread = [[NSThread alloc] initWithTarget:self selector:@selector(deleteObj) object:nil];
    [deThread start];
    ///sleep一秒. 确保删除元素的线程先获得锁;
    sleep(1);
    NSThread *adThread = [[NSThread alloc] initWithTarget:self selector:@selector(addObj) object:nil];
    [adThread start];
    
}

- (void)deleteObj {
    [self.condition lock];
    NSLog(@"delete begin");
    ///添加判断, 如果没有数据则添加条件
    if (self.dataArr.count < 1) {
        /**
         添加条件, 如果数组为空, 则添加等待线程休眠, 将锁让出;  接受到信号时会再次加锁, 然后继续向下执行;
         */
        [self.condition wait];
    }
    
    [self.dataArr removeLastObject];
    NSLog(@"数组执行删除元素操作");
    [self.condition unlock];
}

- (void)addObj {
    [self.condition lock];
    NSLog(@"add begin");
    [self.dataArr addObject:@"HTI"];
    ///发送新号, 说明已经添加元素了;
    [self.condition signal];
//    ///通知所有符合条件的线程
//    [self.condition broadcast];
    NSLog(@"数组执行添加元素操作");
    [self.condition unlock];
}


- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return  _dataArr;
}
@end
