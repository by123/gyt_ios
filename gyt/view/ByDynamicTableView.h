//
//  ByTableView.h
//  gyt
//
//  Created by by.huang on 16/4/19.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ByDynamicTableViewDelegate

@optional -(void)OnItemSelected : (UIView *)dynamicTableView
                       position : (NSInteger)position;

@end

@interface ByDynamicTableView : UIView<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

typedef NS_ENUM(NSInteger, DealType) {
    //持仓
    Hold,
    //挂单
    Holding,
    //委托
    HoldBy,
    //成交
    Profit,
    //价格预警
    Warn
};


//是否需要扩展长度
@property (assign, nonatomic) int maxWidth;

@property (assign, nonatomic) DealType type;

@property (strong, nonatomic) id delegate;

-(instancetype)initWithData : (CGRect)rect
                      array : (NSMutableArray *)array
                     maxWidth : (int) maxWidth
                       type : (DealType)type;

-(void)setHeaders : (NSArray *)widths
          headers : (NSArray *)headers;

-(void)reloadData : (NSMutableArray *)array;


@end
