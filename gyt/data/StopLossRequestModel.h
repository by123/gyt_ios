//
//  StopLossRequestModel.h
//  gyt
//
//  Created by by.huang on 16/9/27.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"
#import "StopLossModel.h"

@interface StopLossRequestModel : NSObject

@property (strong , nonatomic) UserInfoModel *accountInfo;

@property (strong, nonatomic) StopLossModel *setting;

@end
