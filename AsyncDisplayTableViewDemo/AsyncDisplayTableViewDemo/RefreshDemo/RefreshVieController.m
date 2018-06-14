//
//  RefreshVieController.m
//  AsyncDisplayTableViewDemo
//
//  Created by 叮咚钱包富银 on 2018/6/8.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "RefreshVieController.h"

#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "displayTableCell.h"
#import "MJRefresh.h"


@interface RefreshVieController () <ASTableDelegate,ASTableDataSource>

@property (nonatomic, strong) ASTableNode *tableView;
@property (nonatomic, assign) NSInteger count;

@end

@implementation RefreshVieController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.count = 0;
    [self.view addSubnode:self.tableView];
    [self addMJ];
    self.tableView.frame = self.view.bounds;
}

- (void)addMJ {
    
    __weak __typeof(self) weakSelf = self;
    // 1
    self.tableView.view.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        [weakSelf.tableView.view.mj_header endRefreshing];
        weakSelf.count = 10;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    }];
    
    self.tableView.view.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf.tableView.view.mj_footer endRefreshing];
        weakSelf.count += 10;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    }];
}

- (NSInteger)numberOfSectionsInTableNode:(ASTableNode *)tableNode {
    return 1;
}

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section {
    return self.count;
}

- (ASCellNode *)tableNode:(ASTableNode *)tableNode nodeForRowAtIndexPath:(NSIndexPath *)indexPath {
    displayTableCell *cell = [[displayTableCell alloc] init];
    return cell;
}

- (void)tableNode:(ASTableNode *)tableNode didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableNode deselectRowAtIndexPath:indexPath animated:YES];
}

- (ASTableNode *)tableView {
    if (!_tableView) {
        _tableView = [[ASTableNode alloc] initWithStyle:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.view.tableFooterView = [UIView new];
        //减缓卡顿 即提前计算四个屏幕的内容时，掉帧就很不明显了，典型的空间换时间。
        _tableView.leadingScreensForBatching = 4;
    }
    return _tableView;
}

@end
