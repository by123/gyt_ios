//
//  LeftMenuViewContriller.m
//  gyt
//
//  Created by by.huang on 16/4/14.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "LeftMenuViewContriller.h"
#import "LeftMenuCell.h"
#import "MenuModel.h"
#define Menu_Width SCREEN_WIDTH - 60


@interface LeftMenuViewContriller ()

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UICollectionView *part1CollectView;

@property (strong, nonatomic) UICollectionView *part2CollectView;

@property (strong, nonatomic) UICollectionView *part3CollectView;

@property (strong, nonatomic) UICollectionView *part4CollectView;

@property (strong, nonatomic) NSMutableArray *datas1;

@property (strong, nonatomic) NSMutableArray *datas2;

@property (strong, nonatomic) NSMutableArray *datas3;

@property (strong, nonatomic) NSMutableArray *datas4;

@end

@implementation LeftMenuViewContriller
{
    MenuModel *lastSelectModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}

#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return YES;
}


#pragma mark 初始化组件
-(void)initView
{
    [self initNavigationBar];
    
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.frame = CGRectMake(0, NavigationBar_HEIGHT + StatuBar_HEIGHT, Menu_Width, SCREEN_HEIGHT - (NavigationBar_HEIGHT + StatuBar_HEIGHT));
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    [self initBody];
}

-(void)initNavigationBar
{
    [self showNavigationBar];
    [self.navBar.leftBtn setHidden:YES];
    [self.navBar.rightBtn setHidden:YES];
    UILabel *titleLabel = self.navBar.titleLabel;
    titleLabel.text = @"选择页面";
    float height = titleLabel.contentSize.height;
    titleLabel.frame = CGRectMake(30, StatuBar_HEIGHT + (NavigationBar_HEIGHT - height)/2, SCREEN_WIDTH - 60-60, height);
}

-(void)initBody
{
    UICollectionViewFlowLayout *flowLayout1=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout1 setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    
    _part1CollectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, Menu_Width, 32 * 2 + 10 * 3) collectionViewLayout:flowLayout1];
    _part1CollectView.scrollEnabled = NO;
    _part1CollectView.backgroundColor = LINE_COLOR;
    _part1CollectView.delegate = self;
    _part1CollectView.dataSource = self;
     [_part1CollectView registerClass:[LeftMenuCell class] forCellWithReuseIdentifier:[LeftMenuCell identify]];
    [_scrollView addSubview:_part1CollectView];
    
    
    UICollectionViewFlowLayout *flowLayout2=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout2 setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _part2CollectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, _part1CollectView.height + _part1CollectView.y + 5, Menu_Width, 32 * 4 + 10 * 5) collectionViewLayout:flowLayout2];
    _part2CollectView.scrollEnabled = NO;
    _part2CollectView.backgroundColor = LINE_COLOR;
    _part2CollectView.delegate = self;
    _part2CollectView.dataSource = self;
    [_part2CollectView registerClass:[LeftMenuCell class] forCellWithReuseIdentifier:[LeftMenuCell identify]];
    [_scrollView addSubview:_part2CollectView];
    
    UICollectionViewFlowLayout *flowLayout3=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout3 setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _part3CollectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, _part2CollectView.height + _part2CollectView.y + 5, Menu_Width, 32 * 9 + 10 * 10) collectionViewLayout:flowLayout3];
    _part3CollectView.scrollEnabled = NO;
    _part3CollectView.backgroundColor = LINE_COLOR;
    _part3CollectView.delegate = self;
    _part3CollectView.dataSource = self;
    [_part3CollectView registerClass:[LeftMenuCell class] forCellWithReuseIdentifier:[LeftMenuCell identify]];
    [_scrollView addSubview:_part3CollectView];
    
    UICollectionViewFlowLayout *flowLayout4=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout4 setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _part4CollectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, _part3CollectView.height + _part3CollectView.y + 5, Menu_Width, 32 * 5 + 10 * 6) collectionViewLayout:flowLayout4];
    _part4CollectView.scrollEnabled = NO;
    _part4CollectView.backgroundColor = LINE_COLOR;
    _part4CollectView.delegate = self;
    _part4CollectView.dataSource = self;
    [_part4CollectView registerClass:[LeftMenuCell class] forCellWithReuseIdentifier:[LeftMenuCell identify]];
    [_scrollView addSubview:_part4CollectView];
    
    [_scrollView setContentSize:CGSizeMake(SCREEN_WIDTH - 60, _part4CollectView.height + _part4CollectView.y )];

}


-(void)initData
{
    _datas1 = [MenuModel buildModel1];
    _datas2 = [MenuModel buildModel2];
    _datas3 = [MenuModel buildModel3];
    _datas4 = [MenuModel buildModel4];
    lastSelectModel = ((MenuModel *)[_datas2 objectAtIndex:0]);
    lastSelectModel.isSelected = YES;

}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (!IS_NS_COLLECTION_EMPTY(_datas1) && collectionView == _part1CollectView) {
        return [_datas1 count];
    }
    if (!IS_NS_COLLECTION_EMPTY(_datas2) && collectionView == _part2CollectView) {
        return [_datas2 count];
    }
    if (!IS_NS_COLLECTION_EMPTY(_datas3) && collectionView == _part3CollectView) {
        return [_datas3 count];
    }
    if (!IS_NS_COLLECTION_EMPTY(_datas4) && collectionView == _part4CollectView) {
        return [_datas4 count];
    }
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((SCREEN_WIDTH - 90 ) /2, 32);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10,10,10,10);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(lastSelectModel)
    {
        lastSelectModel.isSelected = NO;
    }
    MenuModel *model;
    if(!IS_NS_COLLECTION_EMPTY(_datas1) && collectionView == _part1CollectView)
    {
        model = [_datas1 objectAtIndex:indexPath.row];
    }
    else if(!IS_NS_COLLECTION_EMPTY(_datas2) && collectionView == _part2CollectView)
    {
         model = [_datas2 objectAtIndex:indexPath.row];
    }
    else if(!IS_NS_COLLECTION_EMPTY(_datas3) && collectionView == _part3CollectView)
    {
         model = [_datas3 objectAtIndex:indexPath.row];
    }
    else if(!IS_NS_COLLECTION_EMPTY(_datas4) && collectionView == _part4CollectView)
    {
         model = [_datas4 objectAtIndex:indexPath.row];
    }
    model.isSelected = YES;
    [_part1CollectView reloadData];
    [_part2CollectView reloadData];
    [_part3CollectView reloadData];
    [_part4CollectView reloadData];

    [[NSNotificationCenter defaultCenter]postNotificationName:Notify_Menu_Title object:model];
    lastSelectModel = model;
    [[SlideNavigationController sharedInstance]leftMenuSelected:nil];

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    LeftMenuCell *cell = (LeftMenuCell *)[collectionView dequeueReusableCellWithReuseIdentifier:[LeftMenuCell identify] forIndexPath:indexPath];
    
    if(!IS_NS_COLLECTION_EMPTY(_datas1) && collectionView == _part1CollectView)
    {
        MenuModel *model = [_datas1 objectAtIndex:indexPath.row];
        [cell setData:model];
    }
    else if(!IS_NS_COLLECTION_EMPTY(_datas2) && collectionView == _part2CollectView)
    {
        MenuModel *model = [_datas2 objectAtIndex:indexPath.row];
        [cell setData:model];
    }
    else if(!IS_NS_COLLECTION_EMPTY(_datas3) && collectionView == _part3CollectView)
    {
        MenuModel *model = [_datas3 objectAtIndex:indexPath.row];
        [cell setData:model];
    }
    else if(!IS_NS_COLLECTION_EMPTY(_datas4) && collectionView == _part4CollectView)
    {
        MenuModel *model = [_datas4 objectAtIndex:indexPath.row];
        [cell setData:model];
    }
    return cell;
}



@end
