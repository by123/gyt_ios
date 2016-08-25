//
//  QueryHistoryModel.h
//  gyt
//
//  Created by by.huang on 16/8/24.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@interface QueryHistoryModel : NSObject

@property (assign , nonatomic) int startDate;

@property (assign, nonatomic) int endDate;

@property (assign, nonatomic) int metaType;

@property (strong, nonatomic) UserInfoModel *account;

@end
