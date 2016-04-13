//
//  TSLinesView.h
//  text0301
//
//  Created by HuangZhaoyi on 16/3/1.
//  Copyright © 2016年 HuangZhaoyi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaseLinesView : UIView{
    
    UIView * xDirectrix;
    UIView * yDirectrix;
    BOOL isXDirectrixInCenter;
    
    CAShapeLayer *rim;
    CAShapeLayer *grid;
    
    float maxValue;
    float minValue;
    float startValue;
    
    NSInteger numberOfSubViews;
    NSInteger summationOfkeyPoint;
    
    NSMutableArray *_xAxisLbArr;
    NSMutableArray *_yAxisLbArr;
    NSMutableArray *_rAxisLbArr;
    NSMutableArray *yValuesArr;
    
    NSInteger numberOfYAxisLb;
    NSInteger numberOfXAxisLb;

    CGFloat LBWIDTH;
    CGFloat LBHEIGHT;
    CGFloat EMPTYHEIGHT;
    CGFloat CHARTWIDTH;
    CGFloat CHARTHEIGHT;

    
}
- (id)init;
- (void)initParams;
- (CGFloat)yPositionWithyValue:(NSNumber*)yValue;
- (void)reload;

@property(nonatomic ,copy) NSArray *yAxisLbArr;   //从大到小排序
@property(nonatomic ,copy) NSArray *xAxisLbArr;
@property(nonatomic ,assign) BOOL needToDrawRightAxisLb;

@end
