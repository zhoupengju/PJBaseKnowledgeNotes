//
//  NSObject+SafeTool.m
//  PaySocialSecurity
//
//  Created by 周鹏钜 on 2019/12/11.
//  Copyright © 2019 zhoupengju. All rights reserved.
//

#import <objc/runtime.h>
#import "NSObject+SafeTool.h"
#import "NSObject+MethodSwizzling.h"

@implementation NSObject (SafeTool)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 拦截 `+forwardingTargetForSelector:` 方法，替换自定义实现
//        [NSObject yscDefenderSwizzlingInstanceMethod:@selector(resolveInstanceMethod:)
//                                       withMethod:@selector(pj_resolveInstanceMethod:)
//                                        withClass:[NSObject class]];
        
        [NSObject yscDefenderSwizzlingClassMethod:@selector(resolveInstanceMethod:)
        withMethod:@selector(pj_resolveInstanceMethod:)
         withClass:[NSObject class]];
        
    });
}

+ (BOOL)pj_resolveInstanceMethod:(SEL)sel {
    
    Method method = class_getInstanceMethod(self, @selector(others));
    
    class_addMethod(self, sel, method_getImplementation(method), method_getTypeEncoding(method));
    
    return [self pj_resolveInstanceMethod:sel];
}

- (BOOL)pj_resolveInstanceMethod:(SEL)sel {
    
    Method method = class_getInstanceMethod(self, @selector(others));
    
    class_addMethod(self, sel, method_getImplementation(method), method_getTypeEncoding(method));
    
    return [self pj_resolveInstanceMethod:sel];
}

- (void)others {
    NSLog(@"------others------");
}

// 动态添加的方法实现
static int Crash(id slf, SEL selector) {
    return 0;
}


//+ (void)load {
//
//    static dispatch_once_t predicate;
//
//    dispatch_once(&predicate, ^{
//
////        Method funOri = class_getInstanceMethod(objc_getClass("NSObject"), @selector(methodSignatureForSelector:));
////        Method funNew = class_getInstanceMethod(objc_getClass("NSObject"), @selector(PJ_MethodSignatureForSelector:));
////
////        method_exchangeImplementations(funOri, funNew);
////
////
////        Method funOri2 = class_getInstanceMethod(objc_getClass("NSObject"), @selector(forwardInvocation:));
////        Method funNew2 = class_getInstanceMethod(objc_getClass("NSObject"), @selector(PJ_ForwardInvocation:));
////
////        method_exchangeImplementations(funOri2, funNew2);
//
//
//        Method funOri = class_getInstanceMethod(objc_getClass("NSObject"), @selector(forwardingTargetForSelector:));
//        Method funNew = class_getInstanceMethod(objc_getClass("NSObject"), @selector(PJ_ForwardingTargetForSelector:));
//
//        method_exchangeImplementations(funOri, funNew);
//    });
//}
//
//- (id)PJ_ForwardingTargetForSelector:(SEL)aSelector {
//
//     NSLog(@"%@类中 找不到%@方法", [self class], NSStringFromSelector(aSelector));
//
//    NSString *className = @"CrachClass";
//    Class cls = NSClassFromString(className);
//
//    // 如果类不存在 动态创建一个类
//    if (!cls) {
//        Class superClsss = [NSObject class];
//        cls = objc_allocateClassPair(superClsss, className.UTF8String, 0);
//        // 注册类
//        objc_registerClassPair(cls);
//    }
//    // 如果类没有对应的方法，则动态添加一个
//    if (!class_getInstanceMethod(NSClassFromString(className), aSelector)) {
//        class_addMethod(cls, aSelector, (IMP)Crash, "@@:@");
//    }
//
//    return [[cls alloc] init];
//}
//
//// 动态添加的方法实现
//static int Crash(id slf, SEL selector) {
//    return 0;
//}

//- (NSMethodSignature *)PJ_MethodSignatureForSelector:(SEL)aSelector {
//
////    if ([self respondsToSelector:aSelector]) {
////        return [super methodSignatureForSelector:aSelector];
////    }
//
//    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
//}
//
//- (void)PJ_ForwardInvocation:(NSInvocation *)anInvocation {
//    NSLog(@"%@类中 找不到%@方法", [self class], NSStringFromSelector(anInvocation.selector));
//}

@end
