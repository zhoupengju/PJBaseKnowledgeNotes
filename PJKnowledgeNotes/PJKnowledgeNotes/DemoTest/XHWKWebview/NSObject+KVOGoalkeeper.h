//
//  NSObject+KVOGoalkeeper.h
//  EverStarIOSCode
//
//  Created by 周鹏钜 on 2020/6/29.
//  Copyright © 2020 李顺喜. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KVOGoalkeeper)

-(BOOL)isObj:(NSObject *)obj hasObserverKey:(NSString *)keyPath;

@end

NS_ASSUME_NONNULL_END
