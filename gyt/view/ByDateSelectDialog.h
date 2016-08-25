//
//  ByDateSelectDialog.h
//  gyt
//
//  Created by by.huang on 16/8/23.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ByDateSelectDialog.h"


typedef void (^ByDateSelectDialogBlock)(NSString *startDateStr,NSString *endDateStr);

@interface ByDateSelectDialog : NSObject

@property (nonatomic, assign) ByDateSelectDialogBlock block;

-(void)show;

-(void)dismiss;


@end
