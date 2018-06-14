//
//  ListViewController.m
//  YogaKitDemo
//
//  Created by 叮咚钱包富银 on 2018/6/4.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "ListViewController.h"
#import "ListCell.h"
#import "ListModel.h"
#import <YogaKit/UIView+Yoga.h>
static NSString *kCellIdentifier = @"yg_kCellIdentifier";

@interface ListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,readwrite,strong) UITableView *tableView;
@property (nonatomic,copy) NSArray *dataList;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self loadData];
}

- (void)loadData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:NULL];
    NSArray *arr = dic[@"feed"];
    NSMutableArray *tempArrM = @[].mutableCopy;
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ListModel *model = [[ListModel alloc] initWithDictionary:obj];
        [tempArrM addObject:model];
    }];
    
    self.dataList = tempArrM;
    
    
}

#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListModel *model = self.dataList[indexPath.row];
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    [cell prepareForReuse];
    [cell configureData:model];
    return cell.contentView.yoga.intrinsicSize.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier
                                                            forIndexPath:indexPath];
    ListModel *model = self.dataList[indexPath.row];
    [cell configureData:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - getter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView= [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        [_tableView registerClass:[ListCell class]
           forCellReuseIdentifier:kCellIdentifier];
        
        _tableView.showsVerticalScrollIndicator =NO;
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}


@end
