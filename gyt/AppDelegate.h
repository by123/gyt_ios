//
//  AppDelegate.h
//  gyt
//
//  Created by by.huang on 16/4/13.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class GCDAsyncSocket;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    GCDAsyncSocket *asyncSocket;
}

@property (strong, nonatomic) UIWindow *window;

@end

