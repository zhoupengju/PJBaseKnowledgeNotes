//
//  KVOKObject.h
//  PJKnowledgeNotes
//
//  Created by 周鹏钜 on 2020/7/1.
//  Copyright © 2020 zhoupengju. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KVOKObject : NSObject
{
    NSInteger ageH;
}

@property (nonatomic, copy) NSString *name;

@property (nonatomic, weak) NSString *age;

@end

NS_ASSUME_NONNULL_END
