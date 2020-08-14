//
//  WKWebView+Extension.m
//  EverStarIOSCode
//
//  Created by 周鹏钜 on 2020/6/29.
//  Copyright © 2020 李顺喜. All rights reserved.
//

#import <objc/runtime.h>
#import "WKWebView+Extension.h"
#import "NSObject+MethodSwizzling.h"

@implementation WKWebView (Extension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        [NSObject yscDefenderSwizzlingInstanceMethod:@selector(loadRequest:)
                                       withMethod:@selector(xh_loadRequest:)
                                        withClass:[WKWebView class]];
        
    });
}

- (WKNavigation *)xh_loadRequest:(NSURLRequest *)request {
    WKNavigation *WKNav = [self xh_loadRequest:request];

  //    要区分打开H5是在本地APP还是在手机浏览器，前端伙伴说需要配合修改默认的 UserAgent,以便区分。
    //    修改全局UserAgent值（这里是在原有基础上拼接自定义的字符串）
    [self evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
        
        NSString *userAgentOri = result;

        NSString *userAgent = @"";
//        NSString *userAgent = [NSString stringWithFormat:@"EverStar-iOS AppVerSion:%@ ProductType:%@ %@/%@ (%@; iOS %@; Scale/%0.2f)",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleVersionKey],NETWORK_GUEST_SEND, [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleExecutableKey] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleIdentifierKey], [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion], [[UIScreen mainScreen] scale]];
        
        NSString *newAgent = [userAgentOri stringByAppendingString:userAgent];
//        NSLog(@"new agent :%@", newAgent);
   
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:newAgent, @"UserAgent", nil];
         [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
         [[NSUserDefaults standardUserDefaults] synchronize];

         [self setCustomUserAgent:newAgent];
    }];

    return WKNav;
}

@end
