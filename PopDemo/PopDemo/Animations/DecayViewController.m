//
//  DecayViewController.m
//  PopDemo
//
//  Created by 叮咚钱包富银 on 2018/6/15.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "DecayViewController.h"
#import <pop/pop.h>

@interface DecayViewController ()
@property (nonatomic, strong) CALayer *popLayer;
@property (nonatomic, assign) BOOL isScaleChange;

@end

@implementation DecayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view.layer addSublayer:self.popLayer];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self addAnimation];
}

- (void)addAnimation {
    [self.popLayer pop_removeAllAnimations];
    POPDecayAnimation *pop = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    //不需要设置toValue
    if (!_isScaleChange) {
        pop.velocity = @200;
        pop.fromValue = @(25);
    } else {
        pop.velocity = @(-200);
    }
    _isScaleChange = !_isScaleChange;
    __weak __typeof(self)weak = self;
    pop.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (finished) {
            [weak addAnimation];
        }
    };
    [self.popLayer pop_addAnimation:pop forKey:@"ad"];
}

- (void)viewDidLayoutSubviews {
    self.popLayer.bounds = CGRectMake(0, 0, 50, 50);
    self.popLayer.position = CGPointMake(25, self.view.center.y);
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
