//
//  HistogramView.h
//  text0301
//
//  Created by HuangZhaoyi on 16/3/3.
//  Copyright © 2016年 HuangZhaoyi. All rights reserved.
//

#import "BaseLinesView.h"
@protocol HistogramViewDataSource;
@interface HistogramView : BaseLinesView{
    CGFloat offset;
    CAShapeLayer *increaseLayer;
    CAShapeLayer *decreaselayer;
}

@property(nonatomic ,weak)id<HistogramViewDataSource>dataSource;

@end


@protocol HistogramViewDataSource <NSObject>
@required
//点的总数
- (NSInteger)summationOfkeyPointForHistogramView:(HistogramView*)histogramView;
//需要绘制的点的数量
- (NSInteger)numberOfkeyPointToDrawForHistogramView:(HistogramView*)histogramView;
//点的纵坐标
- (CGFloat)histogramView:(HistogramView*)histogramView yValueAtIndex:(NSInteger)index;

@optional
- (NSInteger)offsetOfGridForHistogramView:(HistogramView*)histogramView;

@end
