//
//  MoneyManageCell.h
//  gyt
//
//  Created by by.huang on 16/5/16.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccessGoldModel.h"

@interface MoneyManageCell : UITableViewCell

-(void)setData : (AccessGoldModel *)model;

-(void)setRootViewSelect : (BOOL)isSelect;


+(NSString *)identify;

@end
