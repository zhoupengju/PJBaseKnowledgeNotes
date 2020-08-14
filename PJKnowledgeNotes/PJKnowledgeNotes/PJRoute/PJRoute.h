//
//  PJRoute.h
//  PJKnowledgeNotes
//
//  Created by 周鹏钜 on 2020/7/14.
//  Copyright © 2020 zhoupengju. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PJRouteProtocol <NSObject>

- (instancetype)initWithParams:(NSDictionary *)param;

@optional
- (BOOL)presentingSelf;

@end

@interface PJRoute : NSObject

+ (BOOL)openURL:(NSString *)url;

+ (void)openURL:(NSString *)url callback:(void (^)(BOOL result))callback;

+ (BOOL)openURL:(NSString *)url param:(nullable NSDictionary<NSString *, id> *)param;

+ (void)openURL:(NSString *)url param:(nullable NSDictionary<NSString *, id> *)param callback:(void (^)(BOOL result))callback;

@end

NS_ASSUME_NONNULL_END
