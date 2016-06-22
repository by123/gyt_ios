//
//  TimeView.h
//  gyt
//
//  Created by by.huang on 16/6/12.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TimeViewDelegate <NSObject>

@optional -(void)OnTimeSelect : (NSInteger)position;

@end

@interface TimeView : UIView

@property (strong, nonatomic) id delegate;

@end
