//
//  OrderRequestModel.h
//  gyt
//
//  Created by by.huang on 16/5/30.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderModel.h"

@interface OrderRequestModel : NSObject

@property (strong, nonatomic) UserInfoModel *account;

@property (strong, nonatomic) OrderModel *info;

@property (copy, nonatomic) NSString *strSessionID;

@end
