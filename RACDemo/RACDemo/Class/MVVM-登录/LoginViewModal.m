
//
//  LoginViewModal.m
//  RACDemo
//
//  Created by 叮咚钱包富银 on 2018/6/13.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "LoginViewModal.h"

@implementation LoginViewModal

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    
    _loginEnableSignal = [RACSignal combineLatest:@[RACObserve(self, accout), RACObserve(self, pwd)] reduce:^id (NSString *account,NSString *pwd){
        return @(account.length && pwd.length);
    }];
    
    _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
       
        NSLog(@"接收到登录的信息-------%@",input);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
           
            NSLog(@"处理登录信息-------");
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //发送服务器返回的数据
                [subscriber sendNext:@"接受成功的信息"];
                [subscriber sendCompleted];
                
            });

            
            return nil;
        }];
    }];
    
    //订阅信号
    [_loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"接受到订阅信息---- %@",x);
    }];
    
    //处理登录执行的过程
    [[_loginCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue] == YES) {
            NSLog(@"--正在执行");
        } else {
            NSLog(@"执行完成");
        }
    }];
    
}

@end
