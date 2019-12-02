//
//  PJKnowledgeNotesMainTabBarManger.m
//  PJKnowledgeNotes
//
//  Created by 周鹏钜 on 2019/12/2.
//  Copyright © 2019 zhoupengju. All rights reserved.
//

#import "PJKnowledgeNotesController.h"
#import "PJNavigationBaseController.h"
#import "PJKnowledgeNotesMainTabBarManger.h"

@implementation PJKnowledgeNotesMainTabBarManger

-(PJTabBarBaseController *)settingTabBar {
    
    PJTabBarBaseController *tabbar = [[PJTabBarBaseController alloc] init];

//    [tabbar.tabBar setTintColor:kTabBarNormal];
//    [tabbar.tabBar setBarTintColor:kTabBarNormal];
//
//    UIImage* tabBarBackground = [UIImage imageWithColor:kWhile withFrame:CGRectMake(0, 0, StarWIDTH, StatusRectH)];
//    [[UITabBar appearance] setBackgroundImage:[tabBarBackground resizableImageWithCapInsets:UIEdgeInsetsZero]];
    
    UITabBarItem *items1 = [self createTabBar:1 withString:@"基础知识"];
    PJNavigationBaseController *nav1 = [[PJNavigationBaseController alloc] initWithRootViewController:[[PJKnowledgeNotesController alloc] init]];
    nav1.tabBarItem = items1;
    
    
    tabbar.viewControllers = @[nav1];
    
    return tabbar;
}

- (UITabBarItem *)createTabBar:(int)type withString:(NSString *)title {
   
    UIImage *selectedImage=[UIImage imageNamed:[NSString stringWithFormat:@"iosxx_%d_on",type]];
    UIImage * originImage=[UIImage imageNamed:[NSString stringWithFormat:@"iosxx_%d",type]];
    
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    originImage = [originImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *item =[[UITabBarItem alloc] initWithTitle:title image:originImage selectedImage:selectedImage ];
    
    return item;
}

@end
