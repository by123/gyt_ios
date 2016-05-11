//
//  InsetTextField.h
//  gyt
//
//  Created by by.huang on 16/4/18.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InsetTextField : UITextField<UITextFieldDelegate>

typedef void (^InsetTextFieldBlock)(InsetTextField *insetTextField);

@property (assign, nonatomic) BOOL hasTitle;

@property (strong, nonatomic) InsetTextFieldBlock block;


-(void)setInsetTitle : (NSString *)title
           font : (UIFont *)font;

-(void)setInsetImage : (UIImage *)image;

@end
