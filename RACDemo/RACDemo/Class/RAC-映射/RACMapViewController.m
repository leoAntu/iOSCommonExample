
//
//  RACMapViewController.m
//  RACDemo
//
//  Created by 叮咚钱包富银 on 2018/6/13.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "RACMapViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <ReactiveObjC/RACReturnSignal.h>
@interface RACMapViewController ()

@end

@implementation RACMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self map];
    
//    [self flatMap];
    
    [self flattenMap2];
    
}

//RAC的映射在实际开发中有什么用呢？比如我们想要拦截服务器返回的数据，给数据拼接特定的东西或想对数据进行操作从而更改返回值，类似于这样的情况下，我们便可以考虑用RAC的映射，实例代码如下
- (void)map {
    RACSubject *subject = [RACSubject subject];
    RACSignal *signal =  [subject map:^id _Nullable(id  _Nullable value) {
        // 返回的类型就是你需要映射的值
        return [NSString stringWithFormat:@"map method : %@",value];
    }];
    
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    //发送信号
    [subject sendNext:@"hello"];
}

- (void)flatMap {
    RACSubject *subject = [RACSubject subject];
    RACSignal *signal = [subject flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        // block：只要源信号发送内容就会调用
        // value: 就是源信号发送的内容
        // 返回信号用来包装成修改内容的值
        value = [NSString stringWithFormat:@"hello word: %@",value];
        return [RACReturnSignal return:value];
    }];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject sendNext:@"123123"];
}

- (void)flattenMap2 {
    // flattenMap 主要用于信号中的信号
    RACSubject *subject1 = [RACSubject subject];
    RACSubject *subject2 = [RACSubject subject];
    
    [[subject1 flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        //value 就是RACSignal
        return value;
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject1 sendNext:subject2];
    [subject2 sendNext:@"123"];
}

@end
