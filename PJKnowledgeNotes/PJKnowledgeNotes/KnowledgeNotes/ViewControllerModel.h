//
//  ViewControllerModel.h
//  PJKnowledgeNotes
//
//  Created by 周鹏钜 on 2019/12/2.
//  Copyright © 2019 zhoupengju. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewControllerModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) Class destVc;

@end

NS_ASSUME_NONNULL_END
