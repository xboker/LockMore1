//
//  ViewController.m
//  LockMore1
//
//  Created by xiekunpeng on 2020/7/26.
//  Copyright © 2020年 xiekunpeng. All rights reserved.
//

#import "ViewController.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController4.h"
#import "ViewController5.h"
#import "ViewController6.h"
#import "ViewController7.h"
#import "ViewController8.h"
#import "ViewController9.h"
#import "ViewController10.h"
#import "ViewController11.h"


@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    /*
     初始化的存取钱逻辑, 多线程, 由于没有加锁的原因, 最后的执行结果不可得知;

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
     */
}

- (void)saveMoney{
    NSInteger moeny = self.money;
    sleep(0.3);
    moeny  +=20;
    self.money = moeny;
    NSLog(@"存钱后, 最终钱数:%ld", (long)moeny);
}

- (void)drawMoney {
    NSInteger moeny = self.money;
    sleep(0.3);
    moeny  -=10;
    self.money = moeny;
    NSLog(@"取钱后, 最终钱数:%ld", (long)moeny);
}


/************************************************************************************************/
- (IBAction)case1:(id)sender {
    ViewController1 *c = [[ViewController1 alloc] init];
    [self.navigationController pushViewController:c animated:YES];
}

- (IBAction)case2:(id)sender {
    ViewController2 *c = [[ViewController2 alloc] init];
    [self.navigationController pushViewController:c animated:YES];
}

- (IBAction)case3:(id)sender {
    ViewController3 *c = [[ViewController3 alloc] init];
       [self.navigationController pushViewController:c animated:YES];
}

- (IBAction)case4:(id)sender {
    ViewController4 *c = [[ViewController4 alloc] init];
       [self.navigationController pushViewController:c animated:YES];
}

- (IBAction)case5:(id)sender {
    ViewController5 *c = [[ViewController5 alloc] init];
    [self.navigationController pushViewController:c animated:YES];
}

- (IBAction)case6:(id)sender {
    ViewController6 *c = [[ViewController6 alloc] init];
    [self.navigationController pushViewController:c animated:YES];
}

- (IBAction)case7:(id)sender {
    ViewController7 *c = [[ViewController7 alloc] init];
      [self.navigationController pushViewController:c animated:YES];
}

- (IBAction)case8:(id)sender {
    ViewController8 *c = [[ViewController8 alloc] init];
    [self.navigationController pushViewController:c animated:YES];
}

- (IBAction)cae9:(id)sender {
      ViewController9 *c = [[ViewController9 alloc] init];
        [self.navigationController pushViewController:c animated:YES];
    }

- (IBAction)case10:(id)sender {
      ViewController10 *c = [[ViewController10 alloc] init];
        [self.navigationController pushViewController:c animated:YES];
    }

- (IBAction)case11:(id)sender {
      ViewController11 *c = [[ViewController11 alloc] init];
        [self.navigationController pushViewController:c animated:YES];
    }
- (IBAction)case12:(id)sender {
}



@end
