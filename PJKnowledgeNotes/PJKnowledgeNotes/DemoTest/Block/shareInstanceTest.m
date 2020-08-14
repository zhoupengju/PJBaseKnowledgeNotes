//
//  shareInstanceTest.m
//  PJKnowledgeNotes
//
//  Created by 周鹏钜 on 2020/7/3.
//  Copyright © 2020 zhoupengju. All rights reserved.
//

#import "shareInstanceTest.h"

@implementation shareInstanceTest

+(instancetype)shareInstance {
    static shareInstanceTest *single = nil;
    static dispatch_once_t once;

    dispatch_once(&once, ^{
        single = [[shareInstanceTest alloc] init];
    });
    return single;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    [super allocWithZone:zone];
    
    static shareInstanceTest *single = nil;
    static dispatch_once_t once;

    dispatch_once(&once, ^{
        single = [super allocWithZone:zone];
    });
    return single;
}

@end
