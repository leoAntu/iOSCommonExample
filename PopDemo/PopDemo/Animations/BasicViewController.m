//
//  BasicViewController.m
//  PopDemo
//
//  Created by 叮咚钱包富银 on 2018/6/15.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "BasicViewController.h"
#import <pop/pop.h>

@interface BasicViewController ()
@property (nonatomic, strong) CALayer *popLayer;
@property (nonatomic, assign) BOOL isScaleChange;

@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view.layer addSublayer:self.popLayer];
  
    [self animationGroup];
}

- (void)animationGroup {
    [self.popLayer pop_removeAllAnimations];
    [self addAnimation];
    [self addAnimation2];
    self.isScaleChange = !self.isScaleChange;

}

- (void)addAnimation2 {
    POPBasicAnimation * pop = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    if (!_isScaleChange) {
        pop.toValue = @0.2;
    } else {
        pop.toValue = @1;
    }
    
    pop.duration = 1;
    
    //线性变换
    pop.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.popLayer pop_addAnimation:pop forKey:@"aaaa"];
}

- (void)addAnimation {
    POPBasicAnimation * pop = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    if (!_isScaleChange) {
        pop.toValue = [NSValue valueWithCGPoint:CGPointMake(2.0, 2.0)];
    } else {
        pop.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
    }

    //线性变换
    pop.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    pop.duration = 1;

    //不停的递归循环
    __weak __typeof(self) weakSelf = self;
    pop.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (finished) {
            [weakSelf animationGroup];
        }
    };
    
    [self.popLayer pop_addAnimation:pop forKey:@"animation"];
    
}

- (void)viewDidLayoutSubviews {
    self.popLayer.bounds = CGRectMake(0, 0, 50, 50);
    self.popLayer.position = self.view.center;
}

- (CALayer *)popLayer {
    if (!_popLayer) {
        _popLayer = [CALayer layer];
        _popLayer.opacity = 1;
        _popLayer.backgroundColor = [UIColor greenColor].CGColor;
        _popLayer.cornerRadius = 25;
    }
    return _popLayer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
