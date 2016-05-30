//
//  BaseViewController.h
//  haihua
//
//  Created by by.huang on 16/3/8.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ByNavigationBar.h"
#import "TcpClient.h"

@interface BaseViewController : UIViewController<ByNavigationBarDelegate,ITcpClient>


@property (strong, nonatomic) ByNavigationBar *navBar;

-(void)showNavigationBar;

-(void)connect;

-(void)sendData : (NSString *)content;

@end
