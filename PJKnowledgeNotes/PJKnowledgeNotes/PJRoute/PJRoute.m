//
//  PJRoute.m
//  PJKnowledgeNotes
//
//  Created by 周鹏钜 on 2020/7/14.
//  Copyright © 2020 zhoupengju. All rights reserved.
//

#import "PJRoute.h"
#import "PJRouteURL.h"

@interface PJRoute ()

@property (nonatomic, class, readonly) PJRoute *shareInstance;  //!<

@end

@implementation PJRoute

+ (PJRoute *)shareInstance {
    static PJRoute *single = nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        single = [[PJRoute alloc] init];
        
    });
    return single;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static PJRoute *single = nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        single = [super allocWithZone:zone];
    });
    return single;
}

+ (BOOL)openURL:(NSString *)url {
    return [PJRoute openURL:url param:nil];
}

+ (void)openURL:(NSString *)url callback:(void (^)(BOOL))callback {
    [PJRoute openURL:url param:nil callback:callback];
}

+ (BOOL)openURL:(NSString *)url param:(nullable NSDictionary<NSString *,id> *)param {
    return YES;
}

+ (void)openURL:(NSString *)url param:(nullable NSDictionary<NSString *,id> *)param callback:(void (^)(BOOL))callback {
    
}

@end
