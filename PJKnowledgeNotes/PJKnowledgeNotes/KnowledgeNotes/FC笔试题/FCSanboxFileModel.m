//
//  FCSanboxFileModel.m
//  FC笔试题
//
//  Created by 周鹏钜 on 2018/8/31.
//  Copyright © 2018年 zhoupengju. All rights reserved.
//

#import "FCSanboxFileModel.h"

@implementation FCSanboxFileModel

- (NSString *)showSize {
    if (_showSize) {
        return _showSize;
    }
    
    if (_size >= pow(10, 9)) {
        // size >= 1GB
        _showSize = [NSString stringWithFormat:@"%.2fGB", _size / pow(10, 9)];
    } else if (_size >= pow(10, 6)) {
        // 1GB > size >= 1MB
        _showSize = [NSString stringWithFormat:@"%.2fMB", _size / pow(10, 6)];
    } else if (_size >= pow(10, 3)) {
        // 1MB > size >= 1KB
        _showSize = [NSString stringWithFormat:@"%.2fKB", _size / pow(10, 3)];
    } else {
        // 1KB > _size
        _showSize = [NSString stringWithFormat:@"%lluB", _size];
    }
    return _showSize;
}

@end
