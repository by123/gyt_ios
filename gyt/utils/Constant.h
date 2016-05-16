//
//  Constant.h
//  haihua
//
//  Created by by.huang on 16/3/13.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark 本地存储
#define UserDefault_Updown @"updown"
#define UserDefault_Inventory @"inventory"

#pragma mark 广播
#define Notify_Menu_Title @"menu_title"
#define Notify_Update_UserInfo @"update_userinfo"

#pragma mark 网络请求相关
#define Root_Url @"http://192.168.1.106:8080"


//请求登录
#define Request_Login @"login"
//请求登出
#define Request_Logout @"logout"
//查询账号信息
#define Request_UserInfo @"queryAccountBaseInfo"
//提交出入金申请
#define Request_CashApplyInfo @"commitCashApplyInfo"



#define Info_Net_Error @"网络异常，点击刷新"



#pragma mark 小区信息存储
#define VillageID @"villageId"
#define VillageName @"villageName"