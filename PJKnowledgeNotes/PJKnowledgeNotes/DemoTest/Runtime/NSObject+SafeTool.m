//
//  NSObject+SafeTool.m
//  PaySocialSecurity
//
//  Created by 周鹏钜 on 2019/12/11.
//  Copyright © 2019 zhoupengju. All rights reserved.
//

#import "NSObject+SafeTool.h"

@implementation NSObject (SafeTool)

+ (void)load {

    static dispatch_once_t predicate;

    dispatch_once(&predicate, ^{

        Method funOri = class_getInstanceMethod(objc_getClass("NSObject"), @selector(methodSignatureForSelector:));
        Method funNew = class_getInstanceMethod(objc_getClass("NSObject"), @selector(PJ_MethodSignatureForSelector:));

        method_exchangeImplementations(funOri, funNew);


        Method funOri2 = class_getInstanceMethod(objc_getClass("NSObject"), @selector(forwardInvocation:));
        Method funNew2 = class_getInstanceMethod(objc_getClass("NSObject"), @selector(PJ_ForwardInvocation:));

        method_exchangeImplementations(funOri2, funNew2);
    });
}

- (NSMethodSignature *)PJ_MethodSignatureForSelector:(SEL)aSelector {

//    if ([self respondsToSelector:aSelector]) {
//        return [super methodSignatureForSelector:aSelector];
//    }

    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}

- (void)PJ_ForwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"%@类中 找不到%@方法", [self class], NSStringFromSelector(anInvocation.selector));
}

@end
