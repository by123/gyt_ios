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

-(instancetype)initWithData : (CGRect)frame
                      datas : (NSMutableArray *)datas
                      model : (PushModel *)model
                       view : (UIView *)rootView;

-(void)OnReceiveSuccess:(id)respondObject;

@end
