//
//  Chart.h
//  https://github.com/zhiyu/chartee/
//
//  Created by zhiyu on 7/11/11.
//  Copyright 2011 zhiyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAxis.h"
#import "Section.h"
#import "ChartModel.h"
#import "LineChartModel.h"
#import "AreaChartModel.h"
#import "ColumnChartModel.h"
#import "CandleChartModel.h"

@class ChartModel;

@interface Chart : UIView {
	bool  enableSelection;
	bool  isInitialized;
	bool  isSectionInitialized;
	float borderWidth;
	float plotWidth;
	float plotPadding;
	float plotCount;
	float paddingLeft;
	float paddingRight;
	float paddingTop;
	float paddingBottom;
	int   rangeFromY;
	int   rangeToY;
	int   rangeY;
    int   rangeFromX;
    int   rangeToX;
    int   rangeX;
	int   selectedIndex;
	float touchFlag;
	float touchFlagTwo;
	NSMutableArray *padding;
	NSMutableArray *series;
	NSMutableArray *sections;
	NSMutableArray *ratios;
    NSMutableDictionary *models;
	UIColor        *borderColor;
	NSString       *title;
    Boolean showMoveLine;
}

@property (nonatomic)        bool  enableSelection;
@property (nonatomic)        bool  isInitialized;
@property (nonatomic)        bool  isSectionInitialized;
@property (nonatomic)        float borderWidth;
@property (nonatomic)        float plotWidth;
@property (nonatomic)        float plotPadding;
@property (nonatomic)        float plotCount;
@property (nonatomic)        float paddingLeft;
@property (nonatomic)        float paddingRight;
@property (nonatomic)        float paddingTop;
@property (nonatomic)        float paddingBottom;
@property (nonatomic)        int   rangeFromY;
@property (nonatomic)        int   rangeToY;
@property (nonatomic)        int   rangeY;
@property (nonatomic)        int   rangeFromX;
@property (nonatomic)        int   rangeToX;
@property (nonatomic)        int   rangeX;
@property (nonatomic)        int   selectedIndex;
@property (nonatomic)        float touchFlag;
@property (nonatomic)        float touchFlagTwo;
@property (nonatomic,retain) NSMutableArray *padding;
@property (nonatomic,retain) NSMutableArray *series;
@property (nonatomic,retain) NSMutableArray *sections;
@property (nonatomic,retain) NSMutableArray  *ratios;
@property (nonatomic,retain) NSMutableDictionary *models;
@property (nonatomic,retain) UIColor  *borderColor;
@property (nonatomic,retain) NSString *title;
@property (nonatomic)        Boolean showMoveLine;

-(float)getLocalY:(float)val withSection:(int)sectionIndex withAxis:(int)yAxisIndex;
-(void)setSelectedIndexByPoint:(CGPoint) point;
-(void)reset;

/* init */
-(void)initChart;
-(void)initXAxis;
-(void)initYAxis;
-(void)initModels;
-(void)addModel:(ChartModel *)model withName:(NSString *)name;
-(ChartModel *)getModel:(NSString *)name;

/* draw */
-(void)drawChart;
-(void)drawXAxis;
-(void)drawYAxis;
-(void)drawSerie:(NSMutableDictionary *)serie;
-(void)drawLabels;
-(void)setLabel:(NSMutableArray *)label forSerie:(NSMutableDictionary *) serie;

/* data */
-(void)appendToData:(NSArray *)data forName:(NSString *)name;
-(void)clearDataforName:(NSString *)name;
-(void)clearData;
-(void)setData:(NSMutableArray *)data forName:(NSString *)name;

/* category */
-(void)appendToCategory:(NSArray *)category forName:(NSString *)name;
-(void)clearCategoryforName:(NSString *)name;
-(void)clearCategory;
-(void)setCategory:(NSMutableArray *)category forName:(NSString *)name;

/* series */
-(NSMutableDictionary *)getSerie:(NSString *)name;
-(void)addSerie:(NSObject *)serie;

/* section */
-(Section *)getSection:(int) index;
-(int) getIndexOfSection:(CGPoint) point;
-(void)addSection:(NSString *)ratio;
-(void)removeSection:(int)index;
-(void)addSections:(int)num withRatios:(NSArray *)rats;
-(void)removeSections;
-(void)initSections;

/* YAxis */
-(YAxis *)getYAxis:(int) section withIndex:(int) index;
-(void)setValuesForYAxis:(NSDictionary *)serie;

@end
