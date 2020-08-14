//
//  ThreadManager.h
//  面试题测试Test
//
//  Created by 周鹏钜 on 2019/10/21.
//  Copyright © 2019 zhoupengju. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThreadManager : NSObject <NSCopying>

+ (instancetype)shareInstance;

- (void)asynBlock:(dispatch_block_t)block;

@end

NS_ASSUME_NONNULL_END
