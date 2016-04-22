//
//  RightMenuCell.h
//  gyt
//
//  Created by by.huang on 16/4/22.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RightMenuModel.h"

@interface RightMenuCell : UITableViewCell

-(void)setData : (RightMenuModel *)model;

+ (NSString *)identify;

@end
