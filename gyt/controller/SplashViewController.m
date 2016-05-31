//
//  SplashViewController.m
//  gyt
//
//  Created by by.huang on 16/4/26.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "SplashViewController.h"
#import "MainViewController.h"
#import "SlideNavigationController.h"
#import "RightMenuViewController.h"
#import "LeftMenuViewContriller.h"
#import "AppDelegate.h"

@interface SplashViewController ()

@property (strong , nonatomic) UIScrollView *scrollView;

@property (strong , nonatomic) UIPageControl *pageControl;

@property (strong , nonatomic) UIButton *goBtn;

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)initView
{
    
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    NSArray *array = @[@"sp1",@"sp2",@"sp3",@"sp4",@"sp5"];
    for(int i = 0 ; i< [array count] ; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.tag = i;
        imageView.frame = CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        imageView.image = [UIImage imageNamed:[array objectAtIndex:i]];
        [_scrollView addSubview:imageView];
    }
    
    [_scrollView setContentSize:CGSizeMake(SCREEN_WIDTH * [array count], SCREEN_HEIGHT)];
    
    _pageControl = [[UIPageControl alloc]init];
    _pageControl.frame = CGRectMake(0, SCREEN_HEIGHT - 60,SCREEN_WIDTH, 30);
    _pageControl.numberOfPages = 5;
    _pageControl.currentPage = 0;
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.pageIndicatorTintColor = [ColorUtil colorWithHexString:@"#ffffff" alpha:0.3];
    [self.view addSubview:_pageControl];
    
    _goBtn = [[UIButton alloc]init];
    _goBtn.frame = CGRectMake((SCREEN_WIDTH - 120)/2, SCREEN_HEIGHT*2/3, 120, 40);
    _goBtn.layer.masksToBounds = YES;
    _goBtn.layer.cornerRadius = 8;
    _goBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
    _goBtn.layer.borderWidth = 1;
    _goBtn.backgroundColor = [UIColor clearColor];
    [_goBtn setTitle:@"开启" forState:UIControlStateNormal];
    [_goBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _goBtn.titleLabel.font = [UIFont systemFontOfSize:20.0f];
    _goBtn.hidden= YES;
    [self.view addSubview:_goBtn];
    
    [_goBtn addTarget:self action:@selector(goMainViewController) forControlEvents:UIControlEventTouchUpInside];

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int x = scrollView.contentOffset.x;
    int current = x / SCREEN_WIDTH;
    [_pageControl setCurrentPage:current];
    if(current >= 4)
    {
        if(_goBtn.isHidden)
        {
            _goBtn.hidden = NO;
        }
    }
    else
    {
        if(!_goBtn.isHidden)
        {
            _goBtn.hidden = YES;
        }
    }
        
}

-(void)goMainViewController
{
    MainViewController *mainViewController =[[MainViewController alloc]init];
    [self.navigationController pushViewController:mainViewController animated:YES];
    
}

@end
