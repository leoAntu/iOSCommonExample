
//
//  ScrollView.m
//  YogaKitDemo
//
//  Created by 叮咚钱包富银 on 2018/6/4.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "ScrollView.h"
#import <YogaKit/UIView+Yoga.h>

@implementation ScrollView

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height)];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self updateLayout];
    }
    return self;
}

- (void)updateLayout {
    
    [self configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.justifyContent = YGJustifyCenter;
    }];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor grayColor];
    [scrollView configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.height = YGPointValue(500);
    }];
    
    [self addSubview:scrollView];
    
    UIView *contentView = [UIView new];
    contentView.backgroundColor = [UIColor redColor];
//    contentView.clipsToBounds = YES;
    [contentView configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 1;
        layout.alignItems = YGAlignCenter;
    }];
    
    
    for ( int i = 1 ; i <= 20 ; ++i )
    {
        UIView *item = [UIView new];
        item.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                          saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                          brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                               alpha:1];
        [item  configureLayoutWithBlock:^(YGLayout *layout) {
            layout.isEnabled = YES;
            layout.height = YGPointValue(20*i);
            layout.width = YGPointValue(200);
            layout.marginVertical = YGPointValue(10);
            
        }];
        
        [contentView addSubview:item];
    }
    
    [scrollView addSubview:contentView];
    [self.yoga applyLayoutPreservingOrigin:YES];
    //contentsize必须在执行布局之后执行，否则设置失效
    scrollView.contentSize = contentView.bounds.size;

}

@end
