//
//  MyContractViewController.h
//  gyt
//
//  Created by by.huang on 16/4/22.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SlideNavigationController.h"
#import "BaseViewController.h"

@interface MyContractViewController : BaseViewController<ByNavigationBarDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,SocketConnectDelegate>

+(void)show : (SlideNavigationController *)controller;

@end
