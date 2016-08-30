//
//  StopLossView.h
//  gyt
//
//  Created by by.huang on 16/8/29.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealHoldModel.h"

@interface StopLossView : UIView

@property (strong, nonatomic) DealHoldModel *model;

@property (strong, nonatomic) UIView *rootView;

-(instancetype)initWithData : (DealHoldModel *)model
                       view : (UIView *)rootView;

@end
