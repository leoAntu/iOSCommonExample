//
//  PropertyViewController.m
//  PopDemo
//
//  Created by 叮咚钱包富银 on 2018/6/15.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "PropertyViewController.h"
#import <pop/pop.h>
@interface PropertyViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation PropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self addAnimation];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)addAnimation {
    [self.label pop_removeAllAnimations];
    
    POPBasicAnimation *pop = [POPBasicAnimation animation];
    
    pop.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"count" initializer:^(POPMutableAnimatableProperty *prop) {
        prop.readBlock = ^(id obj, CGFloat *values) {
            values[0] = [[obj description] floatValue];
        };
        
        prop.writeBlock = ^(id obj, const CGFloat *values) {
            [obj setText:[NSString stringWithFormat:@"%.2f",values[0]]];
        };
        
        prop.threshold = 0.01;
    }];
    
    pop.property = prop;
    
    pop.fromValue = @(0.00);
    pop.toValue = @(100.00);
    pop.duration = 100;
    [self.label pop_addAnimation:pop forKey:@"ads"];
}


@end
