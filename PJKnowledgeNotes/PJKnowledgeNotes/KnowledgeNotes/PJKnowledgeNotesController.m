//
//  PJKnowledgeNotesController.m
//  PJKnowledgeNotes
//
//  Created by 周鹏钜 on 2019/12/2.
//  Copyright © 2019 zhoupengju. All rights reserved.
//

#import "Person.h"
#import "PJPerson.h"
#import "ThreadManager.h"
#import "ViewControllerHelper.h"
#import "PJKnowledgeNotesController.h"


/**
   GCD简单易用, 对于不复杂的多线程操作, 会节省代码量
   NSOperation可以调用cancel来取消某个操作, 而GCD中的任务是无法取消的
   NSOperation可以指定操作间的依赖关系
   NSOperation可以指定操作优先级
   可以通过KVO提供对NSOperation的精细化控制(取消, 完成 等)
*/

static NSString *ID = @"UITableViewCell";

@interface PJKnowledgeNotesController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *arrayData;

@end

@implementation PJKnowledgeNotesController

void testttttttt(void) {
return;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSLog(@"1");
//      dispatch_semaphore_t s = dispatch_semaphore_create(0);
//      dispatch_async(dispatch_get_global_queue(0, 0), ^{
//          dispatch_semaphore_signal(s);
//          dispatch_async(dispatch_get_main_queue(), ^{
//              NSLog(@"2");
//
//          });
//      });
//      NSLog(@"3");
//      dispatch_semaphore_wait(s, DISPATCH_TIME_FOREVER);
//      NSLog(@"4");
    
//    NSLock *lock = [[NSLock alloc] init];
//    NSLog(@"1111111111111");
//    [lock lock];
//
//    [lock lock];
//    NSLog(@"11112222222222211");
//    NSLog(@"------------------");
//    [lock unlock];
//    NSLog(@"11113333333333111");
//
//    NSLog(@"1144444444411");
    
    //    PJBlock block;
    //
    //    __block int age = 10;
    //
    //    block = ^{
    //
    //        age = 20;
    //
    //        NSLog(@"---------%d", age);
    //    };
    //
    //    block();
        
    //    NSLog(@"%lf", [[NSDate date] timeIntervalSince1970]);
        
    //    NSLog(@"%@", [block class]);
    //    NSLog(@"%@", [block superclass]);
    //    NSLog(@"%@", [[block superclass] superclass]);
    //    NSLog(@"%@", [[[block superclass] superclass] superclass]);

//        NSLog(@"%f", [[UIApplication sharedApplication] statusBarFrame].size.height);
        
//        PJPerson *person = [[PJPerson alloc] init];
//        [person eat];
//        [person test];
        
    //    __weak PJPerson *person1 = [[PJPerson alloc] init];
    
//    int a = 10;
//    static int b;
//
//    IMP methodPoint = testttttttt;
//
//    NSLog(@"%p, %p", &a, &b);
//    NSLog(@"%p", methodPoint);
    
    // ios10之前会崩溃
//    PJPerson *p = [[PJPerson alloc] init];
//    [p addObserver:self forKeyPath:@"_ageH" options:NSKeyValueObservingOptionNew context:nil];
//    [p setValue:@10 forKey:@"_ageH"];
    
//    NSMutableArray *arr = [NSMutableArray array];
//    for (int i=0; i<5; i++) {
//        PJPerson *p = [[PJPerson alloc] init];
//        p.age = i;
//        [arr addObject:p];
//    }
//
//    NSInteger sum = [[arr valueForKeyPath:@"@count.age"] integerValue];
//    NSLog(@"%ld", sum);
    
//    0x7ffee805c03c
//    0x107bbfa58
//    0x1063c18e0
    
//    Person *personA = [Person new];
//    [personA funcAhahhaha];
    
//    unsigned int count;
//    Ivar *ivarList = class_copyIvarList([UITextField class], &count);
//    for (unsigned int i=0; i<count; i++) {
//        Ivar myIvar = ivarList[i];
//        const char *ivarName = ivar_getName(myIvar);
//        NSLog(@"ivar(%d) : %@", i, [NSString stringWithUTF8String:ivarName]);
//    }
//    
//    free(ivarList);
    
//    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
//    NSString *keyPath = @"keyPath1";
//    dictM[keyPath] = @"name1";
//
//    PJLog(@"%@", dictM);
    
    PJPerson *p = [[PJPerson alloc] init];
    [p addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:nil];
    p.age = 2;
    
    [p personTest];
    
//    NSString *ssss = @"https://itunes.apple.com/lookup";
////    NSString *address = @"InnerJump://account/login";
//    NSURLComponents *components = [NSURLComponents componentsWithString:ssss];
//    NSString *scheme = components.scheme;
//    NSString *host = components.host;
//    NSString *path = components.path;
//    
//    PJLog(@"%@", scheme);
//    PJLog(@"%@", host);
//    PJLog(@"%@", path);
}

// 死锁
- (void)deadlock {
    
    __block NSInteger i = 1;
    __block NSInteger j = 1;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
        sleep(2);
        
        NSLog(@"-----------------111");
        sleep(1);
        if (i == 1) {
            i = 0;
            sleep(1);
            NSLog(@"-----------------2222");
        }
        
        while (1) {
            
            if (j == 1) {
                i = 1;
                sleep(1);
                NSLog(@"-----------------333");
            }
        }
    });
         
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
        sleep(2);
        
        NSLog(@"==================111");
        sleep(1);
        if (j == 1) {
            j = 0;
            sleep(1);
            NSLog(@"==================2222");
        }
        
        while (1) {
            
            if (i == 1) {
                j = 1;
                sleep(1);
                NSLog(@"==================333");
            }
        }
    });
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@", change);
}


- (void)createTableview {
    self.arrayData = [ViewControllerHelper dataSource];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableview = tableview;
    [self.view addSubview:tableview];
    
    tableview.delegate = self;
    tableview.dataSource = self;
    
    [tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    if (!cell) {
    
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    ViewControllerModel *model = self.arrayData[indexPath.row];
    
    cell.textLabel.text = model.name;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ViewControllerModel *model = self.arrayData[indexPath.row];
    
    UIViewController *vc = [[model.destVc alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)gcdMaxThread {
    
    //    dispatch_block_t block1 = ^(void) {
    //        NSLog(@"222222222");
    //    };
        
        for (int i=0; i<1000000000; i++) {
            [[ThreadManager shareInstance] asynBlock:^{
               NSLog(@"%@", [NSThread currentThread]);
            }];
        }
}

- (void)testCodeDoNotPerform1 {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        NSLog(@"11111111111");

        [self performSelector:@selector(test) withObject:nil afterDelay:0];
        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSRunLoopCommonModes];
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate date]];

        NSLog(@"33333333333");
        
//        for (int i=0; i<1000000000; i++) {
//            dispatch_async(queue, ^{
//                NSLog(@"%@", [NSThread currentThread]);
//            });
//        }
    });
}

- (void)testCodeDoNotPerform2 {
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        NSLog(@"1");

        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSRunLoopCommonModes];
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate date]];
    }];
    [thread start];
    
    [self performSelector:@selector(test) onThread:thread withObject:nil waitUntilDone:YES];
}

- (void)test {
    NSLog(@"222222222222");
}

- (void)down_MoreImage {
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_async(group, queue, ^{
        for (int i=0; i<10; i++) {
            NSLog(@"任务1= %@", [NSThread currentThread]);
        }
    });
    
    dispatch_group_async(group, queue, ^{
        for (int i=0; i<10; i++) {
            NSLog(@"任务2= %@", [NSThread currentThread]);
        }
    });
    
    dispatch_group_notify(group, queue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            for (int i=0; i<5; i++) {
                NSLog(@"任务3= %@", [NSThread currentThread]);
            }
        });
    });
}

- (void)sync_Mainqueue {
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        NSLog(@"%@", [NSThread currentThread]);
    });
}

- (void)sync_Main {
    
    dispatch_queue_t queue = dispatch_queue_create("serial", nil);
    dispatch_sync(queue, ^{
        NSLog(@"%@", [NSThread currentThread]);
    });
}

- (void)ync_Main {
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_sync(queue, ^{
        NSLog(@"%@", [NSThread currentThread]);
    });

    dispatch_async(queue, ^{
        NSLog(@"%@", [NSThread currentThread]);
    });
}
 
- (void)test_OpenThread {
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    for (int i=0; i<100; i++) {
        dispatch_async(queue, ^{
            NSLog(@"%@", [NSThread currentThread]);
        });
    }
}


// 栅栏函数测试
- (void)test2 {
    dispatch_queue_t queue = dispatch_queue_create("myqueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"111111111111111111");
        sleep(5);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"222222222222222222");
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"333333333333333333");
    });
    
    
    dispatch_async(queue, ^{
        NSLog(@"44444444444444444");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"55555555555555555");
    });
}


- (void)test1 {
    
    //    dispatch_group_t group = dispatch_group_create();
    //    dispatch_queue_t queue = dispatch_queue_create("myqueue", DISPATCH_QUEUE_CONCURRENT);
    //
    //    dispatch_group_async(group, queue, ^{
    //        NSLog(@"-------1111111111111---------");
    //    });
    //
    //    dispatch_group_async(group, queue, ^{
    //        NSLog(@"-------2222222222222---------");
    //    });
    //
    //    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
    //        NSLog(@"-----333333333----");
    //    });
}

- (void)test1111 {
    
    //    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //    for (int i=0; i<1000; i++) {
    //        dispatch_async(queue, ^{
    //
    ////            @synchronized(self) {
    //                self.name = [NSString stringWithFormat:@"abcdefghg"];
    ////            }
    //
    //        });
    //    }
    
    //    PJPerson *p = [[PJPerson alloc] init];
    //
    //    NSLog(@"%s", __func__);
}

@end
