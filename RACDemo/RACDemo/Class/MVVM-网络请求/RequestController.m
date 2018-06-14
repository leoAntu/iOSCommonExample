//
//  RequestController.m
//  RACDemo
//
//  Created by 叮咚钱包富银 on 2018/6/13.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "RequestController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "RequestViewModel.h"
@interface RequestController ()
@property (nonatomic, strong) RequestViewModel *viewModel;
@end

@implementation RequestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //方式1， 先发送信号，在订阅
//    [[self.viewModel.requestCommand execute:nil] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"`````````````````");
//        NSLog(@"%@",x);
//    }];
//
    //方式2.先订阅，在发送信号
    [self.viewModel.requestCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"`````````````````");
        NSLog(@"%@",x);
    }];
    
    [self.viewModel.requestCommand execute:nil];
    
}

- (RequestViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[RequestViewModel alloc] init];
    }
    
    return _viewModel;
}

@end
