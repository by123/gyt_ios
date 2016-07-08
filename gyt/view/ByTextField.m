//
//  ByTextField.m
//  gyt
//
//  Created by by.huang on 16/6/4.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "ByTextField.h"

@interface ByTextField()

@property (assign , nonatomic) ByTextFieldType type;

@property (strong, nonatomic) UIView *rootView;

@property (strong, nonatomic) UILabel *mTitleLabel;

@property (strong, nonatomic) UITextField *mTextField;

@property (copy, nonatomic) NSString *title;


@end

@implementation ByTextField

-(instancetype)initWithType : (ByTextFieldType) type
                      frame : (CGRect)frame
                   rootView : (UIView *)view
                      title :(NSString *)title
{
    if(self == [super initWithFrame:frame])
    {
        self.type = type;
        self.rootView = view;
        self.title = title;
        [self initView];
    }
    return self;
}

-(void)initView
{
    self.layer.borderColor = [[UIColor blackColor] CGColor];
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = 2;
    self.layer.masksToBounds = YES;
    
    
    _mTitleLabel = [[UILabel alloc]init];
    _mTitleLabel.font = [UIFont systemFontOfSize:13.0f];
    _mTitleLabel.textColor = TEXT_COLOR;
    _mTitleLabel.text = _title;
    _mTitleLabel.textAlignment = NSTextAlignmentCenter;
    _mTitleLabel.frame = CGRectMake(5,0, _mTitleLabel.contentSize.width, self.frame.size.height);
    [self addSubview:_mTitleLabel];
    
    _mTextField = [[UITextField alloc]init];
    _mTextField.textColor = TEXT_COLOR;
    _mTextField.font = [UIFont systemFontOfSize:13.0f];
    _mTextField.textAlignment = NSTextAlignmentRight;
    _mTextField.frame = CGRectMake(_mTitleLabel.contentSize.width +  10, 0, self.frame.size.width - 15 -_mTitleLabel.contentSize.width , self.frame.size.height);
    _mTextField.inputView = [[UIView alloc] initWithFrame:CGRectZero];
    _mTextField.delegate = self;
    [self addSubview:_mTextField];
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(_block)
    {
        _block(NO,textField.text);
    }
    self.layer.borderColor = [SELECT_COLOR CGColor];
    [self openKeyboard];
}

-(void)openKeyboard
{
    CWNumberKeyboard *keyboard = [[CWNumberKeyboard alloc]init];
    [keyboard setKeybordRType:_type];
    [_rootView addSubview:keyboard];
    
    [keyboard setHidden:NO];
    [keyboard showNumKeyboardViewAnimateWithPrice:_mTextField.text andBlock:^(NSString *priceString) {
        self.layer.borderColor = [[UIColor blackColor] CGColor];
        if(!IS_NS_STRING_EMPTY(priceString))
        {
            _mTextField.text = priceString;
        }
        
        if(_block)
        {
            _block(YES,_mTextField.text);
        }

    }];
}

-(void)setTextFiledText : (NSString *)text
{
    _mTextField.text = text;
}

-(NSString *)getTextFieldText
{
    return _mTextField.text;
}

-(void)becomeFocus
{
    [self textFieldDidBeginEditing : _mTextField];
}

@end
