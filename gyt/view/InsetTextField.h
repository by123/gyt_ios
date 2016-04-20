//
//  InsetTextField.h
//  gyt
//
//  Created by by.huang on 16/4/18.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InsetTextField : UITextField<UITextFieldDelegate>

@property (assign, nonatomic) BOOL hasTitle;

-(void)setInsetTitle : (NSString *)title
           font : (UIFont *)font;

@end
