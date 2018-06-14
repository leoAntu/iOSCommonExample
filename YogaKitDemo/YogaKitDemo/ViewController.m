//
//  ViewController.m
//  YogaKitDemo
//
//  Created by 叮咚钱包富银 on 2018/6/4.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "ViewController.h"
#import "CenterLayout.h"
#import "NestLayout.h"
#import "EqualWidth.h"
#import "spaceBetween.h"
#import "ScrollView.h"
#import "AnimatedView.h"
#import "ListViewController.h"

static NSString *const tableViewIdentifier = @"tableViewIdentifier";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,readwrite,strong) UITableView *tableView;
@property (nonatomic,readwrite,copy  ) NSArray     *layoutSectionList;
@property (nonatomic,readwrite,copy  ) NSArray     *layoutNormalList;
@property (nonatomic,readwrite,copy  ) NSArray     *layoutTableList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableView];

}

#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.layoutSectionList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *list = self.layoutSectionList[section];
    return list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewIdentifier
                                                            forIndexPath:indexPath];
    NSArray *list = self.layoutSectionList[indexPath.section];
    cell.textLabel.text = list[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section ==  1) {
        ListViewController *tableVC = [[ListViewController alloc] init];
        [self.navigationController pushViewController:tableVC animated:YES];
        return;
    }
    
    UIViewController *vc = [UIViewController new];
    
    if (indexPath.row == 0) {
        CenterLayout *view = [[CenterLayout alloc] init];
        [vc.view addSubview:view];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
  
    if (indexPath.row == 1) {
        NestLayout *view = [[NestLayout alloc] init];
        [vc.view addSubview:view];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if (indexPath.row == 2) {
        EqualWidth *view = [[EqualWidth alloc] init];
        [vc.view addSubview:view];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if (indexPath.row == 3) {
        spaceBetween *view = [[spaceBetween alloc] init];
        [vc.view addSubview:view];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if (indexPath.row == 4) {
        ScrollView *view = [[ScrollView alloc] init];
        [vc.view addSubview:view];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if (indexPath.row == 5) {
        AnimatedView *view = [[AnimatedView alloc] init];
        [vc.view addSubview:view];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
}

#pragma mark - getter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView= [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:tableViewIdentifier];
        
        _tableView.showsVerticalScrollIndicator =NO;
        
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSArray *)layoutSectionList{
    if (!_layoutSectionList) {
        _layoutSectionList = @[self.layoutNormalList,self.layoutTableList];
    }
    return _layoutSectionList;
}

- (NSArray *)layoutNormalList{
    if (!_layoutNormalList) {
        _layoutNormalList = @[@"居中布局",@"嵌套布局",@"等宽度等间距布局",@"九宫格布局",@"ScrollView自动计算contentSize",@"缩放动画"];
    }
    return _layoutNormalList;
}

- (NSArray *)layoutTableList{
    if (!_layoutTableList) {
        _layoutTableList = @[@"cell动态布局计算高度"];
    }
    return _layoutTableList;
}

@end
