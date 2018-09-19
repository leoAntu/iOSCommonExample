//
//  QiChangeClickEffectiveAreaButton.h
//  QiButton_ChangeEffectiveClickArea
//
//  Created by qishare on 2018/8/11.
//  Copyright © 2018年 qishare. All rights reserved.
//
// 学习地址：https://www.jianshu.com/p/43c22fa3b42c

#import <UIKit/UIKit.h>

/**
 改变有效点击区域Button
 */
@interface QiChangeClickEffectiveAreaButton : UIButton

//! 点击范围的缩小值 此值目前只是为了演示 把较大按钮的点击范围变小
@property (nonatomic,assign) CGFloat qi_clickAreaReduceValue;

@end
