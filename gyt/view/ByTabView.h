//
//  ByTabView.h
//  gyt
//
//  Created by by.huang on 16/4/19.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ByTabViewDelegate

@optional -(void)OnSelect : (NSInteger)position;

@end

@interface ByTabView : UIView

@property (strong, nonatomic) id delegate;


-(instancetype)initWithTitles : (CGRect)rect
                         array: (NSArray *)array;

-(void)setCurrent : (NSInteger)position;

@end
