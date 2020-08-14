
//
//  ThreadManager.m
//  面试题测试Test
//
//  Created by 周鹏钜 on 2019/10/21.
//  Copyright © 2019 zhoupengju. All rights reserved.
//

#import "ThreadManager.h"

@interface ThreadManager ()

@property (atomic, strong) NSLock *lock;
@property (nonatomic, strong) dispatch_semaphore_t semaphore;
@property (nonatomic, strong) NSMutableArray *blocks;
@property (nonatomic, strong) NSThread *thread;

@end

@implementation ThreadManager

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static ThreadManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [ThreadManager new];
    });
    return manager;
}

- (id)copyWithZone:(NSZone *)zone {
    ThreadManager *manger = [[ThreadManager alloc] copyWithZone:zone];
    return manger;
}
    
- (instancetype)init {
    if (self = [super init]) { //5 not 6
        _semaphore = dispatch_semaphore_create(5);
        _lock = [[NSLock alloc] init];
        _blocks = [NSMutableArray array];
        _thread = [[NSThread alloc] initWithTarget:self selector:@selector(testRun) object:nil];
        [_thread start];
    }
    return self;
}
    
- (void)testRun {
    [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
}

- (void)asynBlock:(dispatch_block_t)block {

    
    NSLog(@"asynBlock begin");
    [self.lock lock];
    [_blocks addObject:block];
    [self.lock unlock];
    [self performSelector:@selector(excuteBlock) onThread:self.thread withObject:nil waitUntilDone:NO];
    NSLog(@"asynBlock block end");
}

- (void)excuteBlock {
    [self.lock lock];
    if (_blocks.count > 0) {
        dispatch_block_t block = [_blocks firstObject];
        [_blocks removeObjectAtIndex:0];
        [self doBlock:block];
    }
    [self.lock unlock];
}

- (void)doBlock:(dispatch_block_t)block {
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        block();
        dispatch_semaphore_signal(self.semaphore);
    });
}
    
@end
