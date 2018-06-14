//
//  LoginViewModal.h
//  RACDemo
//
//  Created by 叮咚钱包富银 on 2018/6/13.
//  Copyright © 2018年 leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface LoginViewModal : NSObject

@property (nonatomic, strong) RACSignal *loginEnableSignal;

@property (nonatomic, copy) NSString *accout;

@property (nonatomic, copy) NSString *pwd;


@property (nonatomic, strong) RACCommand *loginCommand;

@end
