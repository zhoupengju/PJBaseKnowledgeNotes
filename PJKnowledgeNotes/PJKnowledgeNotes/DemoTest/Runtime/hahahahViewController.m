//
//  hahahahViewController.m
//  PJKnowledgeNotes
//
//  Created by 周鹏钜 on 2020/7/21.
//  Copyright © 2020 zhoupengju. All rights reserved.
//

#import "hahahahViewController.h"

@interface hahahahViewController ()

@end

@implementation hahahahViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@", [super class]);
    
    
    objc_msgSendSuper(
    
    {self, [UIViewController Class]},
    sel_registerName("class")
                       
                       )
}


@end
