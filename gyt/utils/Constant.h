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
#define UserDefault_Password @"password"
#define UserDefault_SavePassword @"savepassword"
#define UserDefault_KTimeLine @"ktimeline"

#pragma mark 广播
#define Notify_Menu_Title @"menu_title"
#define Notify_Update_AccountInfo @"update_accountinfo"
#define Notify_StopLoss @"stoploss"
#define Notify_Condition @"contidion"

#pragma mark 网络请求相关
//#define Root_Url @"http://192.168.1.106:8081" //陈勇

#define Host @"192.168.1.118" //赵杰
#define Port 64360

//#define Host @"192.168.1.106" //陈勇
//#define Port 64360

//#define Host @"192.168.1.112" //何俊森
//#define Port 64360
//id:869785

//#define Host @"192.168.1.109" //
//#define Port 64360

//#define Host @"119.147.47.156" //外网
//#define Port 64350


#define Root_Url @"http://119.147.47.156:8088"

//请求登录
#define Request_Login @"login"
//请求登出
#define Request_Logout @"logout"
//查询账号信息
#define Request_UserInfo @"queryAccountBaseInfo"

#define Info_Net_Error @"网络异常，点击刷新"

#pragma mark 小区信息存储
#define VillageID @"villageId"
#define VillageName @"villageName"
#define MoneyInfo @"moneyInfo"

#define Buy @"买"
#define Sell @"卖"
#define More @"多"
#define Less @"空"

#define PLATFORM_OUTTER_YN_MN  41002  //外盘易盛模拟

//交易端
typedef NS_ENUM(NSInteger, ClientID) {
    ClientID_Mobile_Manage = 3,
    ClientID_Mobile_TRADE = 4
};


//币种
typedef NS_ENUM(NSInteger, EMoneyType) {
    MoneyType_RMB = 0,      //人民币
    MoneyType_USD,          //美元
    MoneyType_HKD,          //港币
    MoneyType_CHF,          //瑞士法郎
    MoneyType_JPY,          //日元
    MoneyType_KRW,          //韩元
    MoneyType_GBP,          //英镑
    MoneyType_RUB,          //卢布
    MoneyType_AUD,          //澳大利亚元
    MoneyType_SGD,          //新币
    MoneyType_EUR,          //欧元
    MoneyType_CAD,          //加拿大元
    MoneyType_NZD,          //新西兰元
};

//买卖方向
typedef NS_ENUM(NSInteger, EEntrustBS) {
    ENTRUST_BUY =  48,    // 买入
    ENTRUST_SELL = 49    // 卖出
};


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

//审核状态
typedef NS_ENUM(NSInteger, CashApplicationStatus) {
    CashApplicationStatus_Submit = 1,    // 等待审核
    CashApplicationStatus_Accepted,     // 通过
    CashApplicationStatus_ForBidden,    // 拒绝
    CashApplicationStatus_Auto         // 自动审核
};


typedef NS_ENUM(NSInteger, DealType) {
    //持仓
    Hold,
    //挂单
    Holding,
    //委托
    HoldBy,
    //成交
    Profit,
    //止盈止损单
    LossStop,
    //条件单
    Condition,
    //预埋单
    Pre,
    //价格预警
    Warning
};

typedef NS_ENUM(NSInteger,CandleType)
{
    KLine,
    TimeLine
};

typedef NS_ENUM(NSInteger, InventoryType) {
    Inventory,
    DailyInventory,
    DealInventory,
};

typedef NS_ENUM(NSInteger, UpdownType) {
    UpdownPrice,
    UpdownPercent,
};

typedef NS_ENUM(NSInteger, ResondType)
{
    GYT_ALIVE = 101,
    GYT_MAINPUSH,
    GYT_LOGIN,
    GYT_ORDER,
    GYT_CANCEL,
    GYT_PUSHDATA,
    GYT_KLINE,
    GYT_CashApplyInfo,
    GYT_CommitCashApplyInfo,
    GYT_QueryHistoryData,
    GYT_DeleteLossData,
    GYT_DeleteAllLossData,
    GYT_StartLossData,
    GYT_PauseLossData,
    GYT_StartAllLossData,
    GYT_PauseAllLossData

};

typedef NS_ENUM(NSInteger, RequestType) {
    XT_121_START = 121 * 100,
    XT_CAccountBaseInfo,
    XT_CLoginParam,
    XT_CTradeLoginParam,
    XT_CLoginResponse,
    XT_CUserInfo,
    XT_CAccountInfo,
    XT_CCashInfo,
    XT_CCashApplyInfo,
    XT_CInstrumentDetail,
    XT_CInstrumentMarginRate,
    XT_CInstrumentCommissionRate,
    XT_CInstrumentFee,
    XT_CQueryDataReq,
    XT_CQueryHistoryDataReq,
    XT_CAccountDetail,//资金信息12115
    XT_CFundFlow,
    XT_COrderDetail, //委托12117
    XT_CDealDetail, //成交12118
    XT_CPositionDetail,//持仓详情12119
    XT_CPositionStatics, //持仓12120
    XT_CLoginInfoLog,
    XT_CProductInfo,
    XT_CTradeTimePair,
    XT_CInstrumentSettlementInfo,
    XT_CQueryMarginInfo,
    XT_CQueryFeeInfo,
    XT_COrderTag,
    XT_COrderInfo,
    XT_COrderResponse,
    XT_CBrokerInfo,
    XT_CQueryBaseSettingReq,
    XT_CPriceData,
    XT_CProxyProfit,
    XT_CWithCapitalInfo,
    XT_CMobileLoginResponse,
    XT_CDealStatics,
    XT_CSettingTemplateInfo,
    XT_TransferResp,
    XT_CancelResp,
    XT_QueryAccountResp,
    XT_QueryInvestorResp,
    XT_QueryBankAmountResp,
    XT_QueryExchangeResp,
    XT_QueryInstrumentResp,
    XT_QueryOrderResp,
    XT_QueryInstrumentMarginRateResp,
    XT_QuerySettlementInfoResp,
    XT_QueryBusinessResp,
    XT_QueryInstrumentCommissionRateResp,
    XT_QueryPositionResp,
    XT_QueryBankResp,
    XT_COrderError,
    XT_CCancelError,
    XT_CStopProfitLossSInfo = 12171,
};


//开平
typedef NS_ENUM(NSInteger , EOffset_Flag_Type)
{
    EOFF_THOST_FTDC_OF_INVALID = -1 ,//未知
    EOFF_THOST_FTDC_OF_Open = 48 ,//开仓
    EOFF_THOST_FTDC_OF_Close = 49 ,//平仓
    EOFF_THOST_FTDC_OF_ForceClose = 50,//强平
    EOFF_THOST_FTDC_OF_CloseToday = 51,//平今
    EOFF_THOST_FTDC_OF_CloseYesterday = 52,//平昨
    EOFF_THOST_FTDC_OF_ForceOff = 53,//强减
    EOFF_THOST_FTDC_OF_LocalForceClose = 54,//本地强平
    EOFF_THOST_FTDC_OF_PLEDGE_IN = 81,//质押入库
    EOFF_THOST_FTDC_OF_PLEDGE_OUT = 66//质押出库
};

//委托属性（市价or限价）
typedef NS_ENUM(NSInteger,EBrokerPriceType)
{
    BROKER_PRICE_ANY = 49, // 市价
    BROKER_PRICE_LIMIT,    // 限价
    BROKER_PRICE_BEST,     // 最优价
    BROKER_PRICE_COMPETE   //对手价
};


//投机
typedef NS_ENUM(NSInteger ,EHedge_Flag_Type)
{
    HEDGE_FLAG_SPECULATION = 49,//投机
    HEDGE_FLAG_ARBITRAGE = 50,//套利
    HEDGE_FLAG_HEDGE = 51//套保
};

typedef NS_ENUM(NSInteger,EFutureTradeType)
{
    FUTRUE_TRADE_TYPE_COMMON = 48, //普通成交
    FUTURE_TRADE_TYPE_OPTIONSEXECUTION, //期权成交ptionsExecution
    FUTURE_TRADE_TYPE_OTC, //OTC成交
    FUTURE_TRADE_TYPE_EFPDIRVED, //期转现衍生成交
    FUTURE_TRADE_TYPE_COMBINATION_DERIVED //组合衍生成交
};


typedef NS_ENUM(NSInteger,EEntrustStatus)
{
    ENTRUST_STATUS_WAIT_END= 0 ,     //委托状态已经在ENTRUST_STATUS_CANCELED或以上，但是成交数额还不够，等成交回报来
    ENTRUST_STATUS_UNREPORTED = 48,  // 未报
    ENTRUST_STATUS_WAIT_REPORTING,   // 待报
    ENTRUST_STATUS_REPORTED,         // 已报
    ENTRUST_STATUS_REPORTED_CANCEL,  // 已报待撤
    ENTRUST_STATUS_PARTSUCC_CANCEL,  // 部成待撤
    ENTRUST_STATUS_PART_CANCEL,      // 部撤
    ENTRUST_STATUS_CANCELED,         // 已撤
    ENTRUST_STATUS_PART_SUCC,        // 部成
    ENTRUST_STATUS_SUCCEEDED,        // 已成
    ENTRUST_STATUS_JUNK,             // 废单
    ENTRUST_STATUS_UNKNOWN           // 未知
};

//委托提交状态（已成，部成，已发，已报，撤单,废除）
typedef NS_ENUM(NSInteger,EEntrustSubmitStatus)
{
    ENTRUST_SUBMIT_STATUS_InsertSubmitted = 48,    // 已经提交
    ENTRUST_SUBMIT_STATUS_CancelSubmitted ,        // 撤单已经提交
    ENTRUST_SUBMIT_STATUS_ModifySubmitted,         // 修改已经提交
    ENTRUST_SUBMIT_STATUS_OSS_Accepted ,           // 已经接受
    ENTRUST_SUBMIT_STATUS_InsertRejected ,         // 报单已经被拒绝
    ENTRUST_SUBMIT_STATUS_CancelRejected,          // 撤单已经被拒绝
    ENTRUST_SUBMIT_STATUS_ModifyRejected           // 改单已经被拒绝
};

typedef NS_ENUM(NSInteger,EXTAccountType)
{
    AT_OUTTER_FUTURE = 1,    // 期货外盘
    AT_OUTBORADSTOCK = 2,    // 外盘股票
    AT_FUTURE = 3,           // 期货账号
    AT_GOLD =  4,            //贵金属账号
    AT_FUTURE_OPTION=5,      // 期货期权账号
    AT_STOCK_OPTION = 6,     // 股票期权账号
    AT_HUGANGTONG = 7,       //沪港通账号
    AT_NEW3BOARD = 10,       // 全国股转账号
    AT_IB = 1002,            // IB
    AT_STOCK = 1003          //股票账号
};


//自定义

typedef NS_ENUM(NSInteger,TipsType)
{
    ConditionTips = 0,
};



//止盈止损运行状态
typedef NS_ENUM(NSInteger,EStopValueStatus)
{
    StopValueStatus_Running = 1,     //运行中
    StopValueStatus_Pause,            //暂停
    StopValueStatus_Trigger,          //已触发
    StopValueStatus_Expiry          //已失效
};

//止盈止损类型
typedef NS_ENUM(NSInteger,EStopType)
{
    StopType_Profit = 1,             //止盈
    StopType_Loss                  //止损
};


@interface Constant : NSObject

+(NSString *)EEntrustBSStr : (EEntrustBS) entrust;

+(NSString *)EHedge_Flag_TypeStr : (EHedge_Flag_Type) flagType;

+(NSString *)EEntrustStatusStr : (EEntrustStatus)statu;

+(NSString *)getCashType : (CashType)type;

+(NSString *)getMoneyType : (int)type;

+(NSString *)getPayType : (PayType)type;

+(NSString *)getCashApplicationStatus : (CashApplicationStatus)type;

+(NSString *)getStopValueStatus : (EStopValueStatus)statu;

+(NSString *)getStopType : (EStopType)type;

+(NSString *)getBrokerPriceType : (EBrokerPriceType)type;

@end

