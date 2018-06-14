//
//  AnimatedView.m
//  YogaKitDemo
//
//  Created by 叮咚钱包富银 on 2018/6/4.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "AnimatedView.h"
#import <YogaKit/UIView+Yoga.h>

@interface AnimatedView ()
@property (nonatomic ,strong) UIView *redView;

@end
@implementation AnimatedView

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
    [self configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.justifyContent = YGJustifyCenter;
        layout.alignItems = YGAlignCenter;
    }];
    
    [self.redView configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.width = layout.height = YGPointValue(100);
    }];
    
    [self addSubview:self.redView];
    [self.yoga applyLayoutPreservingOrigin:YES];
    
    
    //执行动画
    [UIView animateWithDuration:1 animations:^{
        [self.redView configureLayoutWithBlock:^(YGLayout * layout) {
            layout.width = layout.height = YGPointValue(10);
        }];
        
        [self.yoga applyLayoutPreservingOrigin:YES];
        //可以不需要调用
//        [self layoutIfNeeded];
    }];
}

@end
