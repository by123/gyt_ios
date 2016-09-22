//
//  UserInfoDataModel.h
//  gyt
//
//  Created by by.huang on 16/5/12.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"


@interface UserInfoDataModel : NSObject

//sessionId
@property (copy, nonatomic) NSString *sessionId;

//用户信息模型
@property (strong, nonatomic) UserInfoModel *accountInfo;

@end