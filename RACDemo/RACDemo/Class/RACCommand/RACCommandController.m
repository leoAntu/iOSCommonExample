//
//  RACCommandController.m
//  RACDemo
//
//  Created by 叮咚钱包富银 on 2018/6/13.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "RACCommandController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface RACCommandController ()

@end

@implementation RACCommandController

//RACCommand:RAC中用于处理事件的类，可以把事件如何处理，事件中的数据如何传递，包装到这个类中，他可以很方便的监控事件的执行过程，比如看事件有没有执行完毕
//使用场景：监听按钮点击，网络请求
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self test1];
    
//    [self test2];
    
//    [self test3];
    
//    [self test4];
    
    [self test5];
}

- (void)test1 {
    // 普通做法
    // RACCommand: 处理事件
    // 不能返回空的信号
    // 1.创建命令
    RACCommand *commend = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@"%@",input);
        // 这里的返回值不允许为nil
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"hello"];
            return nil;
        }];
    }];
    
    // 如何拿到执行命令中产生的数据呢？
    // 订阅命令内部的信号
    // ** 方式一：执行命令返回信号
    RACSignal *signal = [commend execute:@"发送信号"];
    //订阅信号
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收到信息----%@",x);
    }];
    
}

- (void)test2 {
    // 一般做法
    // 1.创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@"%@",input);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"hello"];
            return nil;
        }];
    }];
    
    // 方式二：
    // 订阅信号
    // 注意：这里必须是先订阅才能发送命令
    [command.executionSignals subscribeNext:^(RACSignal * x) {
        [x subscribeNext:^(id  _Nullable x) {
            NSLog(@"%@",x);
        }];
    }];
    
    //2.执行命令
    [command execute:@"发送信号"];

}

- (void)test3 {
    // 高级做法
    // 1.创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@"%@",input);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"hello"];
            return nil;
        }];
    }];
    
    // 方式三
    // switchToLatest获取最新发送的信号，只能用于信号中信号。
    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    //2.执行命令
    [command execute:@"发送信号"];
}

- (void)test4 {
    // switchToLatest--用于信号中信号
    // 创建信号中信号
    
    RACSubject *subject1 = [RACSubject subject];
    RACSubject *subject2 = [RACSubject subject];
    
    [subject1.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];

    //这样会奔溃
//    [subject1 sendNext:@"hello"];
//    [subject2 sendNext:@"world"];
    
    //必须发送信号才行
    [subject1 sendNext:subject2];
    [subject2 sendNext:@"hello"];

}

// 监听事件有没有完成
- (void)test5 {
    // 1.创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@"%@",input);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"hello"];
            //发送完成
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
//    [command.executing subscribeNext:^(NSNumber * _Nullable x) {
//        if ([x boolValue] == YES) {
//            NSLog(@"当前正在执行%@",x);
//        } else {
//            NSLog(@"执行完成");
//        }
//    }];
    
    [[[command executing] skip:1] subscribeNext:^(NSNumber * _Nullable x) { //过滤掉第一步，初始化就会执行完成
        if ([x boolValue] == YES) {
            NSLog(@"当前正在执行%@",x);
        } else {
            NSLog(@"执行完成");
        }
    }];
    
    //2.执行命令
    [command execute:@"eqwe"];
}


@end
