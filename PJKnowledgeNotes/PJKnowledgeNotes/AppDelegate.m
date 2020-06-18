//
//  AppDelegate.m
//  PJKnowledgeNotes
//
//  Created by 周鹏钜 on 2019/12/2.
//  Copyright © 2019 zhoupengju. All rights reserved.
//

#import "AppDelegate.h"
#import "PJKnowledgeNotesMainTabBarManger.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
       self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
       self.window.frame = [UIScreen mainScreen].bounds;
       self.window.backgroundColor = [UIColor whiteColor];
       
       //2. 主界面启动逻辑管理
       [self mainPageStartLogicManger];
       
       [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)mainPageStartLogicManger {
    
    [self mainPageTabBarManger];
}

- (void)mainPageTabBarManger {

    PJKnowledgeNotesMainTabBarManger *tabBarManger = [[PJKnowledgeNotesMainTabBarManger alloc] init];
    UITabBarController *tabBarVc = [tabBarManger settingTabBar];
    self.window.rootViewController = tabBarVc;
}

@end
