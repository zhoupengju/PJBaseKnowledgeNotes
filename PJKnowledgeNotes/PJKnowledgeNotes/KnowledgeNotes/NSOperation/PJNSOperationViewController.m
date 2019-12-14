//
//  PJNSOperationViewController.m
//  PJKnowledgeNotes
//
//  Created by 周鹏钜 on 2019/12/2.
//  Copyright © 2019 zhoupengju. All rights reserved.
//

#import "PJNSOperationViewController.h"

@interface PJNSOperationViewController ()

@end

@implementation PJNSOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(download) object:nil];
    
//    [operation start];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}

- (void)download {
    NSLog(@"download");
}

- (void)blockOperation {
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"=======下载图片====%@", [NSThread currentThread]);
    }];
    
    operation.completionBlock = ^{
        NSLog(@"=======下载图片完毕====%@", [NSThread currentThread]);
    };
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}

@end
