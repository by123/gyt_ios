//
//  KMapPointView.h
//  text0301
//
//  Created by HuangZhaoyi on 16/3/3.
//  Copyright © 2016年 HuangZhaoyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KMapPointView : UIView{
    CGFloat maxValue;
    CGFloat minValue;
    CGFloat startValue;
    CGFloat endValue;
    CAShapeLayer *slenderLayer; //细的线
    CAShapeLayer *thickLayer;  //粗的线
}
- (id)initWithMaxValue:(CGFloat)aMaxValue MinValue:(CGFloat)aMinValue StartValue:(CGFloat)aStartValue EndValue:(CGFloat)aEndValue;
- (void)setBaseWidth:(CGFloat)width baseHeight:(CGFloat)height;
- (CGFloat)getValue;
- (BOOL)isIncrease;
@end