//
//  PJRouteURL.h
//  PJKnowledgeNotes
//
//  Created by 周鹏钜 on 2020/7/14.
//  Copyright © 2020 zhoupengju. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PJRouteURL : NSURL

@property (nonatomic, copy, readonly) NSString *urlWithoutParams;

@property (nonatomic, strong, readonly) NSDictionary<NSString *, id> *params;

+ (instancetype)URLWithString:(NSString *)URLString params:(NSDictionary<NSString *, id> *)params;

@end

NS_ASSUME_NONNULL_END
