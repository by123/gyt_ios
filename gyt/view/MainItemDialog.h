//
//  MainItemDialog.h
//  gyt
//
//  Created by by.huang on 16/6/8.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductModel.h"

@protocol MainItemDialogDelegate <NSObject>

@required -(void)OnLeftClicked : (ProductModel *)model;

@required -(void)OnRightClicked : (ProductModel *)model;

@end

@interface MainItemDialog : UIView

@property (strong, nonatomic) id delegate;

-(void)updateView : (ProductModel *)model
           height : (CGFloat)height;

@end
