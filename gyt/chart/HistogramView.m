//
//  HistogramView.m
//  text0301
//
//  Created by HuangZhaoyi on 16/3/3.
//  Copyright © 2016年 HuangZhaoyi. All rights reserved.
//

#import "HistogramView.h"

@implementation HistogramView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)init{
    if ((self = [super init])) {
        offset = 0;
        increaseLayer = [CAShapeLayer layer];
        increaseLayer.fillColor = [UIColor clearColor].CGColor;
        increaseLayer.strokeColor = [UIColor redColor].CGColor;
        [self.layer addSublayer:increaseLayer];
        
        decreaselayer = [CAShapeLayer layer];
        decreaselayer.fillColor = [UIColor clearColor].CGColor;
        decreaselayer.strokeColor = [UIColor greenColor].CGColor;
        [self.layer addSublayer:decreaselayer];
    }
    return self;
}


- (void)initGrid{
    CGFloat baseWidth = CHARTWIDTH /(numberOfXAxisLb - 1);
    if (self.dataSource != nil) {
        if ([self.dataSource respondsToSelector:@selector(offsetOfGridForHistogramView:)]) {
            CGFloat baseDrawWidth = CHARTWIDTH/[self.dataSource summationOfkeyPointForHistogramView:self];
            offset = baseDrawWidth/2 + baseDrawWidth*[self.dataSource offsetOfGridForHistogramView:self];
            if (offset != baseDrawWidth/2) {
                baseWidth = CHARTWIDTH /numberOfXAxisLb;
            }
        }
    }

    CGFloat baseHeight = (CHARTHEIGHT - numberOfYAxisLb +1)/(numberOfYAxisLb -1);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (int i = 0; i<numberOfXAxisLb; i ++) {
        [path moveToPoint:CGPointMake(offset + LBWIDTH + i*baseWidth, 0)];
        [path addLineToPoint:CGPointMake(offset + LBWIDTH + i*baseWidth, CHARTHEIGHT)];
    }
    for (int i = 0; i<numberOfYAxisLb; i ++) {
        [path moveToPoint:CGPointMake(LBWIDTH , i*baseHeight +1)];
        [path addLineToPoint:CGPointMake(CHARTWIDTH + LBWIDTH , i*baseHeight +1)];
    }
    grid.path = path.CGPath;
    
}
- (void)layoutLb{

    CGFloat baseHeight = CHARTHEIGHT/(numberOfYAxisLb -1);
    for(int i = 0;i< numberOfYAxisLb; i++){
        UILabel *lable = _yAxisLbArr[i];
        lable.frame = CGRectMake(0, i*baseHeight -LBHEIGHT/2,LBWIDTH -5 ,LBHEIGHT);
        if (i == 0) {
            lable.frame = CGRectMake(0,  i*baseHeight,LBWIDTH -5 ,LBHEIGHT);
        }
        
    }
    
    
}

- (void)reload{
    if (self.dataSource==nil) {
        return;
    }
    summationOfkeyPoint = [self.dataSource summationOfkeyPointForHistogramView:self];
    NSInteger numberOfPoints = [self.dataSource numberOfkeyPointToDrawForHistogramView:self];
    yValuesArr = [[NSMutableArray alloc] init];
    for (int i = 0; i<numberOfPoints; i++) {
        [yValuesArr addObject:[NSNumber numberWithFloat:[self.dataSource histogramView:self yValueAtIndex:i]]];
    }

    CGFloat baseDrawWidth = CHARTWIDTH/[self.dataSource summationOfkeyPointForHistogramView:self];
    CGFloat lineWidth = MIN(baseDrawWidth, 4);
    increaseLayer.lineWidth = lineWidth;
    decreaselayer.lineWidth = lineWidth;
    
    UIBezierPath *increasePath = [UIBezierPath bezierPath];
    UIBezierPath *decreasePath = [UIBezierPath bezierPath];
    
    for (int i = 0; i < numberOfPoints; i++) {
        CGFloat y = [yValuesArr[i] floatValue];
        if (y>0) {
            [increasePath moveToPoint:CGPointMake(i*baseDrawWidth + baseDrawWidth/2 + LBWIDTH, CHARTHEIGHT)];
            [increasePath addLineToPoint:CGPointMake(i*baseDrawWidth + baseDrawWidth/2 + LBWIDTH, [self yPositionWithyValue:yValuesArr[i]])];
        }
        else{
            [decreasePath moveToPoint:CGPointMake(i*baseDrawWidth + baseDrawWidth/2 + LBWIDTH, CHARTHEIGHT)];
            [decreasePath addLineToPoint:CGPointMake(i*baseDrawWidth + baseDrawWidth/2 + LBWIDTH, [self yPositionWithyValue:yValuesArr[i]])];
        }
        
    }
    increaseLayer.path = increasePath.CGPath;
    decreaselayer.path = decreasePath.CGPath;
}
- (void)setYAxisLbArr:(NSArray *)yAxisLbArr{
    if (numberOfYAxisLb != yAxisLbArr.count) {
        
        numberOfYAxisLb = yAxisLbArr.count;
    }
    
    for(UILabel *lable in _yAxisLbArr){
        [lable removeFromSuperview];
    }
    [_yAxisLbArr removeAllObjects];
    
    
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

    maxValue = [[yAxisLbArr firstObject] floatValue];
    minValue = [[yAxisLbArr lastObject] floatValue];
}
- (void)setXAxisLbArr:(NSArray *)xAxisLbArr{
    if(numberOfXAxisLb != xAxisLbArr.count){
        numberOfXAxisLb = xAxisLbArr.count;
    }
}
- (CGFloat)yPositionWithyValue:(NSNumber*)yValue{
    CGFloat y = [yValue floatValue];
    y = ABS(y);
    CGFloat baseHeight = CHARTHEIGHT/(maxValue - minValue);
    return CHARTHEIGHT - (y - minValue)*baseHeight;
}

@end
