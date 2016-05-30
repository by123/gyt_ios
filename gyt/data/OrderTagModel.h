//
//  OrderTagModel.h
//  gyt
//
//  Created by by.huang on 16/5/30.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@interface OrderTagModel : NSObject

@property (copy , nonatomic) NSString *m_strUser; // 用户

@property (assign , nonatomic) long m_nOrderDate; // 日期

@property (copy , nonatomic) NSString *m_strSessionTag; // 会话号

@property (copy , nonatomic) NSString *m_strRequestId; // 请求号

@property (assign , nonatomic) long *m_nOrderTime;  // 下单时间

@property (copy , nonatomic) NSString *m_strLocalInfo; //IP MAC,以后可能有别的东西

@property (strong, nonatomic) UserInfoModel *m_realAccount;// 实盘账号

@property (copy, nonatomic) NSString *m_strRealTag; // 实盘标记

@property (copy, nonatomic) NSString *m_strOrderSysId; // 实盘委托号

@property (assign , nonatomic) long *m_nfrontId; //

@property (assign , nonatomic) long *m_nsessionId; //

@property (assign , nonatomic) long *m_nrequestId; //


+(NSString *)generateRequestID;


@end
