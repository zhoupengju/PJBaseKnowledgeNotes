//
//  PJPerson.m
//  runtime
//
//  Created by 周鹏钜 on 2018/8/24.
//  Copyright © 2018年 zhoupengju. All rights reserved.
//

#import "PJDog.h"
#import "PJPerson.h"
#import <objc/runtime.h>

@implementation PJPerson

-(void)dealloc {
    NSLog(@"dealloc");
}
//
//- (void)others {
//    NSLog(@"------others------");
//}
//
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    
//    Method method = class_getInstanceMethod(self, @selector(others));
//    
//    class_addMethod(self, sel, method_getImplementation(method), method_getTypeEncoding(method));
//    
//    return [super resolveInstanceMethod:sel];
//}

//-(void)personTest {
//    NSLog(@"%@", [self class]);
//    
//    
//}
//
//-(void)eat {
////    NSLog(@"%f", [[UIApplication sharedApplication] statusBarFrame].size.height);
//}
//
//// 3. 消息转发
//
//-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
//    
//    if (aSelector == @selector(test:)) {
////        return [NSMethodSignature signatureWithObjCTypes:"v16@0:8"];
////        return [[[PJDog alloc] init] methodSignatureForSelector:aSelector];
//        return [NSMethodSignature signatureWithObjCTypes:"i@:i"];
//    }
//    
//    return [super methodSignatureForSelector:aSelector];
//}

// anInvocation封装了一个方法调用, 包括调用者, 方法名, 方法参数
// anInvocation.target      调用者
// anInvocation.selector    方法名
// [anInvocation getArgument:NULL atIndex:0]    方法参数

// 这个方法里面想干什么就干什么, 什么都不干也行, 可以尽情的放飞自我
//-(void)forwardInvocation:(NSInvocation *)anInvocation {
//    
////    anInvocation.target = [[PJDog alloc] init];
////    [anInvocation invoke];
//    
//    [anInvocation invokeWithTarget:[[PJDog alloc] init]];
//
//    int age = 0;
//    [anInvocation getReturnValue:&age];
//    NSLog(@"%d", age);
//}

//-(id)forwardingTargetForSelector:(SEL)aSelector {
//
//    if (aSelector == @selector(test)) {
//        return nil;
//    }
//
//    return [super forwardingTargetForSelector:aSelector];
//}

//-(id)forwardingTargetForSelector:(SEL)aSelector {
//
//    if (aSelector == @selector(test)) {
//        return [[PJDog alloc] init];
//    }
//
//    return [super forwardingTargetForSelector:aSelector];
//}

// 2. 动态方法解析

//- (void)others {
//    NSLog(@"%s", __func__);
//}
//
//void c_others(id self, SEL _cmd) {
//    NSLog(@"%s", __func__);
//}
//
//+(BOOL)resolveInstanceMethod:(SEL)sel {
//
//    if (sel == @selector(others)) {
//
//        class_addMethod(self, sel, (IMP)c_others, "v16@0:8");
//    }
//
//    return [super resolveInstanceMethod:sel];
//}

//+(BOOL)resolveInstanceMethod:(SEL)sel {
//
//    if (sel == @selector(test)) {
//
//        Method method = class_getInstanceMethod(self, @selector(others));
//        class_addMethod(self, sel, method_getImplementation(method), method_getTypeEncoding(method));
//    }
//
//    return [super resolveInstanceMethod:sel];
//}

//struct method_t {
//    SEL sel;
//    char *types;
//    IMP imp;
//};
//
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//
//    if (sel == @selector(test)) {
//
//        // 获取其他方法
//        struct method_t *methOther = (struct method_t *)class_getInstanceMethod(self, @selector(others));
//
//        // 动态添加test方法的实现
//        class_addMethod(self, sel, methOther->imp, methOther->types);
//
//        // 返回YES表示有动态添加方法
//        return YES;
//    }
//
//    return [super resolveInstanceMethod:sel];
//}

// 1. 消息发送




//objc_getClass("PJPerson"); // 获取类的类对象
//Method method1 = class_getClassMethod([PJPerson class], @selector(imageNamed:));
//Method method2 = class_getClassMethod([PJPerson class], @selector(PJ_imageNamed:));
//method_exchangeImplementations(method1, method2);
//
//// 1.加载图片 2.判断
//+ (UIImage *)PJ_imageNamed:(NSString *)name {
//    
//    UIImage *image = [PJPerson PJ_imageNamed:name];
//    if (!image) {
//        NSLog(@"图片不存在");
//    }
//    
//    return image;
//    
//}



@end
