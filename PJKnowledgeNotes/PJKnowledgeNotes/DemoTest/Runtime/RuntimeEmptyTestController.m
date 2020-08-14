
//
//  RuntimeEmptyTestController.m
//  PJKnowledgeNotes
//
//  Created by 周鹏钜 on 2020/7/10.
//  Copyright © 2020 zhoupengju. All rights reserved.
//

#import "PJDog.h"
#import "RuntimeEmptyTestController.h"

@interface RuntimeEmptyTestController ()

@end

@implementation RuntimeEmptyTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PJDog *dog = [[PJDog alloc] init];
    [dog test:2];
}

@end
