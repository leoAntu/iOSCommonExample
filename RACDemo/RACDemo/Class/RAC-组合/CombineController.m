//
//  CombineController.m
//  RACDemo
//
//  Created by 叮咚钱包富银 on 2018/6/13.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "CombineController.h"
#import <ReactiveObjC/ReactiveObjC.h>
@interface CombineController ()
@property (weak, nonatomic) IBOutlet UITextField *accountInput;
@property (weak, nonatomic) IBOutlet UITextField *pswInput;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation CombineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self combineLatest];
    
//    [self zipWith];
    
//    [self merge];
    
//    [self then];
    
    [self concat];
}

//把多个信号聚合成你想要的信号,使用场景----：比如-当多个输入框都有值的时候按钮才可点击。
- (void)combineLatest {
    //reduce里的参数一定要和combineLatest数组里的一一对应。
    RACSignal *signal = [RACSignal combineLatest:@[self.accountInput.rac_textSignal,self.pswInput.rac_textSignal] reduce:^id (NSString *account,NSString *psw){
//        NSLog(@"%@ %@",account,psw);
        return @(account.length && psw.length);
    }];
    
    
    RAC(self.loginBtn, enabled) = signal;
    
    //下面代码同理
//    @weakify(self)
//    [signal subscribeNext:^(id  _Nullable x) {
//        @strongify(self)
//        NSLog(@"%@",x);
//        self.loginBtn.enabled = [x boolValue];
//    }];
}

- (void)zipWith {
    //zipWith:把两个信号压缩成一个信号，只有当两个信号同时发出信号内容时，并且把两个信号的内容合并成一个元祖，才会触发压缩流的next事件。
    RACSubject *subject1 = [RACSubject subject];
    RACSubject *subject2 = [RACSubject subject];
    
    RACSignal *signal = [subject1 zipWith:subject2];
    [signal subscribeNext:^(id  _Nullable x) {
        RACTupleUnpack(NSString *str1,NSString *str2) = (RACTuple *)x;
        NSLog(@"%@ %@",str1,str2);
    }];
    
    // 发送信号 交互顺序，元组内元素的顺序不会变，跟发送的顺序无关，而是跟压缩的顺序有关[signalA zipWith:signalB]---先是A后是B
    [subject2 sendNext:@"456"];
    [subject1 sendNext:@"123"];

}

// 任何一个信号请求完成都会被订阅到
// merge:多个信号合并成一个信号，任何一个信号有新值就会调用
- (void)merge {
    RACSubject *subject1 = [RACSubject subject];
    RACSubject *subject2 = [RACSubject subject];
    
    RACSignal *signal = [subject1 merge:subject2];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    // 发送信号---交换位置则数据结果顺序也会交换
    [subject1 sendNext:@"123"];
    [subject2 sendNext: @"456"];

}

// then --- 使用需求：有两部分数据：想让上部分先进行网络请求但是过滤掉数据，然后进行下部分的，拿到下部分数据
- (void)then {
    
    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"----发送上部分请求---");
        [subscriber sendNext:@"上部分数据"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"----发送下部分请求---");
        [subscriber sendNext:@"下部分数据"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    //创建组合数据
    RACSignal *thenSignal = [signal1 then:^RACSignal * _Nonnull{
        return signal2;
    }];
    
    [thenSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x); //只接受到signa2的信号
    }];
}

// concat----- 使用需求：有两部分数据：想让上部分先执行，完了之后再让下部分执行（都可获取值）
- (void)concat {
    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"----发送上部分请求---");
        [subscriber sendNext:@"上部分数据"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"----发送下部分请求---");
        [subscriber sendNext:@"下部分数据"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *concatSignal = [signal1 concat:signal2];
    
    [concatSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
}



@end
