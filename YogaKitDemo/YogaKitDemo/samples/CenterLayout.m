
//
//  CenterLayout.m
//  YogaKitDemo
//
//  Created by 叮咚钱包富银 on 2018/6/4.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "CenterLayout.h"
#import <YogaKit/UIView+Yoga.h>
@interface CenterLayout ()
@property (nonatomic ,strong) UIView *redView;

@end

@implementation CenterLayout

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height)];
    if (self) {
        self.redView = [[UIView alloc] init];
        self.redView.backgroundColor = [UIColor redColor];
        self.backgroundColor = [UIColor grayColor];
    
        [self updateLayout];
    }
    return self;
}

- (void)updateLayout {
    //设置父布局
    [self configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionRow; //主轴为水平方向
        layout.justifyContent = YGJustifyCenter;
        layout.alignItems = YGAlignCenter;
    }];
    
    //设置子布局
    [self.redView configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.width = layout.height = YGPointValue(100);
    }];
    
    //添加到父类
    [self addSubview:self.redView];
    
    //使yoga布局生效,可以只要父类执行此语句就行，子类不需要执行
    [self.redView.yoga applyLayoutPreservingOrigin:YES];
    [self.yoga applyLayoutPreservingOrigin:YES];
}


@end
