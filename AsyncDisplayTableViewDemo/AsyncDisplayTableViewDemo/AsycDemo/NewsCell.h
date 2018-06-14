//
//  NewsCell.h
//  AsyncDisplayTableViewDemo
//
//  Created by 叮咚钱包富银 on 2018/6/8.
//  Copyright © 2018年 leo. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "ListModel.h"

@interface NewsCell : ASCellNode
- (void)displayWithModel:(ListModel *)model;
@end
