//
//  kLinePage.m
//  gyt
//
//  Created by by.huang on 16/4/13.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "kLinePage.h"

@interface kLinePage ()

@property(strong, nonatomic) KMapView *kMapView;
@property(strong, nonatomic) NSMutableArray *array1;
@property(strong, nonatomic) NSMutableArray *array2;
@property(strong, nonatomic) NSMutableArray *array3;
@property(assign, nonatomic) CGFloat data;

@end

@implementation kLinePage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)initView
{
    _kMapView = [[KMapView alloc] init];
    _kMapView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _kMapView.xAxisLbArr = @[@"1",@"2",@"3",@"4",@"5"];
    _kMapView.yAxisLbArr = @[@"5",@"4",@"3",@"2",@"1"];
    _kMapView.needToDrawRightAxisLb = YES;
    _kMapView.showLastValue = NO;
    _kMapView.kMapViewDataSource = self;
    _kMapView.delegate = self;
    [self.view addSubview:_kMapView];
    
    _array1 = [[NSMutableArray alloc] init];
    _array2 = [[NSMutableArray alloc] init];
    _array3 = [[NSMutableArray alloc] init];
    
    _data = 2.0f;
    [_array3 addObject:[NSNumber numberWithFloat:_data]];
    for (int i = 0; i< 50; i ++) {
        CGFloat offset = (random()%100 - 50)/100.0f;
        [_array1 addObject:[NSNumber numberWithFloat:offset]];
        _data += offset;
        [_array3 addObject:[NSNumber numberWithFloat:_data]];
        offset = (random()%100)/300.0f;
        [_array2 addObject:[NSNumber numberWithFloat:offset]];
        
    }

}


//点的总数
- (NSInteger)summationOfkPointForKMapView:(KMapView*)kMapView{
    return 50;
}
//需要绘制的点的数量
- (NSInteger)numberOfkPointToDrawForKMapView:(KMapView*)kMapView{
    return 50;
}
//需要绘制的点
- (KMapPointView *)kMapView:(KMapView*)kMapView kMapPointViewAtIndex:(NSInteger)index{
    
    
    CGFloat start = [_array3[index] floatValue];
    CGFloat end = start + [_array1[index] floatValue];
    CGFloat max = start + [_array2[index] floatValue];
    CGFloat min = end - [_array2[49 - index] floatValue];
    if(start < end){
        max = end + [_array2[index] floatValue];
        min = start - [_array2[49 - index] floatValue];
    }
    
    
    KMapPointView *view = [[KMapPointView alloc] initWithMaxValue:max  MinValue:min  StartValue:start EndValue:end];
    return view;
}
- (NSInteger)offsetOfGridForKMapView:(KMapView *)kMapView{
    return 3;
}
- (NSInteger)numberOfLinesForKMapView:(KMapView*)kMapView{
    return 1;
}
- (UIColor *)kMapView:(KMapView*)kMapView colorsForLinesAtIndex:(NSInteger)index{
    return [UIColor clearColor];
}
- (NSInteger)kMapView:(KMapView*)kMapView summationOfkPointForlinesAtIndex:(NSInteger)index{
    return 50;
}
- (NSInteger)kMapView:(KMapView*)kMapView numberOfkPointToDrawForlinesAtIndex:(NSInteger)index{
    return 50;
}

- (CGFloat )kMapView:(KMapView*)kMapView valueForLinesAtIndexPath:(NSIndexPath *)indexPath{
    
    return [_array3[indexPath.row] floatValue] + [_array1[indexPath.row] floatValue];
}

- (NSString*)linesView:(TSLinesView*)linesView touchLableAtIndex:(NSInteger)index{
    return @"";
}


@end
