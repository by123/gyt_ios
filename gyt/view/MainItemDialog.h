//
//  MainItemDialog.h
//  gyt
//
//  Created by by.huang on 16/6/8.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PushModel.h"

@protocol MainItemDialogDelegate <NSObject>

@required -(void)OnLeftClicked : (PushModel *)model;

@required -(void)OnRightClicked : (PushModel *)model;

@end

@interface MainItemDialog : UIView

@property (strong, nonatomic) id delegate;

-(void)updateView : (PushModel *)model
           height : (CGFloat)height;

@end
