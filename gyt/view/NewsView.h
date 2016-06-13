//
//  NewsView.h
//  gyt
//
//  Created by by.huang on 16/4/26.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PushModel.h"

@interface NewsView : UIView<UITableViewDelegate,UITableViewDataSource>

-(instancetype)initWithData : (CGRect)frame
                      model : (PushModel *)model;


@end
