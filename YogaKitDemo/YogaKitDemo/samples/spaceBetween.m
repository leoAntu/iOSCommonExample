//
//  spaceBetween.m
//  YogaKitDemo
//
//  Created by 叮咚钱包富银 on 2018/6/4.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "spaceBetween.h"
#import <YogaKit/UIView+Yoga.h>


@implementation spaceBetween

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height)];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        
        [self updateLayout];
    }
    return self;
}

- (void)updateLayout {
    [self configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionRow;
        layout.justifyContent = YGJustifySpaceBetween;
        layout.alignItems = YGAlignCenter;
        layout.flexWrap = YGWrapWrap;
        layout.paddingTop = YGPointValue(100);
    }];
    
    for (NSInteger i = 0 ; i < 20; i++) {
        UIView *sub = [UIView new];
        sub.backgroundColor = [UIColor colorWithRed:(arc4random() % 256 / 256.0)
                                              green:(arc4random() % 256 / 256.0)
                                               blue:(arc4random() % 256 / 256.0)
                                              alpha:1];
        [sub configureLayoutWithBlock:^(YGLayout * layout) {
            layout.isEnabled = YES;
            layout.width  = layout.height = YGPointValue(50);
            layout.marginHorizontal = layout.marginVertical = YGPointValue(10);

        }];
        
        [self addSubview:sub];
    }
    [self.yoga applyLayoutPreservingOrigin:YES];
}

@end
