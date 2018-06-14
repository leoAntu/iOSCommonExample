

//
//  NestLayout.m
//  YogaKitDemo
//
//  Created by 叮咚钱包富银 on 2018/6/4.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "NestLayout.h"
#import <YogaKit/UIView+Yoga.h>
@interface NestLayout ()
@property (nonatomic ,strong) UIView *redView;
@property (nonatomic ,strong) UIView *yellowView;

@end

@implementation NestLayout
- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height)];
    if (self) {
        self.redView = [[UIView alloc] init];
        self.redView.backgroundColor = [UIColor redColor];
        self.yellowView = [[UIView alloc] init];
        self.yellowView.backgroundColor = [UIColor yellowColor];
        self.backgroundColor = [UIColor grayColor];
        
        [self updateLayout];
    }
    return self;
}

- (void)updateLayout {
    
    [self configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.alignItems = YGAlignCenter;
        layout.justifyContent = YGJustifyCenter;
    }];
    
    [self.redView configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.height = layout.width = YGPointValue(100);
    }];
    
    [self addSubview:self.redView];
    
    
    [self.yellowView configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.margin = YGPointValue(10); //设置盒子边距
        layout.flexGrow = 1; //填满父类
    }];
    
    [self.redView addSubview:self.yellowView];
    
    
    [self.yoga applyLayoutPreservingOrigin:YES];

}

@end
