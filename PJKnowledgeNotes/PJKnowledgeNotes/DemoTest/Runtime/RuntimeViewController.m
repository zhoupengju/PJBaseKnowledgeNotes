//
//  RuntimeViewController.m
//  PJKnowledgeNotes
//
//  Created by 周鹏钜 on 2019/12/14.
//  Copyright © 2019 zhoupengju. All rights reserved.
//

#import "PJThread.h"
#import "PJPerson.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import <Foundation/Foundation.h>
#import "RuntimeViewController.h"

@interface RuntimeViewController ()

@property (nonatomic, strong) PJThread *thread;

@property (nonatomic, strong) PJPerson *p;

@end

@implementation RuntimeViewController

/*
    sel_registerName("personTest") == @selector(personTest)
    objc_getClass("PJPerson") == [PJPerson class]
*/

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.thread = [[PJThread alloc] initWithTarget:self selector:@selector(run) object:nil];
//    [self.thread start];
    
//    PJPerson *p = [[PJPerson alloc] init];
//    _p = p;
//    p.age = 10;
//     [p addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
//
//    p.age = 1;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ttttttttt) name:@"PJhahahhhah" object:nil];
}

- (void)ttttttttt {
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self performSelector:@selector(test111) onThread:self.thread withObject:nil waitUntilDone:NO];
}

-(void)dealloc {
//    [self.p removeObserver:self forKeyPath:@"age"];
//    [self.p removeObserver:self forKeyPath:@"age"];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PJhahahhhah" object:nil];
    
    
}

- (void)test111 {
    NSLog(@"%@", [NSThread currentThread]);
}

- (void)run {
    NSLog(@"%@", [NSThread currentThread]);
    
    // 线程保活
    // 往 RunLoop里面添加Source/Timer/Observer
    [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
}

- (void)test1 {
    //    sel_registerName("personTest");
    //    NSLog(@"%p, %p", sel_registerName("personTest"), @selector(personTest));
    //
    //    objc_getClass("PJPerson");
    //
    //    PJPerson *person = [[PJPerson alloc] init];
    
    //    objc_msgSend(person, @selector(personTest));
    
    
    //    PJPerson *person = [[PJPerson alloc] init];
    //    [person test:12];
    //    NSLog(@"%d", [person test:12]);
    //
    ////    objc_msgSend(person, @selector(personTest));
    //
    //    unsigned int count;
    ////    Ivar *ivars = class_copyIvarList([PJPerson class], &count);
    //    Ivar *ivars = class_copyIvarList([UITextField class], &count);
    //
    //    for (int i=0; i<count; i++) {
    //        Ivar ivar = ivars[i];
    //        NSLog(@"%s, %s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
    //    }
    //
    //    // 使用了 copy或者create创建的都要进行释放
    //    free(ivars);
}

@end
