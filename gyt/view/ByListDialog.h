//
//  ByListDialog.h
//  gyt
//
//  Created by by.huang on 16/5/17.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ListDialogDelegate

@optional -(void)OnListDialogItemClick : (id)data;

@end

@interface ByListDialog : UIView<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) id delegate;

-(instancetype)initWithData : (NSMutableArray *)array;

@end
