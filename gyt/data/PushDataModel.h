//
//  PushDataModel.h
//  gyt
//
//  Created by by.huang on 16/6/7.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"
@interface PushDataModel : NSObject

@property (strong, nonatomic) UserInfoModel *account;

@property (strong, nonatomic) id data;
@end
