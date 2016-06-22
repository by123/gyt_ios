//  https://github.com/zhiyu/chartee/
//
//  Created by zhiyu on 7/11/11.
//  Copyright 2011 zhiyu. All rights reserved.
//

#import "Chart.h"
#import "YAxis.h"


typedef NS_ENUM(NSInteger, KTimeLine)
{
    One_Minute = 0,        //1分钟
    Three_Minute,          //3分钟
    Five_Minute,           //5分钟
    Ten_Minute,            //10分钟
    Quarter_Hour,          //15分钟
    Half_Hour,             //30分钟
    One_Hour,              //1小时
    Two_Hour,              //2小时
    Three_Hour,            //3小时
    Four_Hour,             //4小时
    Day,                   //日
    Week,                  //周
    Month             //月
};

@interface CandleView : UIView

-(instancetype)initWithType : (CGRect)frame
                       type : (CandleType)type;

-(void)update : (KTimeLine )kTimeLine;

@end
