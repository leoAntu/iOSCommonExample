//
//  LoginViewController.m
//  RACDemo
//
//  Created by 叮咚钱包富银 on 2018/6/13.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "LoginViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "LoginViewModal.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountInput;
@property (weak, nonatomic) IBOutlet UITextField *pwdInput;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (nonatomic, strong) LoginViewModal *viewModal;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self  bindVM];
    
    [self addLoginAction];
}

- (void)bindVM {
    RAC(self.viewModal,accout) = self.accountInput.rac_textSignal;
    RAC(self.viewModal,pwd) = self.accountInput.rac_textSignal;

    RAC(self.loginBtn,enabled) = self.viewModal.loginEnableSignal;
}

- (void)addLoginAction {
    
    @weakify(self)
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        NSLog(@"点击按钮");
        [self.viewModal.loginCommand execute:@"12313"];
    }];
}

- (LoginViewModal *)viewModal {
    if (!_viewModal) {
        _viewModal = [[LoginViewModal alloc] init];
    }
    
    return _viewModal;
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
