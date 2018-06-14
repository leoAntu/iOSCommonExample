//
//  MulticastConnectionController.m
//  RACDemo
//
//  Created by 叮咚钱包富银 on 2018/6/13.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "MulticastConnectionController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface MulticastConnectionController ()

@end

@implementation MulticastConnectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self method1];
//    [self method2];
}

//当有多个订阅者，但是我们只想发送一个信号的时候怎么办？这时我们就可以用RACMulticastConnection，来实现。代码示例如下

//普通写法
- (void)method1 {
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
       
        NSLog(@"发送信号");
        [subscriber sendNext:@"hello"];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"1--- %@",x);
    }];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"2--- %@",x);
    }];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"3--- %@",x);
    }];
    
//    2018-06-13 13:26:05.212316+0800 RACDemo[2707:27662] 发送信号
//    2018-06-13 13:26:05.212513+0800 RACDemo[2707:27662] 1--- hello
//    2018-06-13 13:26:05.212754+0800 RACDemo[2707:27662] 发送信号
//    2018-06-13 13:26:05.213052+0800 RACDemo[2707:27662] 2--- hello
//    2018-06-13 13:26:05.213255+0800 RACDemo[2707:27662] 发送信号
//    2018-06-13 13:26:05.213393+0800 RACDemo[2707:27662] 3--- hello
}

- (void)method2 {
    // 比较好的做法。 使用RACMulticastConnection，无论有多少个订阅者，无论订阅多少次，我只发送一个。
    // 1.发送请求，用一个信号内包装，不管有多少个订阅者，只想发一次请求
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送信号");
        [subscriber sendNext:@"hello"];
        return nil;
    }];
    
    //2. 创建连接类
    RACMulticastConnection *connection = [signal publish];
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"1--- %@",x);
    }];
    
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"2--- %@",x);
    }];
    
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"3--- %@",x);
    }];
    
    //3. 连接。只有连接了才会把信号源变为热信号
    [connection connect];
    
//    2018-06-13 13:25:34.529176+0800 RACDemo[2653:26996] 发送信号
//    2018-06-13 13:25:34.529379+0800 RACDemo[2653:26996] 1--- hello
//    2018-06-13 13:25:34.529535+0800 RACDemo[2653:26996] 2--- hello
//    2018-06-13 13:25:34.529673+0800 RACDemo[2653:26996] 3--- hello

}



@end
