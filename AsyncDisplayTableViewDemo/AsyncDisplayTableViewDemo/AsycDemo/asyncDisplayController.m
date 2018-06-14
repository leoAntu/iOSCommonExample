//
//  asyncDisplayController.m
//  AsyncDisplayTableViewDemo
//
//  Created by 叮咚钱包富银 on 2018/6/6.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "asyncDisplayController.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "displayTableCell.h"
#import "ListModel.h"
#import "NewsCell.h"
@interface asyncDisplayController () <ASTableDelegate,ASTableDataSource>

@property (nonatomic, strong) ASTableNode *tableView;
@property (nonatomic, strong) NSMutableArray *indexPathesToBeReloaded;
@property (nonatomic,copy) NSArray *dataList;

@end

@implementation asyncDisplayController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.indexPathesToBeReloaded = [NSMutableArray array];
    [self loadData];
    [self.view addSubnode:self.tableView];
    self.tableView.frame = self.view.bounds;
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

- (NSInteger)numberOfSectionsInTableNode:(ASTableNode *)tableNode {
    return 1;
}

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (ASCellNode *)tableNode:(ASTableNode *)tableNode nodeForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 || indexPath.row == 1) {
        NewsCell *cell = [[NewsCell alloc] init];
        [cell displayWithModel:self.dataList[indexPath.row]];
        return cell;
    }
    
    displayTableCell *cell = [[displayTableCell alloc] init];
    //reload 单个cell时的闪烁,placeholder到渲染好的内容切换引起闪烁
    //会让cell从异步状态衰退回同步状态
//    cell.neverShowPlaceholders = true;
    
//    一般设置tableNode.leadingScreensForBatching = 4即提前计算四个屏幕的内容时，掉帧就很不明显了，典型的空间换时间。但仍不完美，仍然会掉帧，而我们期望的是一帧不掉，如丝般顺滑。这不难，基于上面不闪的方案，刷点小聪明就能解决。
//    检查当前的indexPath是否被标记，如果是，则先设置cell.neverShowPlaceholders = true，等待reload完成（一帧是1/60秒，这里等待0.5秒，足够渲染了），将cell.neverShowPlaceholders = false。这样reload时既不会闪烁，也不会影响滑动时的异步绘制，因此一帧不掉。
    if ([self.indexPathesToBeReloaded containsObject:indexPath]) {
        displayTableCell *oldCell = [tableNode nodeForRowAtIndexPath:indexPath];
        cell.neverShowPlaceholders = true;
        oldCell.neverShowPlaceholders = true;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            cell.neverShowPlaceholders = false;
            [self.indexPathesToBeReloaded removeObject:indexPath];
        });
    }
    return cell;
}

- (void)tableNode:(ASTableNode *)tableNode didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableNode deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0 || indexPath.row == 1) {
        return;
    }
    
    [self.indexPathesToBeReloaded addObject:indexPath];
    
    [tableNode reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    NSLog(@"刷新当前cell");
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
