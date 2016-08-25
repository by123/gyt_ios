//
//  HistoryTradeCell.h
//  gyt
//
//  Created by by.huang on 16/8/25.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HistoryTradeModel.h"
@interface HistoryTradeCell  : UITableViewCell

-(void)setData : (HistoryTradeModel *)model;

+(NSString *)identify;

@end