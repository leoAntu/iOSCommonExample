//
//  CommonController.m
//  RACDemo
//
//  Created by 叮咚钱包富银 on 2018/6/13.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "CommonController.h"
#import <ReactiveObjC/ReactiveObjC.h>
@interface CommonController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textInput;

@end

@implementation CommonController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self test1];
//    [self test2];
    
    [self test3];
}

/**
 *RAC宏
 */
- (void)test1 {
    
    // RAC:把一个对象的某个属性绑定一个信号,只要发出信号,就会把信号的内容给对象的属性赋值
    // 给label的text属性绑定了文本框改变的信号
    
    RAC(self.label, text) = self.textInput.rac_textSignal;
    //同上方法
//    @weakify(self)
//    [self.textInput.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
//        @strongify(self)
//        self.label.text = x;
//    }];
}

/**
 *  KVO
 *  RACObserveL:快速的监听某个对象的某个属性改变
 *  返回的是一个信号,对象的某个属性改变的信号
 */
- (void)test2 {
    
    [RACObserve(self.view, center) subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    
    RAC(self.label, text) = self.textInput.rac_textSignal;
    [RACObserve(self.label, text) subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

/**
 * 元祖
 * 快速包装一个元组
 * 把包装的类型放在宏的参数里面,就会自动包装
 */
- (void)test3 {

    RACTuple *tuple = RACTuplePack(@1,@3,@4);
    // 宏的参数类型要和元祖中元素类型一致， 右边为要解析的元祖。
    RACTupleUnpack(NSNumber *num1,NSNumber *num2,NSNumber *num3) = tuple;
    
    NSLog(@"%@ %@ %@",num1,num2,num3);
}

@end
