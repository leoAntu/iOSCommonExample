//
//  ViewController.m
//  AsyncDisplayTableViewDemo
//
//  Created by 叮咚钱包富银 on 2018/6/6.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "ViewController.h"
#import "asyncDisplayController.h"
#import "RefreshVieController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)clickAction:(id)sender {
    asyncDisplayController *vc = [[asyncDisplayController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)refreshAction:(id)sender {
    RefreshVieController *vc = [[RefreshVieController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
