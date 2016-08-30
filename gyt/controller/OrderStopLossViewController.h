//
//  OrderStopLossViewController.h
//  gyt
//
//  Created by by.huang on 16/8/29.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "BaseViewController.h"
#import "ByTabView.h"
#import "PushModel.h"

@interface OrderStopLossViewController : BaseViewController<ByTabViewDelegate>

@property (strong, nonatomic) PushModel *pushModel;

+(void)show : (BaseViewController *)controller
       data : (PushModel *)pushModel;

@end
