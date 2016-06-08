//
//  MainViewController.h
//  gyt
//
//  Created by by.huang on 16/4/14.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "BaseViewController.h"
#import "SlideNavigationController.h"
#import "MainItemDialog.h"

@interface MainViewController : BaseViewController<ByNavigationBarDelegate,UITableViewDelegate,UITableViewDataSource,SocketConnectDelegate,MainItemDialogDelegate>


+(void)show : (BaseViewController *)controller;

@end
