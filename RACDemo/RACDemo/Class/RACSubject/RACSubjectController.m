//
//  RACSubjectController.m
//  RACDemo
//
//  Created by 叮咚钱包富银 on 2018/6/13.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "RACSubjectController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "SubjectDemo2ViewController.h"
@interface RACSubjectController ()

@end

@implementation RACSubjectController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)pushAction:(id)sender {
    SubjectDemo2ViewController *vc = [SubjectDemo2ViewController new];
    
    //1.创建信号，RACSubject是signal的subclass
    vc.subject = [RACSubject subject];
    // 2.订阅信号
    [vc.subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"接到消息-----%@",x);
    }];
        
    [self.navigationController pushViewController:vc animated:YES];
}


/**
 *  总结：
 我们完全可以用RACSubject代替代理/通知，确实方便许多
 这里我们点击TwoViewController的pop的时候 将字符串"ws"传给了ViewController的button的title。
 步骤：
 // 1.创建信号
 RACSubject *subject = [RACSubject subject];
 
 // 2.订阅信号
 [subject subscribeNext:^(id x) {
 // block:当有数据发出的时候就会调用
 // block:处理数据
 NSLog(@"%@",x);
 }];
 
 // 3.发送信号
 [subject sendNext:value];
 **注意：~~**
 RACSubject和RACReplaySubject的区别
 RACSubject必须要先订阅信号之后才能发送信号， 而RACReplaySubject可以先发送信号后订阅.
 RACSubject 代码中体现为：先走TwoViewController的sendNext，后走ViewController的subscribeNext订阅
 RACReplaySubject 代码中体现为：先走ViewController的subscribeNext订阅，后走TwoViewController的sendNext
 可按实际情况各取所需。
 
 */



@end
