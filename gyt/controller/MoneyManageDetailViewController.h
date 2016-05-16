//
//  MoneyManageDetailViewController.h
//  gyt
//
//  Created by by.huang on 16/5/16.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "BaseViewController.h"
#import "AccessGoldModel.h"

@interface MoneyManageDetailViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

+(void)show : (BaseViewController *)controller
      model : (AccessGoldModel *)model;

@end
