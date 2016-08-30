//
//  StopLossViewController.h
//  gyt
//
//  Created by by.huang on 16/8/26.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "BaseViewController.h"
#import "ByTabView.h"
#import "DealHoldModel.h"

@interface StopLossViewController : BaseViewController<ByTabViewDelegate>

@property (strong, nonatomic) DealHoldModel *model;

+(void)show : (BaseViewController *)controller data: (DealHoldModel *)model;

@end
