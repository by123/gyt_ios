//  https://github.com/zhiyu/chartee/
//
//  Created by zhiyu on 7/11/11.
//  Copyright 2011 zhiyu. All rights reserved.
//

#import "Chart.h"
#import "YAxis.h"
#import "PushModel.h"


typedef NS_ENUM(NSInteger, KTimeLine)
{
    MINITE_LINE = 1,        //1分钟
    THREE_MINITE_LINE,      //3分钟
    FIVE_MINITE_LINE,       //5分钟
    TEN_MINITE_LINE,        //10分钟
    FIFTEEN_MINITE_LINE,    //15分钟
    THIRTY_MINITE_LINE,     //30分钟
    HOUR_LINE,              //1小时
    TWO_HOUR_LINE,          //2小时
    DAY_LINE,               //日
    WEEK_LINE,              //周
    MONTH_LINE              //月
    
};

@interface CandleView : UIView

-(instancetype)initWithType : (CGRect)frame
                      model : (PushModel *)model
                       type : (CandleType)type;

-(void)update : (KTimeLine )kTimeLine;

-(void)OnReceiveSuccess:(id)respondObject;


@end
