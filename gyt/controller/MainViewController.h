//
//  MainViewController.h
//  gyt
//
//  Created by by.huang on 16/4/14.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "BaseViewController.h"
#import "SlideNavigationController.h"
@interface MainViewController : BaseViewController<SlideNavigationControllerDelegate,ByNavigationBarDelegate,UITableViewDelegate,UITableViewDataSource,SocketConnectDelegate>

@end
