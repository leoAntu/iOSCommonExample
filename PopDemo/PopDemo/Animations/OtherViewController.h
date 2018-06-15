//
//  OtherViewController.h
//  PopDemo
//
//  Created by 叮咚钱包富银 on 2018/6/15.
//  Copyright © 2018年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, OtherViewControllerType) {
    OtherViewControllerTypePop,
    OtherViewControllerTypeFly,
    OtherViewControllerTypeTransform,

};

@interface OtherViewController : UIViewController
@property (nonatomic, assign) OtherViewControllerType type;
@end
