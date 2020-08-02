//
//  ViewController7.m
//  LockMore1
//
//  Created by xiekunpeng on 2020/7/29.
//  Copyright © 2020 xiekunpeng. All rights reserved.
//

#import "ViewController7.h"

@interface ViewController7 ()
@property (nonatomic, strong) NSRecursiveLock *lock;

@end

@implementation ViewController7

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lock = [[NSRecursiveLock alloc] init];
}

 /*******************************递归锁*************************************/
 - (void)recuresiveAction {
     static int count = 10;
     [self.lock lock];
     NSLog(@"count: %d", count);

     if (count > 0) {
         count --;
         [self recuresiveAction];
     }
     [self.lock unlock];
 }
 /*******************************递归锁*************************************/


@end
