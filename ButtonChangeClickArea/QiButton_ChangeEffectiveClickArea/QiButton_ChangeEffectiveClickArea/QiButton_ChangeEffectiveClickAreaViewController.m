//
//  QiButton_ChangeEffectiveClickAreaViewController.m
//  QiButton_ChangeEffectiveClickArea
//
//  Created by qishare on 2018/8/11.
//  Copyright © 2018年 qishare. All rights reserved.
//

#import "QiButton_ChangeEffectiveClickAreaViewController.h"
#import "QiChangeClickEffectiveAreaButton.h"
#import "QiTouchPenetrateView.h"

@interface QiButton_ChangeEffectiveClickAreaViewController ()

@property (nonatomic,strong) UILabel *bottomGrayContainerLabel;

@end

@implementation QiButton_ChangeEffectiveClickAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"改变按钮有效点击区域";
    
    [self changeButtonEffectiveClickAreaDemo];
}

#pragma mark - Private Functions

- (void)changeButtonEffectiveClickAreaDemo {
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UILabel *topTipsLabel = [UILabel new];
    topTipsLabel.textAlignment = NSTextAlignmentCenter;
    topTipsLabel.numberOfLines = 3;
    topTipsLabel.text = @"下边灰色视图是一个按钮A，\n按钮A的有效点击区域(热区)\n改为了黄色区域";
    [self.view addSubview:topTipsLabel];
    topTipsLabel.frame = CGRectMake(.0, 20.0, CGRectGetWidth(self.view.frame), 70.0);
    topTipsLabel.backgroundColor = [UIColor lightGrayColor];
    
    // 减小按钮的有效点击区域
    QiChangeClickEffectiveAreaButton *topGrayReduceClickAreaContainerButton = [QiChangeClickEffectiveAreaButton new];
    [self.view addSubview:topGrayReduceClickAreaContainerButton];
    topGrayReduceClickAreaContainerButton.frame = CGRectMake(CGRectGetMidX(self.view.frame) - 50.0, 100.0, 100.0, 100.0);
    topGrayReduceClickAreaContainerButton.backgroundColor = [UIColor darkGrayColor];
    topGrayReduceClickAreaContainerButton.qi_clickAreaReduceValue = 40.0;
    topGrayReduceClickAreaContainerButton.tag = 1;
    [topGrayReduceClickAreaContainerButton addTarget:self action:@selector(changeButtonEffectiveClickAreaButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    QiTouchPenetrateView *yellowTopRealClickAreaView = [QiTouchPenetrateView new];
    [topGrayReduceClickAreaContainerButton addSubview:yellowTopRealClickAreaView];
    yellowTopRealClickAreaView.frame = CGRectMake(0, 0, 20.0, 20.0);
    yellowTopRealClickAreaView.center = CGPointMake(topGrayReduceClickAreaContainerButton.bounds.size.width / 2, topGrayReduceClickAreaContainerButton.bounds.size.height / 2);
    yellowTopRealClickAreaView.backgroundColor = [UIColor yellowColor];
    
   
    UILabel *bottomTipsLabel = [UILabel new];
    bottomTipsLabel.textAlignment = NSTextAlignmentCenter;
    bottomTipsLabel.numberOfLines = 3;
    bottomTipsLabel.text = @"下边灰色视图是一个containerLabel\n 最中间的红色视图是一个按钮B\n 把按钮B的有效点击区域(热区)改为了蓝色区域";
    [self.view addSubview:bottomTipsLabel];
    bottomTipsLabel.frame = CGRectMake(.0, 220.0, CGRectGetWidth(self.view.frame), 70.0);
    bottomTipsLabel.backgroundColor = [UIColor lightGrayColor];
    
    // 增大按钮的点击区域
    _bottomGrayContainerLabel = [UILabel new];
    [self.view addSubview:_bottomGrayContainerLabel];
    _bottomGrayContainerLabel.frame = CGRectMake(CGRectGetMidX(self.view.frame) - 100.0, 300.0, 200.0, 200.0);
    _bottomGrayContainerLabel.backgroundColor = [UIColor darkGrayColor];
    _bottomGrayContainerLabel.userInteractionEnabled = YES;
    
    UILabel *blueRealEffectiveClickAreaLabel = [UILabel new];
    [_bottomGrayContainerLabel addSubview:blueRealEffectiveClickAreaLabel];
    blueRealEffectiveClickAreaLabel.frame = CGRectMake(.0, .0, 44.0, 44.0);
    blueRealEffectiveClickAreaLabel.center = CGPointMake(_bottomGrayContainerLabel.bounds.size.width / 2.0, _bottomGrayContainerLabel.bounds.size.height / 2.0);
    blueRealEffectiveClickAreaLabel.backgroundColor = [UIColor blueColor];
    blueRealEffectiveClickAreaLabel.userInteractionEnabled = YES;
    
    QiChangeClickEffectiveAreaButton *redEnlargeClickAreaButton = [QiChangeClickEffectiveAreaButton new];
    [_bottomGrayContainerLabel addSubview:redEnlargeClickAreaButton];
    redEnlargeClickAreaButton.frame = CGRectMake(.0, .0, 12.0, 12.0);
    redEnlargeClickAreaButton.center = CGPointMake(_bottomGrayContainerLabel.bounds.size.width / 2.0, _bottomGrayContainerLabel.bounds.size.height / 2.0);
    redEnlargeClickAreaButton.backgroundColor = [UIColor redColor];
    redEnlargeClickAreaButton.tag = 2;
    [redEnlargeClickAreaButton addTarget:self action:@selector(changeButtonEffectiveClickAreaButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Action Functions

- (void)changeButtonEffectiveClickAreaButtonClicked:(UIButton *)sender {
    
    sender.selected = !sender.selected;

    if (sender.tag == 1) {
        sender.backgroundColor = sender.selected ? [UIColor purpleColor] : [UIColor darkGrayColor];
    }else if(sender.tag == 2) {
        _bottomGrayContainerLabel.backgroundColor = sender.selected ? [UIColor purpleColor] : [UIColor darkGrayColor];
    }
}

@end
