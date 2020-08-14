//
//  NSObject+function.m
//  面试题测试Test2
//
//  Created by 周鹏钜 on 2019/9/30.
//  Copyright © 2019 zhoupengju. All rights reserved.
//

#import <objc/runtime.h>
#import "NSObject+function.h"

@implementation NSObject (function)

+ (void)load {
    
//    static dispatch_once_t predicate;
//
//    dispatch_once(&predicate, ^{
//
//        Method funOri = class_getInstanceMethod(objc_getClass("NSObject"), @selector(methodSignatureForSelector:));
//        Method funNew = class_getInstanceMethod(objc_getClass("NSObject"), @selector(PJ_MethodSignatureForSelector:));
//
//        method_exchangeImplementations(funOri, funNew);
//
//
//        Method funOri2 = class_getInstanceMethod(objc_getClass("NSObject"), @selector(forwardInvocation:));
//        Method funNew2 = class_getInstanceMethod(objc_getClass("NSObject"), @selector(PJ_ForwardInvocation:));
//
//        method_exchangeImplementations(funOri2, funNew2);
        
//        Method funOri111 = class_getInstanceMethod(objc_getClass("NSInvocation"), @selector(getArgument:atIndex:));
//        Method funNew111 = class_getInstanceMethod(objc_getClass("NSInvocation"), @selector(PJ_GetArgument:atIndex:));
//
//        method_exchangeImplementations(funOri111, funNew111);
//    });
}

//- (NSMethodSignature *)PJ_MethodSignatureForSelector:(SEL)aSelector {
//    
////    if ([self respondsToSelector:aSelector]) {
////        return [super methodSignatureForSelector:aSelector];
////    }
//    
//    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
//}

//- (void)PJ_ForwardInvocation:(NSInvocation *)anInvocation {
//    NSLog(@"%@类中 找不到%@方法", [self class], NSStringFromSelector(anInvocation.selector));
////    int a = 10;
////    [anInvocation getArgument:&a atIndex:0];
//}

//- (void)PJ_GetArgument:(nonnull void *)val atIndex:(NSInteger)index {
//
//    [self PJ_GetArgument:val atIndex:index];
//
//    int a = 10;
//    [self PJ_GetArgument:&a atIndex:0];
//
////    if (val) {
////        [self PJ_GetArgument:val atIndex:index];
////    } else {
////        // 这个时候就奔溃了
////        __unsafe_unretained id argument;
////        [self PJ_GetArgument:&argument atIndex:2];
////    }
//}
//
//- (void)func1 {
//    NSLog(@"11111");
//}

@end
