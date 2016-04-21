//
//  ByNavigationBar.h
//  haihua
//
//  Created by by.huang on 16/3/8.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ByNavigationBarDelegate

@optional -(void)OnLeftClickCallback;

@optional -(void)OnRightClickCallBack : (NSInteger) position;

@optional -(void)OnTitleClick;

@end

@interface ByNavigationBar : UIView

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIButton *leftBtn;

@property (strong, nonatomic) UIButton *rightBtn;

@property (strong, nonatomic) UIButton *titleClickBtn;

@property (strong, nonatomic) UILabel *leftMainLabel;

@property (strong, nonatomic) UILabel *leftSubLabel;

@property (strong, nonatomic) UIButton *rightBtn1;

@property (strong, nonatomic) UIButton *rightBtn2;

@property (strong, nonatomic) UIButton *rightBtn3;

@property (strong, nonatomic) UIButton *rightBtn4;

@property (strong, nonatomic) id delegate;

-(void)setTitle : (NSString *)title;

-(void)setTitleClick : (BOOL)isClick;

-(void)setLeftImage : (UIImage *)image;

-(void)setLeftMainTitle : (NSString *)mainTitle;

-(void)setLeftSubTitle : (NSString *)subTitle;

-(void)setRightBtn1Image : (UIImage *)image;

-(void)setRightBtn2Image : (UIImage *)image;

-(void)setRightBtn3Image : (UIImage *)image;

-(void)setRightBtn4Image : (UIImage *)image;


@end
