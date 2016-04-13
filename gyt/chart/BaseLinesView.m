//
//  TSLinesView.m
//  text0301
//
//  Created by HuangZhaoyi on 16/3/1.
//  Copyright © 2016年 HuangZhaoyi. All rights reserved.
//

#import "BaseLinesView.h"


@implementation BaseLinesView
@synthesize needToDrawRightAxisLb;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.*/
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    
//}

- (id)init{
    if ((self = [super init])) {
       
        grid = [CAShapeLayer layer];
        grid.lineWidth = 1;
        grid.strokeColor = [UIColor grayColor].CGColor;
        grid.fillColor = [UIColor clearColor].CGColor;
        grid.lineDashPattern = @[@5,@3];
        [self.layer addSublayer:grid];
        
        rim = [CAShapeLayer layer];
        rim.lineWidth = 1;
        rim.strokeColor = [UIColor grayColor].CGColor;
        rim.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:rim];
//        [self initRim];
        _xAxisLbArr = [[NSMutableArray alloc] init];
        _yAxisLbArr = [[NSMutableArray alloc] init];
        _rAxisLbArr = [[NSMutableArray alloc] init];
       
        self.backgroundColor = [UIColor colorWithRed:23/255.0f green:29/255.0f blue:42/255.0f alpha:1];
        
        xDirectrix = [[UIView alloc] initWithFrame:CGRectZero];
        xDirectrix.hidden = YES;
        xDirectrix.backgroundColor = [UIColor whiteColor];
        xDirectrix.alpha = .5f;
        [self addSubview:xDirectrix];
        yDirectrix = [[UIView alloc] initWithFrame:CGRectZero];
        yDirectrix.hidden = YES;
        yDirectrix.backgroundColor = [UIColor whiteColor];
        yDirectrix.alpha = .5f;
        [self addSubview:yDirectrix];
    }
    return self;
}
- (void)layoutSubviews{
    //增减subView不重绘边框
    if (numberOfSubViews != self.subviews.count) {
        numberOfSubViews = self.subviews.count;
    }
    else{
        [self initParams];
        [self initRim];
        [self initGrid];
        [self layoutLb];
        [self reload];
        
    }
}
- (void)initParams{
    LBWIDTH = self.frame.size.width/10 ;
    LBHEIGHT = 20;
    if (self.needToDrawRightAxisLb) {
        CHARTWIDTH = self.frame.size.width - LBWIDTH*2;
    }
    else{
        CHARTWIDTH = self.frame.size.width - LBWIDTH*1.5;
    }
    
    CHARTHEIGHT = self.frame.size.height - LBHEIGHT;
    

}
- (void)initRim{

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(LBWIDTH, 1)];
    [path addLineToPoint:CGPointMake(LBWIDTH + CHARTWIDTH, 1)];
    [path addLineToPoint:CGPointMake(LBWIDTH + CHARTWIDTH, CHARTHEIGHT -1)];
    [path addLineToPoint:CGPointMake(LBWIDTH, CHARTHEIGHT-1)];
    [path closePath];
    rim.path = path.CGPath;
}
- (void)initGrid{

}
- (void)reload{
   
}
- (void)layoutLb{
   
}

- (void)setYAxisLbArr:(NSArray *)yAxisLbArr{
    if (numberOfYAxisLb != yAxisLbArr.count) {
        
        numberOfYAxisLb = yAxisLbArr.count;
    }
    
    for(UILabel *lable in _yAxisLbArr){
        [lable removeFromSuperview];
    }
    [_yAxisLbArr removeAllObjects];
    
    for(UILabel *lable in _rAxisLbArr){
        [lable removeFromSuperview];
    }
    [_rAxisLbArr removeAllObjects];

    
    
    for(int i = 0; i< yAxisLbArr.count;i++){
        NSString *str = yAxisLbArr[i];
        
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
        lable.text = str;
        lable.textColor = [UIColor whiteColor];
        lable.textAlignment = 2;
        lable.font = [UIFont systemFontOfSize:12];
        [self addSubview:lable];
        [_yAxisLbArr addObject:lable];
        if (yAxisLbArr.count == i*2+1) {
            startValue = [str floatValue];
            lable.textColor = [UIColor whiteColor];
        }
    }
    for (int i=0;i< yAxisLbArr.count;i++) {
        NSString *str = yAxisLbArr[i];
        CGFloat value = [str floatValue];
//        if (value > startValue) {
//            value = value/startValue - 1;
//            value *= 100;
//        }
//        else if (value == startValue){
//            value = 0;
//        }
//        else{
//            value = startValue/value - 1;
//            value *= -100;
//
//        }
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
        lable.text = [NSString stringWithFormat:@"%2.2f%%",(value/startValue - 1)*100];
        if (yAxisLbArr.count == i*2+1) {
            lable.textColor = [UIColor whiteColor];
        }
        else if (i*2+1< yAxisLbArr.count-1) {
            lable.textColor = [UIColor redColor];
        }
        else{
            lable.textColor = [UIColor greenColor];
        }

        lable.textAlignment = 0;
        lable.font = [UIFont systemFontOfSize:12];
        [self addSubview:lable];
        [_rAxisLbArr addObject:lable];
        lable.hidden = !needToDrawRightAxisLb;
        
    }
    maxValue = [[yAxisLbArr firstObject] floatValue];
    minValue = [[yAxisLbArr lastObject] floatValue];
}
- (void)setXAxisLbArr:(NSArray *)xAxisLbArr{
    if(numberOfXAxisLb != xAxisLbArr.count){
        numberOfXAxisLb = xAxisLbArr.count;
    }
    for(UILabel *lable in _xAxisLbArr){
        [lable removeFromSuperview];
    }
    [_xAxisLbArr removeAllObjects];
    
    for(int i = 0;i < xAxisLbArr.count ; i++){
        NSString *str = xAxisLbArr[i];
        
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
        lable.text = str;
        lable.textColor = [UIColor whiteColor];
        lable.textAlignment = 1;
        lable.font = [UIFont systemFontOfSize:12];
        [self addSubview:lable];
        [_xAxisLbArr addObject:lable];
    }
}

- (void)setNeedToDrawRightAxisLb:(BOOL)newValue{
    needToDrawRightAxisLb = newValue;
        for(UILabel *lable in _rAxisLbArr){
        lable.hidden = !needToDrawRightAxisLb;
    }
    [self layoutIfNeeded];
}

- (CGFloat)yPositionWithyValue:(NSNumber*)yValue{
    
    return 0;
}
@end
