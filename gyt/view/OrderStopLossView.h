//
//  OrderStopLossView.h
//  gyt
//
//  Created by by.huang on 16/8/29.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PushModel.h"
#import "AddReduceView.h"
@interface OrderStopLossView : UIView<AddReduceViewDelegate>

@property (strong, nonatomic) PushModel *model;

@property (strong, nonatomic) UIView *rootView;

@property (strong, nonatomic) BaseViewController *controller;


-(instancetype)initWithData : (PushModel *)model
                       view : (BaseViewController *)controller;


-(void)setDirector : (EEntrustBS)director;

-(void)updatePushData : (PushModel *)pushModel;

-(void)handleOrderData : (BaseRespondModel *)respondModel;

@end
