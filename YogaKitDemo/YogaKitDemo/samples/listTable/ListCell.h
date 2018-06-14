//
//  ListCell.h
//  YogaKitDemo
//
//  Created by 叮咚钱包富银 on 2018/6/4.
//  Copyright © 2018年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListModel.h"
@interface ListCell : UITableViewCell
- (void)configureData:(ListModel *)entity;
@end

@interface UITableView (TemplateCell)
- (CGFloat)heightForData:(ListModel *)model cellIdentifier:(NSString *)identifier;
@end
