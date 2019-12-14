//
//  PJPerson.h
//  runtime
//
//  Created by 周鹏钜 on 2018/8/24.
//  Copyright © 2018年 zhoupengju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface PJPerson : NSObject

@property (nonatomic, assign) NSUInteger age;

@property (nonatomic, strong) NSString *name;

- (int)test:(int)num;

- (void)personTest;

+ (UIImage *)PJ_imageNamed:(NSString *)name;

@end
