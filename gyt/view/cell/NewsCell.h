//
//  NewsCell.h
//  gyt
//
//  Created by by.huang on 16/4/26.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface NewsCell : UITableViewCell

-(void)setData : (NewsModel *)model;

+(NSString *)identify;

@end
