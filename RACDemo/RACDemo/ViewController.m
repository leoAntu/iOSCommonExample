//
//  ViewController.m
//  RACDemo
//
//  Created by 叮咚钱包富银 on 2018/6/13.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "ViewController.h"
#import "RACSignal.h"
#import "RACSubjectController.h"
#import "RACSequenceController.h"
#import "MulticastConnectionController.h"
#import "RACCommandController.h"
#import "CommonController.h"
#import "RACBindViewController.h"
#import "RACSkipController.h"
#import "RACMapViewController.h"
#import "CombineController.h"
#import "RequestController.h"
#import "LoginViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)signalAction:(id)sender {
    RACSignalDemo *vc = [[RACSignalDemo alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)subjectAction:(id)sender {
    RACSubjectController *vc = [[RACSubjectController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)sequenceAction:(id)sender {
    RACSequenceController *vc = [[RACSequenceController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)multicastConnection:(id)sender {
    MulticastConnectionController *vc = [[MulticastConnectionController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)command:(id)sender {
    RACCommandController *vc = [[RACCommandController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)commenAction:(id)sender {
    CommonController *vc = [[CommonController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)bindAction:(id)sender {
    RACBindViewController *vc = [[RACBindViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)skipAction:(id)sender {
    RACSkipController *vc = [[RACSkipController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)mapAction:(id)sender {
    RACMapViewController *vc = [[RACMapViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)combinAction:(id)sender {
    CombineController *vc = [[CombineController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)requestAction:(id)sender {
    RequestController *vc = [[RequestController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)loginAction:(id)sender {
    LoginViewController *vc = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
