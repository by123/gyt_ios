//
//  KLineModel.h
//  gyt
//
//  Created by by.huang on 16/6/29.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLineModel : NSObject

@property (assign, nonatomic) int m_date;

@property (assign, nonatomic) int m_time;

@property (assign, nonatomic) double m_dOpen;

@property (assign, nonatomic) double m_dHigh;

@property (assign, nonatomic) double m_dClose;

@property (assign, nonatomic) double m_dLow;

@property (assign, nonatomic) int m_nVolume;

@property (assign, nonatomic) int m_dOpenInterest;
@end
