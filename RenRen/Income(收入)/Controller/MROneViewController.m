//
//  MROneViewController.m
//  RenRen
//
//  Created by Beyondream on 16/7/6.
//  Copyright © 2016年 Beyondream. All rights reserved.
//
#import "MROneViewController.h"
#import "HistoryCell.h"
#import "History.h"
#import "RTLabel.h"
#import "EarnMoneyVC.h"
#import "RAltView.h"
@interface MROneViewController ()<UITableViewDelegate,UITableViewDataSource,RTLabelDelegate>
@property (nonatomic, strong) NSMutableArray *dataList;//存储文章列表
@property(nonatomic,strong)UILabel *nonelabel;
@end

@implementation MROneViewController

static NSString *indentifer = @"cell";
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
//    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestToGetData];
    // 设置背景色
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatUI];
}
-(void)creatUI
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[HistoryCell class] forCellReuseIdentifier:indentifer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //如何领取红包
    UIView*head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    head.backgroundColor = [UIColor whiteColor];
    head.tag = 50;
    RTLabel * rtLabel = [[RTLabel alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 30)];
    NSString *txt = [NSString stringWithFormat:@"<font face='System' size=15><a href='www.baidu.com'>如何领取红包</a>"];
    [rtLabel setText:txt];
    rtLabel.delegate = self;
    rtLabel.lineSpacing = 30.0;
    rtLabel.textAlignment = NSTextAlignmentRight;
    [head addSubview:rtLabel];
    return head;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *foot = [[UIView alloc]initWithFrame:CGRectZero];
    return foot;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataList.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
    if (!cell) {
        cell = [[HistoryCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifer];
    }
    History *history = self.dataList[indexPath.row];
    cell.moneyLabel.text = [NSString stringWithFormat:@"+%@",history.money];
    cell.title.text = history.title;
    cell.readtime.text = history.readtime;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
}
-(void)requestToGetData
{
    NSMutableDictionary *dic  =[NSMutableDictionary dictionary];
    
    
    if ([LWAccountTool account].uid &&[LWAccountTool account].token) {
        [dic setObject:[LWAccountTool account].uid forKey:@"uid"];
        [dic setObject:[LWAccountTool account].token forKey:@"token"];
    }
    NSString *url =[self.title isEqual:@"分享收益明细"]?INCASH_RECORD:Heigh_Detail;
    [[AFEngine share] requestPostMethodURL:[NSString stringWithFormat:@"%@%@&dataType=%@",BASE_URL,url,DATATYPE] parameters:dic withVC:self success:^(NSURLSessionDataTask *task, id responseObj){
        
        NSArray *respDataArr = responseObj[@"detail"];
        
        [_dataList removeAllObjects];
        
        _dataList =[History mj_objectArrayWithKeyValuesArray:respDataArr];
        
        if (respDataArr.count==1||respDataArr.count==0)
        {
            if ([self.kindStr isEqual:@"收入纪录"]&&respDataArr.count==1)
            {
                History *his = _dataList[0];
                if ([his.money isEqualToString:@""]){
                    [_dataList removeAllObjects];
                    [self setupnonelabel];
                } else if ([self.kindStr isEqual:@"收入纪录"]&&respDataArr.count==0)
                {
                    [_dataList removeAllObjects];
                    [self setupnonelabel];
                }
                else
                {
                    self.view.backgroundColor = [UIColor whiteColor];
                }
            }else
            {
                if (!respDataArr.count) {
                    [_dataList removeAllObjects];
                    [self setupnonelabel];
                }else
                {
                    self.view.backgroundColor = [UIColor whiteColor];
                }
            }
        }else
        {
            
            self.view.backgroundColor = [UIColor whiteColor];
            
        }
        UIView*head = (UIView*)[self.view viewWithTag:50];
        head.hidden = NO;
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        UIView*head = (UIView*)[self.view viewWithTag:50];
        head.hidden = YES;
        UIImageView*imghold = [RTool setViewPlaceHoldImage:SCREEN_HEIGHT/2-150 WithBgView:self.view];
        imghold.userInteractionEnabled = YES;
        UILabel *clickLabel = [imghold viewWithTag:100];
        clickLabel.userInteractionEnabled = YES;
        [clickLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loadData:)]];
    }];
    
}
//勿网状态重新加载
-(void)loadData:(UIGestureRecognizer*)gesture
{
    if (![NetHelp isConnectionAvailable]) {
        return;
    }
    UIImageView*bgimg =(UIImageView*)gesture.view;
    UIImageView *bg = (UIImageView*)bgimg.superview;
    [bg removeFromSuperview];
    [bgimg removeFromSuperview];
    
    UIView*head = (UIView*)[self.view viewWithTag:50];
    head.hidden = NO;
    bgimg = nil;
    [self requestToGetData];
}

-(NSMutableArray*)dataList
{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

-(void)setupnonelabel
{
    if (!_nonelabel) {
        _nonelabel = [[UILabel alloc]initWithFrame:CGRectMake(100, SCREEN_WIDTH/2+50, SCREEN_WIDTH-200, 30)];
        _nonelabel.textAlignment = NSTextAlignmentCenter;
        _nonelabel.font = Font(17);
        _nonelabel.textColor = COLOR_GRAY_;
    }
    _nonelabel.text = [NSString stringWithFormat:@"没有收入记录"];
    [self.view addSubview:_nonelabel];
    
}
//富文本delegate
-(void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL *)url
{
    DLog(@"url=====%@",url);
    NSString *urlstring =[NSString stringWithFormat:@"%@%@",moneyUrl,DATATYPE];
    EarnMoneyVC *VC = [[EarnMoneyVC alloc]init];
    VC.linkUrl = [NSURL URLWithString:urlstring];
    [self.navigationController pushViewController:VC animated:YES];
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
