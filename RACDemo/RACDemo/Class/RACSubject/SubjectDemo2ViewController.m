//
//  SubjectDemo2ViewController.m
//  RACDemo
//
//  Created by 叮咚钱包富银 on 2018/6/13.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "SubjectDemo2ViewController.h"

@interface SubjectDemo2ViewController ()

@end

@implementation SubjectDemo2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)sendAction:(id)sender {
    NSLog(@"发送消息");
    [self.subject sendNext:@"haha"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
