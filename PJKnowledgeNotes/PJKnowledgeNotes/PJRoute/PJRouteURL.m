//
//  PJRouteURL.m
//  PJKnowledgeNotes
//
//  Created by 周鹏钜 on 2020/7/14.
//  Copyright © 2020 zhoupengju. All rights reserved.
//

#import "PJRouteURL.h"

@interface PJRouteURL () {
@private
    NSString *_urlWithoutParams;
    NSDictionary<NSString *, NSString *> *_params;
}

@end

@implementation PJRouteURL

+ (instancetype)URLWithString:(NSString *)URLString params:(NSDictionary<NSString *,id> *)params {
    PJRouteURL *url = [PJRouteURL URLWithString:URLString];
    [url initializeWithParam:params];
    return url;
}

- (void)initializeWithParam:(NSDictionary<NSString *, id> *)params {
    
}

@end
