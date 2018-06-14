//
//  RACSignal.m
//  RACDemo
//
//  Created by 叮咚钱包富银 on 2018/6/13.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "RACSignal.h"
#import <ReactiveObjC/ReactiveObjC.h>
@interface RACSignalDemo ()

@end

@implementation RACSignalDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //1.创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送信号");
        //3.发送信号
        [subscriber sendNext:@"hello"];
        
        //4、取消信号，如果信号想要被取消，就必须返回一个RACDisposable
        // 信号什么时候被取消：1.自动取消，当一个信号的订阅者被销毁的时候机会自动取消订阅，2.手动取消，
        //block什么时候调用：一旦一个信号被取消订阅就会调用
        //block作用：当信号被取消时用于清空一些资源
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"取消订阅");
        }];
    }];
    
    //2.订阅信号
    //subscribeNext
    // 把nextBlock保存到订阅者里面
    // 只要订阅信号就会返回一个取消订阅信号的类
    RACDisposable *disposable = [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收到信号----- %@",x);
    }];
    
    //取消订阅
    [disposable dispose];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
