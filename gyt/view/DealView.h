//
//  DealView.h
//  gyt
//
//  Created by by.huang on 16/4/18.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ByTabView.h"
#import "PushModel.h"
#import "ByDynamicTableView.h"
#import "ByTextField.h"
#import "ByListDialog.h"

@interface DealView : UIView<ByTabViewDelegate,UIAlertViewDelegate,ByDynamicTableViewDelegate,ListDialogDelegate,PushDataHandleDelegate>

@property (strong, nonatomic) BaseViewController *viewController;

-(instancetype)initWithData : (CGRect)frame
                      datas : (NSMutableArray *)datas
                      model : (PushModel *)model
                       view : (UIView *)rootView;

-(void)onRefresh : (UIView *)view;


-(void)handlePositionStaticsData : (BaseRespondModel *)respondModel;

-(void)handleOrderDetailData: (BaseRespondModel *)respondModel;

-(void)handleDealDetailData : (BaseRespondModel *)respondModel;

-(void)handleOrderData : (BaseRespondModel *)respondModel;

-(void)handleCancelData : (BaseRespondModel *)respondModel;

-(void)handlePushData:(PackageModel *)packageModel;

-(void)handlePushQuoteData:(PackageModel *)packageModel;

-(void)handleLossData : (BaseRespondModel *)respondModel;

@end
