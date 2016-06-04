//
//  ByTextField.h
//  gyt
//
//  Created by by.huang on 16/6/4.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CWNumberKeyboard.h"



@interface ByTextField : UIButton<UITextFieldDelegate>

@property (strong, nonatomic) NSString *text;

-(instancetype)initWithType : (ByTextFieldType) type
                      frame : (CGRect)frame
                   rootView : (UIView *)view
                      title : (NSString *)title;


-(void)setTextFiledText : (NSString *)text;

@end
