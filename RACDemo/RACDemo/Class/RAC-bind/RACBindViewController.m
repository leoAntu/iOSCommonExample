//
//  RACBindViewController.m
//  RACDemo
//
//  Created by 叮咚钱包富银 on 2018/6/13.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "RACBindViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <ReactiveObjC/RACReturnSignal.h>
@interface RACBindViewController ()

@end

@implementation RACBindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self test1];
}

//总结
//bind（绑定）的使用思想和Hook的一样---> 都是拦截API从而可以对数据进行操作，，而影响返回数据。
//发送信号的时候会来到34行的block。在这个block里我们可以对数据进行一些操作，那么40行随意修改信号传过来的值。
- (void)test1 {
    // 1.创建信号
    RACSubject *subject = [RACSubject subject];
    // 2.绑定信号
    RACSignal *signal = [subject bind:^RACSignalBindBlock _Nonnull{
//        typedef RACSignal * _Nullable (^RACSignalBindBlock)(ValueType _Nullable value, BOOL *stop);

        return ^RACSignal *(id value, BOOL *stop) {
            // 一般在这个block中做事 ，发数据的时候会来到这个block。
            // 只要源信号（subject）发送数据，就会调用block
            // block作用：处理源信号内容
            // value:源信号发送的内容，
            NSLog(@"接受到源信号的内容：%@", value);
            value = @3; // 如果在这里把value的值改了，那么订阅绑定信号的值即44行的x就变了
            return [RACReturnSignal return:value]; // 把返回的值包装成信号
        };
    }];
    
    //3.订阅信号
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收到绑定信号处理完的信号:%@",x);
    }];
    
    //4.发送信号
    [subject sendNext:@"123123"];
}

@end
