//  出入金数据
//  GetCashModel.h
//  gyt
//
//  Created by by.huang on 16/5/14.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TitleContentModel.h"

typedef NS_ENUM(NSInteger, TargetType) {
    CashInOutTargetType_Proxy = 1 ,    // 代理(柜员)
    CashInOutTargetType_Account        // 客户
};

typedef NS_ENUM(NSInteger, CashType) {
     CashType_In = 1 ,        // 入金
     CashType_Out            // 出金
};


typedef NS_ENUM(NSInteger, PayType) {
    PayType_ON_LINE = 1,         //线上
    PayType_OFF_LINE            //线下
};

typedef NS_ENUM(NSInteger, CashApplicationStatus) {
    CashApplicationStatus_Submit = 1,    // 等待审核
    CashApplicationStatus_Accepted,     // 通过
    CashApplicationStatus_ForBidden,    // 拒绝
    CashApplicationStatus_Auto         // 自动审核
};


@interface AccessGoldModel : NSObject

//出入金对象ID
@property (copy , nonatomic) NSString *m_strTargetId;

//出入金对象类型
@property (assign, nonatomic) TargetType m_nTargetType;

//出入金对象
@property (assign, nonatomic) CashType m_nCashType;

//币种
@property (assign, nonatomic) MoneyType m_nMoneyType;

//金额
@property (assign, nonatomic) double m_dCashValue;

//流水号
@property (copy , nonatomic) NSString *m_strSerialNo;

//支付方式
@property (assign, nonatomic) PayType m_nPayType;

//申请状态
@property (assign, nonatomic) CashApplicationStatus m_nStatus;

//收款人
@property (copy , nonatomic) NSString *m_strReceiver;

//收款人银行名称
@property (copy , nonatomic) NSString *m_strReceiverBankName;

//收款人分行名称
@property (copy , nonatomic) NSString *m_strReceiverBranchBankName;

//收款人银行卡号
@property (copy , nonatomic) NSString *m_strReceiverBankNO;

//申请提交人
@property (copy , nonatomic) NSString *m_strSubmitter;

//申请日期
@property (copy , nonatomic) NSString *m_applyDate;

//申请时间
@property (copy , nonatomic) NSString *m_applyTime;

//备注
@property (copy , nonatomic) NSString *m_strApplyMemo;

//审核人
@property (copy , nonatomic) NSString *m_strChecker;

//审核日期
@property (copy , nonatomic) NSString *m_checkDate;

//审核时间
@property (copy , nonatomic) NSString *m_checkTime;

//审核备注
@property (copy , nonatomic) NSString *m_strCheckMemo;

+(NSString *)getCashType : (CashType)type;

+(NSString *)getMoneyType : (MoneyType)type;

+(NSString *)getPayType : (PayType)type;

+(NSString *)getCashApplicationStatus : (CashApplicationStatus)type;

+(NSMutableArray *)getData;

+(NSMutableArray *)getTitleContentData : (AccessGoldModel *)model;

@end
