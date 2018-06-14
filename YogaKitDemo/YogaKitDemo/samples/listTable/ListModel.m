
//
//  ListModel.m
//  YogaKitDemo
//
//  Created by 叮咚钱包富银 on 2018/6/4.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "ListModel.h"

@implementation ListModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _title = dictionary[@"title"];
        _content = dictionary[@"content"];
        _username = dictionary[@"username"];
        _time = dictionary[@"time"];
        _imageName = dictionary[@"imageName"];
    }
    
    return self;
}

@end
