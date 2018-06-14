
//
//  RACSequenceController.m
//  RACDemo
//
//  Created by 叮咚钱包富银 on 2018/6/13.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "RACSequenceController.h"
#import <ReactiveObjC/ReactiveObjC.h>
@interface RACSequenceController ()
@property (nonatomic, strong) NSArray *flagsArr;
@end

@implementation RACSequenceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"flags" ofType:@"plist"];
    NSArray * arr = [NSArray arrayWithContentsOfFile:path];
    
    // 使用场景---： 可以快速高效的遍历数组和字典。
    
    [arr.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
