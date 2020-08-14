

//
//  NSObject+function3.m
//  PJKnowledgeNotes
//
//  Created by 周鹏钜 on 2020/7/6.
//  Copyright © 2020 zhoupengju. All rights reserved.
//

#import "NSObject+function3.h"
#import "NSObject+MethodSwizzling.h"

@implementation NSObject (function3)

//+ (void)load {
//
//    static dispatch_once_t predicate;
//
//    dispatch_once(&predicate, ^{
//
//        [NSObject yscDefenderSwizzlingInstanceMethod:@selector(copy)
//        withMethod:@selector(function1_viewDidLoad)
//         withClass:[NSObject class]];
//    });
//}
//
//- (void)function1_viewDidLoad {
//    [self function1_viewDidLoad];
//    NSLog(@"NSObject+function3");
//}

@end
