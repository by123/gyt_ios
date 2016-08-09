//
//  HandicapView.h
//  gyt
//
//  Created by by.huang on 16/4/16.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ByTabView.h"
#import "PushModel.h"

#define kTopHeight 35
#define kBottomHeight 40
#define kContentHeight SCREEN_HEIGHT - NavigationBar_HEIGHT - StatuBar_HEIGHT - kTopHeight - kBottomHeight

@interface HandicapView : UIView<UITableViewDelegate,UITableViewDataSource,ByTabViewDelegate>

-(instancetype)initWithData : (PushModel *)model;

-(void)handlePushQuoteData:(PushModel *)pushModel;

@end
