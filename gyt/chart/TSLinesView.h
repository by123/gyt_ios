//
//  TSLinesView.h
//  text0301
//
//  Created by HuangZhaoyi on 16/3/2.
//  Copyright © 2016年 HuangZhaoyi. All rights reserved.
//

#import "BaseLinesView.h"
@protocol TSLinesViewDataSource;
@protocol TSLinesViewDelegate;
@interface TSLinesView : BaseLinesView{
    CAShapeLayer *chartLine;
    CAShapeLayer *lastValueLine;
       
    UILabel *lastValueLeftLb;
    UILabel *lastValueRightLb;
    
    UILabel *touchValueLeftLb;
    UILabel *touchValueRightLb;
    UILabel *touchxAxisLb;
    
    
}
@property (nonatomic, assign)BOOL showLastValue;

@property (nonatomic, weak) id<TSLinesViewDataSource>dataSource;
@property (nonatomic, weak) id<TSLinesViewDelegate>delegate;

@end
@protocol TSLinesViewDelegate <NSObject>

- (NSString*)linesView:(TSLinesView*)linesView touchLableAtIndex:(NSInteger)index;

@end

@protocol TSLinesViewDataSource <NSObject>
@required
////左轴、右轴lable
//- (NSInteger)numberOfyAxisLBForlinesView:(TSLinesView*)tSLinesView;
//- (NSString*)linesView:(TSLinesView*)linesView leftAxisLbAtIndex:(NSInteger)index;
//- (NSString*)linesView:(TSLinesView*)linesView rightAxisLbAtIndex:(NSInteger)index;
////横轴lable
//- (NSInteger)numberOfxAxisLBForlinesView:(TSLinesView*)tSLinesView;
//- (NSString*)linesView:(TSLinesView*)linesView xAxisLbAtIndex:(NSInteger)index;

//点的总数
- (NSInteger)summationOfkeyPointForlinesView:(TSLinesView*)tSLinesView;
//需要绘制的点的数量
- (NSInteger)numberOfkeyPointToDrawForlinesView:(TSLinesView*)tSLinesView;
//点的纵坐标
- (CGFloat)linesView:(TSLinesView*)linesView yValueAtIndex:(NSInteger)index;

@optional



@end

