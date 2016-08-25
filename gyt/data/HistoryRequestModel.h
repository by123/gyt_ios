//
//  HistoryRequestModel.h
//  gyt
//
//  Created by by.huang on 16/8/24.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QueryHistoryModel.h"

@interface HistoryRequestModel : NSObject

@property (copy ,nonatomic) NSString *strSessionID;

@property (strong, nonatomic) QueryHistoryModel *req;

@end
