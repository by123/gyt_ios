//
//  LeftMenuCell.h
//  gyt
//
//  Created by by.huang on 16/4/15.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuModel.h"
@interface LeftMenuCell : UICollectionViewCell

-(void)setData : (MenuModel *)model;

+ (NSString *)identify;

@end
