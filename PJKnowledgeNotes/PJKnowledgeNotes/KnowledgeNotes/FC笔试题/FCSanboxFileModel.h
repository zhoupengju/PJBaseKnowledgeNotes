//
//  FCSanboxFileModel.h
//  FC笔试题
//
//  Created by 周鹏钜 on 2018/8/31.
//  Copyright © 2018年 zhoupengju. All rights reserved.
//

#import <Foundation/Foundation.h>

//!<文件类型
typedef NS_ENUM(NSUInteger, FCSanboxFileType) {
    FCSanboxFileTypeUp = 0,
    FCSanboxFileTypeDirectory,
    FCSanboxFileTypeFile,
};

@interface FCSanboxFileModel : NSObject

@property (nonatomic, assign) FCSanboxFileType type;
@property (nonatomic, assign) unsigned long long size;  //!<文件大小
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *showSize;         //!<文件

@end
