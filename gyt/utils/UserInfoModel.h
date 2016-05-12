//
//  UserInfoModel.h
//  gyt
//
//  Created by by.huang on 16/5/12.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

//账号Id
@property (copy , nonatomic) NSString *m_strAccountID;

//账号类型
@property (copy , nonatomic) NSString *m_nAccountType;

//账号密码
@property (copy , nonatomic) NSString *m_strPassword;

//账户状态
@property (copy , nonatomic) NSString *m_nStatus;

//是否可交易
@property (assign , nonatomic) Boolean m_bAllowTrade;

//是否分账号
@property (assign , nonatomic) Boolean m_bSubAccount;

//是否模拟账号
@property (assign , nonatomic) Boolean m_bSimAccount;

//账号姓名
@property (copy , nonatomic) NSString *m_strName;

//对应代理的名称
@property (copy , nonatomic) NSString *m_strUserID;

//经纪公司ID
@property (copy , nonatomic) NSString *m_strBrokerID;



@end

