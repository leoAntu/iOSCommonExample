//
//  EqualWidth.m
//  YogaKitDemo
//
//  Created by 叮咚钱包富银 on 2018/6/4.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "EqualWidth.h"
#import <YogaKit/UIView+Yoga.h>

@interface EqualWidth ()
@property (nonatomic ,strong) UIView *redView;
@property (nonatomic ,strong) UIView *yellowView;

@end

@implementation EqualWidth
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
//        layout.justifyContent = YGJustifyCenter;
        layout.flexDirection = YGFlexDirectionRow;
        layout.paddingHorizontal = YGPointValue(10);
    }];
    
    YGLayoutConfigurationBlock block = ^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.height = YGPointValue(100);
        layout.marginHorizontal = YGPointValue(10);
        layout.flexGrow = 1;
    };
    
    [self.redView configureLayoutWithBlock:block];
    [self.yellowView configureLayoutWithBlock:block];
    
    [self addSubview:self.redView];
    [self addSubview:self.yellowView];
    
    [self.yoga applyLayoutPreservingOrigin:YES];
}

@end
