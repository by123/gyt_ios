//
//  DealByModel.h
//  gyt
//
//  Created by by.huang on 16/4/21.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"
@interface DealHoldByModel : NSObject


//账号信息
@property (strong, nonatomic) UserInfoModel *m_accountInfo;

//交易所ID
@property (copy, nonatomic) NSString *m_strExchangeID;

//交易市场名称
@property (copy, nonatomic) NSString *m_strExchangeName;

//品种代码
@property (copy, nonatomic) NSString *m_strProductID;

//品种名称
@property (copy, nonatomic) NSString *m_strProductName;

//合约ID
@property (copy, nonatomic) NSString *m_strInstrumentID;

//合约名称
@property (copy, nonatomic) NSString *m_strInstrumentName;

//sessionod
@property (assign, nonatomic) double m_nSessionID;

//前端id
@property (assign, nonatomic) double m_nFrontID;

//内部委托号
@property (copy, nonatomic) NSString *m_strOrderRef;

//委托价格(限价单的限价，就是报价)
@property (assign, nonatomic) double m_dLimitPrice;

//最初委托量
@property (assign, nonatomic) double m_nVolumeTotalOriginal;

//m_strOrderSysID:#S| |name=合同编号| isKey = | precision = | flag =  | visible=  | property= | func= | isLog=1 ; //委托号
//m_nOrderStatus:EEntrustStatus=ENTRUST_STATUS_UNKNOWN| |name=委托状态 | isKey = | precision = | flag =  | visible= | property= | func= | isLog=1 ; //委托状态
//m_nDirection:EEntrustBS| |name= | isKey = | precision = | flag =  | visible= | property= | func= ;    //买卖方向
//m_nOrderPriceType:EBrokerPriceType| |name=报价类型 | isKey = | precision = | flag =  | visible=1:0 | property= | func= ; //类型，例如市价单 限价单
//m_strOptName:#S| |name=委托属性 | isKey = | precision = | flag =  | visible=1:0 |property= | func= ; //展示委托属性的中文
//m_nVolumeTraded:#i| |name=成交数量 | isKey = | precision = | flag =  | visible=  | property= | func= | isLog=1 ;//已成交量
//m_nVolumeLeft:#i| |name=剩余委托量 | isKey = | precision = | flag =  | visible= | property= | func= ; //剩余委托量
//m_nVolumeTotal:#i| |name=总委托量 | isKey = | precision = | flag =  | visible= | property= | func= ; //当前总委托量
//m_nErrorID:#i| |name= | isKey = | precision = | flag =  | visible=1:0 | property= | func= ;
//m_strErrorMsg:#S| |name=状态信息 | isKey = | precision = | flag =  | visible= | property= | func= ;
//m_dFrozenMargin:#d=0.0| |name=冻结保证金 | isKey = | precision =2 | flag = | visible=1:0  | property= | func= ; // 冻结保证金
//m_dFrozenCommission:#d=0.0| |name=冻结手续费 | isKey = | precision =2 | flag =  | visible=1:0  | property= | func= | isLog=1; // 冻结手续费
//m_nInsertDate:#i| |name=委托日期 | isKey = | precision = | flag =  | visible=  | property= | func= | isLog=1 | ignore = | updateIgnore=1; //日期
//m_nInsertTime:#i| |name=委托时间 | isKey = | precision = | flag =  | visible= |property= | func= | isLog=1; //时间
//m_dTradedPrice:#d| |name=成交均价 | isKey = | precision =3 | flag =  | visible= | property= | func= | isLog=1 ;//成交均价
//m_dCancelAmount:#i=0| |name=已撤数量 | isKey = | precision =0 | flag =  | visible=1:0  | property=| func= ;
//m_dTradeAmount:#d=0.0| |name=成交金额 | isKey = | precision =2 | flag =FNF_NONE  | visible=1:0 | property=[SUMSTAT,FLASH_CHANGE] | func= ; // 成交额 期货=均价*量*合约乘数
//m_nOffsetFlag:EOffset_Flag_Type| |name=开平 | isKey = | precision = | flag =  | visible= | property= | func=;//期货开平，股票买卖其实就是开平
//m_nHedgeFlag:EHedge_Flag_Type| |name=投保 | isKey = | precision = | flag =  | visible=1:0 | property= | func= ; //投保
//m_nOrderSubmitStatus:EEntrustSubmitStatus| |name=报单状态 | isKey = | precision = | flag =  | visible= | property= | func= ; //提交状态，股票回头想想怎么填 股票里面不需要报单状态
//m_strInsertDate:#S| |name=委托日期 | isKey = | precision = | flag =  | invisible=  | property= | func= | isLog=1 | ignore = | updateIgnore=1; //日期
//m_strInsertTime:#S| |name=委托时间 | isKey = | precision = | flag =  | invisible= |property= | func= | isLog=1; //时间


@end
