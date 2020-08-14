//
//  NSObject+KVOGoalkeeper.m
//  EverStarIOSCode
//
//  Created by 周鹏钜 on 2020/6/29.
//  Copyright © 2020 李顺喜. All rights reserved.
//

#import "NSObject+KVOGoalkeeper.h"

@implementation NSObject (KVOGoalkeeper)

-(BOOL)isObj:(NSObject *)obj hasObserverKey:(NSString *)keyPath {
    if (obj == nil) {
        return NO;
    }
    if (obj.observationInfo == nil) {
        return NO;
    }
    NSObject *observances = [((__bridge NSObject*)(obj.observationInfo))valueForKeyPath:@"observances"];
    if ([observances isKindOfClass:[NSArray class]]) {
        for (NSObject *observance in (NSArray *)observances) {
            NSString *inKeyPath = [NSString stringWithFormat:@"Key path: %@",keyPath];
            NSString *objString = [NSString stringWithFormat:@"%@",observance];
            if ([objString containsString:inKeyPath]) {
                return YES;
            }
        }
    }
    return NO;
}

@end
