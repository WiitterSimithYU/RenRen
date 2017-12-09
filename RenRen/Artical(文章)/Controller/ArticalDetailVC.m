//
//  ArticalDetailVC.m
//  RenRen
//
//  Created by Beyondream on 16/6/15.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "ArticalDetailVC.h"
#import "ArticalModel.h"
#import "NewsCell.h"
#import "ArticalWebVC.h"
@interface ArticalDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataList;//存储文章列表
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,assign)int pageNum;//页数

@property(nonatomic,assign)int totalNum;//总页数

@end

static NSString *indentifer = @"cell";

@implementation ArticalDetailVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self refreshData];//获取文章信息
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNum = 1;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-49-40) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsHorizontalScrollIndicator = NO;
    [self.tableView flashScrollIndicators];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[NewsCell class] forCellReuseIdentifier:indentifer];
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf refreshData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    [self refreshData];//获取文章信息
    
}
/** 下拉刷新 */
- (void)refreshData
{
    self.pageNum=1;
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    [self.dataList removeAllObjects];
    [self.tableView reloadData];
    [self requsetGetArticalData];//获取文章信息
    [self.tableView.mj_header endRefreshing];
}

/** 上拉加载 */
- (void)loadMoreData
{
    if (self.pageNum>=self.totalNum) {
        [self.tableView.mj_footer setState:MJRefreshStateNoMoreData];
        //  [self.tableView.mj_footer endRefreshing];
        return;
    }else{
        self.pageNum++;
        [self requsetGetArticalData];//获取文章信息
        [self.tableView.mj_footer endRefreshing];
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer ];
    NewsCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[NewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifer];
       
    }
    if (self.dataList.count>0) {
        ArticalModel *model = _dataList[indexPath.row];
        [cell.hdImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:HoldImg];
        //设置行距
        NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:model.title];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:3];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [model.title length])];
        [cell.titleLabel setAttributedText:attributedString];
        
        [cell.titleLabel alignTop];
        if ([model.fee isEqualToString:@""]) {
            cell.earning.hidden = YES;  
            cell.earnTitle.hidden = YES;
        }else{
            cell.earning.text =[NSString stringWithFormat:@"￥%@",model.fee];
            cell.earnTitle.text = model.wz;
            
        }
        
    }
    return cell;
    
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

        ArticalModel *model = _dataList[indexPath.row];
        ArticalWebVC *VC = [[ArticalWebVC alloc]init];
        VC.linkUrl = model.linkUrl;
        VC.imgUrl = model.img;
        VC.titString = model.title;
        [self.navigationController pushViewController:VC animated:YES];

}
/**
 *获取文章信息
 */
-(void)requsetGetArticalData
{
    NSMutableDictionary *dic  =[NSMutableDictionary dictionary];
    DLog(@"--%@-------%@",self.titSting,self.urlString);
    NSArray *titleArr = [NSArray arrayWithObjects:@"热门",@"推荐",@"最新", nil];
    if ([titleArr containsObject:self.titSting]) {
        
        [dic setValue:self.urlString forKey:@"o"];
    }else
    {
        [dic setValue:self.urlString forKey:@"cata"];
    }
    if ([LWAccountTool account].uid ) {
        [dic setObject:[LWAccountTool account].uid forKey:@"uid"];
    }
    [dic setValue:[NSString stringWithFormat:@"%d",self.pageNum] forKey:@"page"];
     __weak typeof(self) weakSelf = self;
    [[AFEngine share] requestPostMethodURL:[NSString stringWithFormat:@"%@%@&dataType=%@",BASE_URL,GET_ART_LIST,DATATYPE] parameters:dic withVC:self success:^(NSURLSessionDataTask *task, id responseObj){
        NSArray *respDataArr = responseObj[@"newsList"];
        self.totalNum = [responseObj[@"pagenum"] intValue];
        NSArray *dataArr = [ArticalModel mj_objectArrayWithKeyValuesArray:respDataArr];
        [_dataList addObjectsFromArray:dataArr];
        [self.tableView reloadData];
        if (self.pageNum>=self.totalNum) {
            [self.tableView.mj_footer setState:MJRefreshStateNoMoreData];
        }else
        {
            [self.tableView.mj_footer setState:MJRefreshStateIdle];
        }
      weakSelf.tableView.hidden = NO;
       weakSelf.tableView.mj_footer.hidden = NO;
        weakSelf.tableView.mj_header.hidden = NO;
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        weakSelf.tableView.hidden = YES;
        weakSelf.tableView.mj_footer.hidden = YES;
        UIImageView*imghold = [RTool setViewPlaceHoldImage:SCREEN_HEIGHT/2-900 WithBgView:self.view];
        imghold.userInteractionEnabled = YES;
        [imghold addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loadData:)]];
    }];
    
}
//勿网状态重新加载
-(void)loadData:(UIGestureRecognizer*)gesture
{
    if (![NetHelp isConnectionAvailable]) {
        return;
    }
    UIImageView*bgimg =(UIImageView*)gesture.view;
    [bgimg removeFromSuperview];
     bgimg = nil;
    [self refreshData];//获取文章信息
}
//初始化
-(NSMutableArray*)dataList
{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
