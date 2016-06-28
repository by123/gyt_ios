
//
//  SearchViewController.m
//  gyt
//
//  Created by by.huang on 16/4/27.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "SearchViewController.h"
#import "PushModel.h"
#import "ContractDB.h"
#import "InsetTextField.h"
#import "SearchCell.h"
#import "DetailViewController.h"

#define SearchBar_Height 60

@interface SearchViewController ()

@property (strong, nonatomic) InsetTextField *searchTextField;

@property (strong , nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *datas;

@property (strong, nonatomic) NSMutableArray *searchDatas;

@end

@implementation SearchViewController

+(void)show : (BaseViewController *)controller
      datas : (NSMutableArray *)datas
{
    
    SearchViewController *openController = [[SearchViewController alloc]init];
    openController.datas = datas;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:openController];
    [controller presentViewController:nav animated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _searchDatas = [[ContractDB sharedContractDB] queryAll:DBSearchContractTable];
    [self initView];
}


-(void)initView
{
    self.view.backgroundColor = BACKGROUND_COLOR;
    [self initNavigationBar];
    [self initBody];
}

-(void)initNavigationBar
{
    [self showNavigationBar];
    [self.navBar setTitle:@"搜索"];
    [self.navBar setLeftImage:[UIImage imageNamed:@"ic_close"]];
    [self.navBar.rightBtn setHidden:YES];
    
}

-(void)initBody
{
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    UIView *searchView = [[UIView alloc]init];
    searchView.frame = CGRectMake(0, NavigationBar_HEIGHT + StatuBar_HEIGHT, SCREEN_WIDTH,SearchBar_Height);
    searchView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:searchView];
    
    _searchTextField = [[InsetTextField alloc]initWithFrame:CGRectMake(15, NavigationBar_HEIGHT + StatuBar_HEIGHT +10, SCREEN_WIDTH - 30, SearchBar_Height - 20)];
    _searchTextField.hasTitle = NO;
    [_searchTextField setInsetImage:[UIImage imageNamed:@"ic_search"]];
    _searchTextField.textColor = TEXT_COLOR;
    _searchTextField.returnKeyType = UIReturnKeyDone;
    [_searchTextField addTarget:self action:@selector(onTextChange:)  forControlEvents:UIControlEventAllEditingEvents];
    [self.view addSubview:_searchTextField];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = LINE_COLOR;
    lineView.frame = CGRectMake(0, NavigationBar_HEIGHT + StatuBar_HEIGHT  + SearchBar_Height -0.5, SCREEN_WIDTH, 0.5);
    [self.view addSubview:lineView];
    
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.frame =  CGRectMake(0, NavigationBar_HEIGHT + StatuBar_HEIGHT +SearchBar_Height, SCREEN_WIDTH, SCREEN_HEIGHT - (NavigationBar_HEIGHT + StatuBar_HEIGHT + SearchBar_Height));
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
}

-(void)onTextChange : (id)sender
{
    InsetTextField *textField = sender;
    
    [_searchDatas removeAllObjects];
    for(PushModel *model in _datas)
    {
        if([model.m_strInstrumentID myContainsString:textField.text])
        {
            [_searchDatas addObject:model];
        }
    }
    [_tableView reloadData];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(!IS_NS_COLLECTION_EMPTY(_searchDatas))
    {
        return [_searchDatas count];
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchCell *cell = [[SearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[SearchCell identify]];
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = SELECT_COLOR;
    if(!IS_NS_COLLECTION_EMPTY(_searchDatas))
    {
        PushModel *model = [_searchDatas objectAtIndex:indexPath.row];
        model.m_strExchangeName = model.m_strExchangeName;
        [cell setData:model];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!IS_NS_COLLECTION_EMPTY(_searchDatas))
    {
        PushModel *model = [_searchDatas objectAtIndex:indexPath.row];
        _searchTextField.text = model.m_strInstrumentID;
        [[ContractDB sharedContractDB] insertItem:DBSearchContractTable model:model];
        [_tableView reloadData];
        [DetailViewController show:self datas:_searchDatas position:indexPath.row];
        [_searchTextField resignFirstResponder];
    }
}


-(void)OnLeftClickCallback
{
    [_searchTextField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)OnRightClickCallBack:(NSInteger)position
{}


@end
