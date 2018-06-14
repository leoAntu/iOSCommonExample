
//
//  RACSkipController.m
//  RACDemo
//
//  Created by 叮咚钱包富银 on 2018/6/13.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "RACSkipController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface RACSkipController ()
@property (weak, nonatomic) IBOutlet UITextField *textInput;

@end

@implementation RACSkipController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self skip];
//    [self distinctUntilChanged];
    
//    [self take];
    
//    [self takeLast];
    
//    [self takeUntil];
    
//    [self ignore];
    
//    [self ignoreValues];
    
    [self fliter];
}

- (void)skip {
    
    //忽略前面两个信号，只获取最后一个信号
    // 实际用处： 在实际开发中比如 后台返回的数据前面几个没用，我们想跳跃过去，便可以用skip
    RACSubject *subject = [RACSubject subject];
    [[subject skip:2] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject sendNext: @1];
    [subject sendNext: @3];
    [subject sendNext: @14];
}


//distinctUntilChanged:-- 如果当前的值跟上一次的值一样，就不会被订阅到
- (void)distinctUntilChanged {
    RACSubject *subject = [RACSubject subject];
    [[subject distinctUntilChanged] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);

    }];
    
    [subject sendNext: @1];
    [subject sendNext: @3];
    [subject sendNext: @3]; //不会被执行
    [subject sendNext: @4];

}

// take:可以屏蔽一些值,去前面几个值---这里take为2 则只拿到前两个值
- (void)take {
    RACSubject *subject = [RACSubject subject];
    [[subject take:2] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
        
    }];
    
    [subject sendNext: @1];
    [subject sendNext: @3];
    //后面两个值拿不到
    [subject sendNext: @5];
    [subject sendNext: @4];
}

//takeLast:和take的用法一样，不过他取的是最后的几个值，如下，则取的是最后两个值
//注意点:takeLast 一定要调用sendCompleted，告诉他发送完成了，这样才能取到最后的几个值
- (void)takeLast {
    RACSubject *subject = [RACSubject subject];
    [[subject takeLast:2] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject sendNext: @1];
    [subject sendNext: @3];
    //只拿后面两个值
    [subject sendNext: @5];
    [subject sendNext: @4];
    //必须执行，才能知道完成
    [subject sendCompleted];
}

// takeUntil:---给takeUntil传的是哪个信号，那么当这个信号发送信号或sendCompleted，就不能再接受源信号的内容了。
- (void)takeUntil {
    RACSubject *subject = [RACSubject subject];
    RACSubject *subject2 = [RACSubject subject];
    
    //直到接到到subject2的信号就不再接收了
    [[subject takeUntil:subject2] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject sendNext:@1];
    [subject sendNext:@2];
    [subject2 sendNext:@3];
    [subject sendNext:@2];
    
//    2018-06-13 15:00:07.947459+0800 RACDemo[13496:141023] 1
//    2018-06-13 15:00:07.947932+0800 RACDemo[13496:141023] 2
}

// ignore: 忽略掉一些值
//ignore:忽略一些值
//ignoreValues:表示忽略所有的值
- (void)ignore {
    RACSubject *subject = [RACSubject subject];
    //表示忽略2
    [[subject ignore:@2] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    [subject sendNext:@1];
    [subject sendNext:@2];
}

- (void)ignoreValues {
    RACSubject *subject = [RACSubject subject];
    [[subject ignoreValues] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject sendNext:@1];
    [subject sendNext:@2];
}

// 一般和文本框一起用，添加过滤条件
- (void)fliter {
    // 只有当文本框的内容长度大于5，才获取文本框里的内容
    [[self.textInput.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        return [value length] > 5;
        // 返回值 就是过滤条件。只有满足这个条件才能获取到内容
    }] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@",x);
    }];
}

@end
