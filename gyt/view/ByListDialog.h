//
//  ByListDialog.h
//  gyt
//
//  Created by by.huang on 16/5/17.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ByListDialog : UIView<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) id delegate;

-(instancetype)initWithData : (NSMutableArray *)array
                      title : (NSString *)title;


@end

@protocol ListDialogDelegate

@optional -(void)OnListDialogItemClick : (id)data
                              position : (NSInteger)position
                                dialog : (ByListDialog *)dialog;

@end
