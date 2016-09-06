//
//  ConditionViewController.h
//  gyt
//
//  Created by by.huang on 16/8/30.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "BaseViewController.h"
#import "PushModel.h"
#import "ByTabView.h"

@interface ConditionViewController : BaseViewController<ByTabViewDelegate>

@property (strong, nonatomic) PushModel *pushModel;

+(void)show : (BaseViewController *)controller
       data : (PushModel *)pushModel;

@end
