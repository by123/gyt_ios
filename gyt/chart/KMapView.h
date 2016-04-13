//
//  KMapView.h
//  text0301
//
//  Created by HuangZhaoyi on 16/3/3.
//  Copyright © 2016年 HuangZhaoyi. All rights reserved.
//

#import "TSLinesView.h"
#import "KMapPointView.h"
@protocol KMapViewDataSource;
@interface KMapView : TSLinesView{
    NSMutableArray *kMapPointArr;
    NSMutableArray *linesArr;
    CGFloat offset;
}

@property (nonatomic, weak) id<KMapViewDataSource>kMapViewDataSource;
@end

@protocol KMapViewDataSource <NSObject>
@required
//点的总数
- (NSInteger)summationOfkPointForKMapView:(KMapView*)kMapView;
//需要绘制的点的数量
- (NSInteger)numberOfkPointToDrawForKMapView:(KMapView*)kMapView;
//需要绘制的点
- (KMapPointView *)kMapView:(KMapView*)kMapView kMapPointViewAtIndex:(NSInteger)index;

@optional
- (NSInteger)offsetOfGridForKMapView:(KMapView*)kMapView;
- (NSInteger)numberOfLinesForKMapView:(KMapView*)kMapView;
- (UIColor *)kMapView:(KMapView*)kMapView colorsForLinesAtIndex:(NSInteger)index;
- (NSInteger)kMapView:(KMapView*)kMapView summationOfkPointForlinesAtIndex:(NSInteger)index;
- (NSInteger)kMapView:(KMapView*)kMapView numberOfkPointToDrawForlinesAtIndex:(NSInteger)index;

- (CGFloat )kMapView:(KMapView*)kMapView valueForLinesAtIndexPath:(NSIndexPath *)indexPath;

@end
