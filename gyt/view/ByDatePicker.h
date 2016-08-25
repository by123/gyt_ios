//
//  ByDatePicker.h
//  gyt
//
//  Created by by.huang on 16/3/8.
//  Copyright © 2016年 by.huang. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef void(^DatePickerFinishBlock)(NSString *dateString);

@interface ByDatePicker : UIView

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSDate *minimumDate;
@property (nonatomic, strong) NSDate *maximumDate;

- (instancetype)initWithDatePickerMode:(UIDatePickerMode) datePickerMode DateFormatter:(NSString *)dateFormatter datePickerFinishBlock:(DatePickerFinishBlock)datePickerFinishBlock;

- (void)show;

@end
