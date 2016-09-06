//
//  PreConditionView.h
//  gyt
//
//  Created by by.huang on 16/8/31.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PushModel.h"
#import "ByListDialog.h"
#import "AddReduceView.h"

@interface PreConditionView : UIView<ListDialogDelegate,AddReduceViewDelegate>

@property (strong, nonatomic) PushModel *model;

@property (strong, nonatomic) UIView *rootView;

-(instancetype)initWithData : (PushModel *)model
                       view : (UIView *)rootView;

-(void)updatePushData : (PushModel *)pushModel;

@end
