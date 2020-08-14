
//
//  KVOKObject.m
//  PJKnowledgeNotes
//
//  Created by 周鹏钜 on 2020/7/1.
//  Copyright © 2020 zhoupengju. All rights reserved.
//

#import "KVOKObject.h"

@implementation KVOKObject

- (void)willChangeValueForKey:(NSString *)key {
    NSLog(@"willChangeValueForKey");
    [super willChangeValueForKey:key];
}

- (void)didChangeValueForKey:(NSString *)key {
    NSLog(@"willChangeValueForKey - begin");
    [super didChangeValueForKey:key];
    NSLog(@"willChangeValueForKey - end");
}



- (void)setName:(NSString *)name {
    _name = [name copy];
    
    NSLog(@"%@", _name);
}

- (void)setAge:(NSString *)age {
    _age = age;
}

@end
