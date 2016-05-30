//
//  QueryRequestModel.h
//  gyt
//
//  Created by by.huang on 16/5/17.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@interface QueryRequestModel : NSObject

@property (strong, nonatomic) UserInfoModel *account;

@property (assign , nonatomic) int structId;

@property (copy, nonatomic) NSString *strSessionID;


@end
