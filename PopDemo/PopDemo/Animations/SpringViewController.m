//
//  SpringViewController.m
//  PopDemo
//
//  Created by 叮咚钱包富银 on 2018/6/15.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "SpringViewController.h"
#import <pop/pop.h>
@interface SpringViewController ()
@property (nonatomic, strong) CALayer *popLayer;
@property (nonatomic, assign) BOOL isScaleChange;

@end

@implementation SpringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view.layer addSublayer:self.popLayer];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self addAnitmation];

}


- (void)addAnitmation {
    [self.popLayer pop_removeAllAnimations];
    
    POPSpringAnimation *pop = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
//    pop.fromValue = @(self.popLayer.frame.origin.y + 400);
    
    if (!_isScaleChange) {
        pop.toValue = @(200);
    } else {
        pop.toValue = @(self.view.center.y + 400);
    }
    _isScaleChange = !_isScaleChange;
    
    pop.springBounciness = 8;
    pop.springSpeed = 20;
    __weak __typeof(self) weakSelf = self;
    pop.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (finished) {
            [weakSelf addAnitmation];
        }
    };

    [self.popLayer pop_addAnimation:pop forKey:nil];
    
}

- (void)viewDidLayoutSubviews {
    self.popLayer.bounds = CGRectMake(0, 0, 50, 50);
    self.popLayer.position = CGPointMake(self.view.center.x, self.view.center.y + 400);
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


@end
