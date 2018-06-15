//
//  OtherViewController.m
//  PopDemo
//
//  Created by 叮咚钱包富银 on 2018/6/15.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "OtherViewController.h"
#import <pop/pop.h>
@interface OtherViewController ()
@property (nonatomic, strong) UIView *circleView;
@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.circleView];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.circleView addGestureRecognizer:pan];
    
}

- (void)panAction:(UIPanGestureRecognizer *)pan {
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged: {
            [self.circleView.layer pop_removeAllAnimations];
            
            CGPoint point = [pan translationInView:self.view];
            
            CGPoint center = self.circleView.center;
            center.x += point.x;
            center.y += point.y;
            
            self.circleView.center = center;
            [pan setTranslation:CGPointMake(0, 0) inView:self.circleView];

            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            CGPoint velocity = [pan velocityInView:self.view];
            [self addDecayAnimationWithPoint:velocity];
            break;
        }

        default:
            break;
    }
    
}

- (void)addDecayAnimationWithPoint:(CGPoint )point {
    [self.circleView.layer pop_removeAllAnimations];
    POPDecayAnimation *decay = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
    decay.velocity = [NSValue valueWithCGPoint:CGPointMake(point.x, point.y)];
    
    [self.circleView.layer pop_addAnimation:decay forKey:@"decay"];
    
}

- (void)addPopAnimation {
    [self.circleView.layer pop_removeAllAnimations];
    POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    spring.springSpeed = 13;
    spring.springBounciness = 10;
    spring.fromValue = [NSValue valueWithCGPoint:CGPointMake(0,0)];
    spring.toValue = [NSValue valueWithCGPoint:CGPointMake(2,2)];

    POPBasicAnimation *basic = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    basic.fromValue = @0;
    basic.toValue = @1;
    basic.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [self.circleView.layer pop_addAnimation:spring forKey:@"scale"];
    [self.circleView.layer pop_addAnimation:basic forKey:@"opacoty"];

}

- (void)addFlyAnimation {
    [self.circleView.layer pop_removeAllAnimations];
    self.circleView.layer.bounds = CGRectMake(0, 0, 160, 230);
    self.circleView.layer.affineTransform = CGAffineTransformMakeRotation(-M_PI_4/8);
    self.circleView.layer.cornerRadius = 5;
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anim.springBounciness = 6;
    anim.springSpeed = 8;
    anim.fromValue = @-200;
    anim.toValue = @(self.view.center.y);
    
    POPBasicAnimation *opacityAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    opacityAnim.duration = 0.25;
    opacityAnim.toValue = @1.0;
    
    POPBasicAnimation *rotationAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    rotationAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnim.beginTime = CACurrentMediaTime() + 0.2;
    rotationAnim.duration = 0.3;
    rotationAnim.toValue = @(0);
    
    
    [self.circleView.layer pop_addAnimation:anim forKey:@"kPOPLayerPositionY"];
    [self.circleView.layer pop_addAnimation:opacityAnim forKey:@"kPOPLayerOpacity"];
    [self.circleView.layer pop_addAnimation:rotationAnim forKey:@"rotation"];

}

- (void)addTransformAnimation {
    [self.circleView.layer pop_removeAllAnimations];
    
    self.circleView.layer.opacity = 1;
    
    CAShapeLayer *shapLayer = [CAShapeLayer layer];
    shapLayer.strokeColor = [UIColor redColor].CGColor;
    shapLayer.lineCap = kCALineCapRound;
    shapLayer.lineJoin = kCALineJoinBevel;
    shapLayer.lineWidth = 26;
    //0 默认不进行绘制 大于0就可以
    shapLayer.strokeEnd = 0;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint: CGPointMake(25, 25)];
    [path addLineToPoint:CGPointMake(700, 25)];
    shapLayer.path = path.CGPath;

    [self.circleView.layer addSublayer:shapLayer];
    
    POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    spring.toValue = [NSValue valueWithCGPoint:CGPointMake(0.3, 0.3)];
    spring.springSpeed = 5;
    spring.springBounciness = 10;
    
    POPSpringAnimation *springBounds = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
    springBounds.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 800, 50)]; //scale缩小，要设置的打一点，800 * 0.3 = 270的长度
    springBounds.springSpeed = 5;
    springBounds.springBounciness = 10;
    
    __weak __typeof(self) weak = self;
    springBounds.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (!finished) {
            return ;
        }
        UIGraphicsBeginImageContextWithOptions(weak.circleView.frame.size, false, 0);
        //绘制shapLayer
        POPBasicAnimation *basic = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
        basic.duration = 1;
        basic.fromValue = @0;
        basic.toValue = @1;
        basic.completionBlock = ^(POPAnimation *anim, BOOL finished) {
            UIGraphicsEndImageContext();
        };
        
        [shapLayer pop_addAnimation:basic forKey:@"basic"];
        
    };
    
    [self.circleView.layer pop_addAnimation:springBounds forKey:@"springBounds"];
    [self.circleView.layer pop_addAnimation:spring forKey:@"spring"];

}

- (void)viewDidLayoutSubviews {
    self.circleView.layer.position = self.view.center;
}

- (IBAction)btnAction:(id)sender {
    [self resetCirleView];
    if (self.type == OtherViewControllerTypePop) {
        [self addPopAnimation];
        
    } else if (self.type == OtherViewControllerTypeFly) {
        [self addFlyAnimation];
    } else {
        [self addTransformAnimation];
    }
}

- (void)resetCirleView {
    _circleView.layer.opacity = 0;
    _circleView.layer.backgroundColor = [UIColor greenColor].CGColor;
    _circleView.layer.cornerRadius = 25;
    _circleView.bounds = CGRectMake(0, 0, 50, 50);
    _circleView.layer.transform = CATransform3DIdentity;
    for (CAShapeLayer *layer in _circleView.layer.sublayers) {
        [layer removeFromSuperlayer];
    }

}

- (UIView *)circleView {
    if (!_circleView) {
        _circleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _circleView.layer.opacity = 0;
        _circleView.layer.backgroundColor = [UIColor greenColor].CGColor;
        _circleView.layer.cornerRadius = 25;
    }
    
    return _circleView;
}

@end
