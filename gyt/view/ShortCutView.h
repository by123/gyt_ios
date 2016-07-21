//
//  ShortCutView.h
//  gyt
//
//  Created by by.huang on 16/6/17.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PushModel.h"

@interface ShortCutView : UIView<UIAlertViewDelegate,PushDataHandleDelegate>

-(instancetype)initWithView : (UIView *)parentView
model : (PushModel *)model;

-(void)handlePushQuoteData :(PushModel *)pushModel;

@end
