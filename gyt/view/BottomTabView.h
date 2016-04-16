//
//  BottomTabView.h
//  gyt
//
//  Created by by.huang on 16/4/16.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BottomModel.h"
#define kBottomHeight 40

@protocol BottomTabViewDelegate

@optional -(void)OnSelectPosition : (NSInteger)position;

@end

@interface BottomTabView : UIView

@property (strong, nonatomic) NSMutableArray *datas;

@property (strong, nonatomic) id delegate;

-(instancetype)initWithData : (NSMutableArray *)datas;

+(BottomModel *)buildModel : (NSString *)title
                     image : (UIImage *)image;
@end
