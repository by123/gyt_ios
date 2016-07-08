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

@optional -(void)OnExpandView : (BOOL)isExpand;

@end

@interface ByDynamicTableView : UIView<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>



//是否需要扩展长度
@property (assign, nonatomic) int maxWidth;

@property (assign, nonatomic) DealType type;

@property (strong, nonatomic) id delegate;

@property (strong, nonatomic) UIView *expandView;

@property (assign, nonatomic) BOOL isExpand;

-(instancetype)initWithData : (CGRect)rect
                      array : (NSMutableArray *)array
                     maxWidth : (int) maxWidth
                       type : (DealType)type;

-(void)setHeaders : (NSArray *)widths
          headers : (NSArray *)headers;

-(void)reloadData : (NSMutableArray *)array
         position : (NSInteger)position;

-(void)reloadOneRow : (NSInteger)position;

//选中
-(void)select : (NSIndexPath *)indexPath;

//不选中
-(void)deSelect;

//关闭展开
-(void)performClose;

@end
