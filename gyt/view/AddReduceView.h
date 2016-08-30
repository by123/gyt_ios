//
//  AddReduceView.h
//  gyt
//
//  Created by by.huang on 16/8/30.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ByTextField.h"


@interface AddReduceView : UIView

@property (strong ,nonatomic) id delegate;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) ByTextField *textField;

@property (strong, nonatomic) UIButton *addBtn;

@property (strong, nonatomic) UIButton *reduceBtn;

@property (strong, nonatomic) UILabel *tipsLabel;

-(instancetype)initWithTitle : (NSString *)title
                        type : (ByTextFieldType)type
                         tips: (NSString *)tips
                    rootView : (UIView *)rootView;

-(void)setDefaultValue : (NSString *)value;

-(void)setEnable : (Boolean)enable;

@end

@protocol AddReduceViewDelegate <NSObject>

-(void)addBtnClick : (AddReduceView *)addReduceView;

-(void)reduceBtnClick : (AddReduceView *)addReduceView;

-(void)textFinished : (double)text;


@end