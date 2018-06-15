//
//  TableViewController.m
//  PopDemo
//
//  Created by 叮咚钱包富银 on 2018/6/15.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "TableViewController.h"
#import "BasicViewController.h"
#import "SpringViewController.h"
#import "DecayViewController.h"
#import "PropertyViewController.h"
#import "OtherViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        BasicViewController *vc =[BasicViewController new];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.row == 1) {
        SpringViewController *vc =[SpringViewController new];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if (indexPath.row == 2) {
        DecayViewController *vc =[DecayViewController new];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.row == 3) {
        PropertyViewController *vc =[PropertyViewController new];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if (indexPath.row == 4) {
        OtherViewController *vc =[OtherViewController new];
        vc.type = OtherViewControllerTypePop;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if (indexPath.row == 5) {
        OtherViewController *vc =[OtherViewController new];
        vc.type = OtherViewControllerTypeFly;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if (indexPath.row == 6) {
        OtherViewController *vc =[OtherViewController new];
        vc.type = OtherViewControllerTypeTransform;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
}

@end
