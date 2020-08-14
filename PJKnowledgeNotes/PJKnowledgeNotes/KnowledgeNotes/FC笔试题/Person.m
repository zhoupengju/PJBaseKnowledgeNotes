//
//  Person.m
//  FC笔试题
//
//  Created by 周鹏钜 on 2018/8/31.
//  Copyright © 2018年 zhoupengju. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person

+(void)load {
    
    Method funOri = class_getInstanceMethod(objc_getClass("Person"), @selector(funcA));
    Method funNew = class_getInstanceMethod(objc_getClass("Person"), @selector(funcB));
    method_exchangeImplementations(funOri, funNew);
}

- (void)funcA {
    NSLog(@"%s", __func__);
}

- (void)funcB {
    NSLog(@"%s", __func__);
}

- (void)scream {
    
    NSLog(@"啊嗷~~~");
    
//    [self screamExchangeImp];
}

- (void)screamNew {
    
    NSLog(@"Help~~~");
    
//    [self screamExchangeImpRestore];
}

// 方法交换
- (void)screamExchangeImp {
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        
        Method screamOri = class_getInstanceMethod(objc_getClass("Person"), @selector(scream));
        Method screamNew = class_getInstanceMethod(objc_getClass("Person"), @selector(screamNew));
        
        method_exchangeImplementations(screamOri, screamNew);
    });
}

// 方法交换 复原
- (void)screamExchangeImpRestore {
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        
        Method screamOri = class_getInstanceMethod(objc_getClass("Person"), @selector(screamNew));
        Method screamNew = class_getInstanceMethod(objc_getClass("Person"), @selector(scream));
        
        method_exchangeImplementations(screamOri, screamNew);
    });
}

@end
