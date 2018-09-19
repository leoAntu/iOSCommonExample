//
//  AppDelegate.m
//  QiButton_ChangeEffectiveClickArea
//
//  Created by qishare on 2018/8/11.
//  Copyright © 2018年 qishare. All rights reserved.
//

#import "AppDelegate.h"
#import "QiButton_ChangeEffectiveClickAreaViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    _window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[QiButton_ChangeEffectiveClickAreaViewController new]];
    [_window makeKeyAndVisible];
    
    return YES;
}

@end
