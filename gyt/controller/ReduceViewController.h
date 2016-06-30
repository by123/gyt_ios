//  出金界面
//  BaseViewController.h
//  gyt
//
//  Created by by.huang on 16/5/14.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "BaseViewController.h"

@interface ReduceViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,SocketConnectDelegate>

+(void)show : (BaseViewController *)controller;

@end
