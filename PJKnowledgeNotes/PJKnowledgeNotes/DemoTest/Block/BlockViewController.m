
//
//  BlockViewController.m
//  PJKnowledgeNotes
//
//  Created by 周鹏钜 on 2020/7/3.
//  Copyright © 2020 zhoupengju. All rights reserved.
//

#import "shareInstanceTest.h"
#import "BlockViewController.h"
#import "MemoryManagerController.h"

@interface BlockViewController ()

@end

@implementation BlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    __block int age = 20;
//    void (^blockTest)(void) = ^{
//        age = 10;
//    };
//
//    blockTest();
//
//    NSLog(@"%d", age);

    [self shareInstanceTest];
}


- (void)dealloc {
    
}

// TODO: 单利测试
- (void)shareInstanceTest {
    
    shareInstanceTest *test1 = [[shareInstanceTest alloc] init];
    shareInstanceTest *test2 = [[shareInstanceTest alloc] init];
    shareInstanceTest *test3 = [[shareInstanceTest alloc] init];
    shareInstanceTest *test4 = [shareInstanceTest shareInstance];
    shareInstanceTest *test5 = [shareInstanceTest shareInstance];
    shareInstanceTest *test6 = [shareInstanceTest shareInstance];
    
    NSLog(@"%p", test1);
    NSLog(@"%p", test2);
    NSLog(@"%p", test3);
    NSLog(@"%p", test4);
    NSLog(@"%p", test5);
    NSLog(@"%p", test6);
}


@end
