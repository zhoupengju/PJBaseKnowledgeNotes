

//
//  KVOKController.m
//  PJKnowledgeNotes
//
//  Created by 周鹏钜 on 2020/7/1.
//  Copyright © 2020 zhoupengju. All rights reserved.
//

#import "KVOKObject.h"
#import "KVOKController.h"

@interface KVOKController ()

@property (nonatomic, strong) KVOKObject *obj;

@end

@implementation KVOKController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    KVOKObject *obj = [[KVOKObject alloc] init];
    _obj = obj;
    
//    [obj addObserver:self forKeyPath:@"ageH" options: NSKeyValueObservingOptionNew context:nil];
//
//    [obj setValue:@10 forKey:@"ageH"];
//
//    NSLog(@"%@, %@", object_getClass(obj), [object_getClass(obj) superclass]);
//
//    NSLog(@"--------------------------------------------");
//
//
//    unsigned int count;
//    Method *methodList = class_copyMethodList(object_getClass(obj), &count);
//
//    for (unsigned int i=0; i<count; i++) {
//        Method method = methodList[i];
//
//        NSString *methodName = NSStringFromSelector(method_getName(method));
//
//        NSLog(@"ivar(%d) : %@", i, methodName);
//    }
//
//    free(methodList);
//
//
//    [obj removeObserver:self forKeyPath:@"ageH"];
    
    
    // copy 能保证修改外面的变量不影响内部的变量
    NSMutableString *strM = [NSMutableString string];
    [strM setString:@"123456"];

    obj.name = strM;

    [strM setString:@"34566"];
    NSLog(@"%@", obj.name);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@", change);
}

@end
