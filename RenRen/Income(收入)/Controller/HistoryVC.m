//
//  HistoryVC.m
//  RenRen
//
//  Created by Beyondream on 16/6/21.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "HistoryVC.h"
#import "HistoryCell.h"
#import "History.h"
#import "RTLabel.h"
#import "CashCell.h"
#import "CashModel.h"
#import "EarnMoneyVC.h"
#import "RAltView.h"
@interface HistoryVC ()<UITableViewDelegate,UITableViewDataSource,RTLabelDelegate>
@property (nonatomic, strong) NSMutableArray *dataList;//存储文章列表
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)RTLabel * rtLabel;
@property(nonatomic,strong)UILabel *nonelabel;
@end

@implementation HistoryVC

static NSString *indentifer = @"cell";
static NSString *inden = @"cash";
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if ([self.kindStr isEqual:@"提现纪录"])
    {
        [self requestToGetAlet];

    }
    UIButton *fenxiangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    fenxiangBtn.frame = CGRectMake(0, 0, 45, 30);
    NSArray * arr = [NSArray arrayWithObjects:@"人人转",@"轻松转",@"凤凰转",@"万家转",@"家家转",@"全新转",@"全速转",@"全球转",@"天天转", nil];
    NSInteger inde =[DATATYPE integerValue]==0?1:[DATATYPE integerValue];
    [fenxiangBtn setTitle:arr[inde-1] forState:UIControlStateNormal];
    fenxiangBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [fenxiangBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:fenxiangBtn];
    [self requestToGetData];
    self.navigationController.navigationBarHidden = NO;
    
}

-(void)viewDidLoad
{
    self.view.backgroundColor = UIColorFromRGB(0xEBEBF1);
    self.title = self.kindStr;    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_img"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    backButton.size = CGSizeMake(70, 30);
    // 让按钮的内容往左边偏移10
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    // 让按钮内部的所有内容左对齐
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self creatUI:64];
 
}
-(void)creatUI:(CGFloat)maxy
{
    //如何领取红包
    UIView*head = [[UIView alloc]initWithFrame:CGRectMake(0, maxy, SCREEN_WIDTH, 30)];
    self.rtLabel = [[RTLabel alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 30)];
    NSString *txt = [NSString stringWithFormat:@"<font face='System' size=15><a href='www.baidu.com'>如何领取红包</a>"];
    [_rtLabel setText:txt];
    self.rtLabel.delegate = self;
    self.rtLabel.lineSpacing = 30.0;
    self.rtLabel.textAlignment = NSTextAlignmentRight;
    self.rtLabel.hidden = YES;
    [head addSubview:self.rtLabel];
    [self.view addSubview:head];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, head.maxY, SCREEN_WIDTH, SCREEN_HEIGHT-head.maxY) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsHorizontalScrollIndicator = NO;
    [self.tableView flashScrollIndicators];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[HistoryCell class] forCellReuseIdentifier:indentifer];
    [self.tableView registerClass:[CashCell class] forCellReuseIdentifier:inden];

}
#pragma mark ----delegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [self.kindStr isEqual:@"收入纪录"]?0.1:50;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *head = [[UIView alloc]init];
    if ([self.kindStr isEqual:@"收入纪录"])
    {
        head.frame = CGRectZero;
    }else
    {
        if (![NetHelp isConnectionAvailable]||!self.dataList.count) {
            return nil;
        }
        head.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
        head.backgroundColor = [UIColor whiteColor];
        UILabel*regtimeLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 50)];
        regtimeLab.textAlignment = NSTextAlignmentCenter;
        regtimeLab.text = @"时间";
        regtimeLab.font = [UIFont boldSystemFontOfSize:15];
        [head addSubview:regtimeLab];
        
        UILabel*typeLab =[[UILabel alloc]initWithFrame:CGRectMake(regtimeLab.maxX, 0, 80, 50)];
        typeLab.font = [UIFont boldSystemFontOfSize:15];
        typeLab.text = @"支付类型";
        typeLab.textAlignment = NSTextAlignmentCenter;
        [head addSubview:typeLab];
        
        
        UILabel * moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(typeLab.maxX, 0, 50, 50)];
        moneyLab.font = [UIFont boldSystemFontOfSize:15];
        moneyLab.text = @"余额";
        moneyLab.textAlignment = NSTextAlignmentCenter;
        [head addSubview:moneyLab];
        
        
        UILabel*statusLab = [[UILabel alloc]initWithFrame:CGRectMake(moneyLab.maxX, 0, SCREEN_WIDTH-moneyLab.maxX, 50)];
        statusLab.text = @"状态";
        statusLab.font = [UIFont boldSystemFontOfSize:15];
        statusLab.textAlignment = NSTextAlignmentCenter;
        [head addSubview:statusLab];

        
    }
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
    
    return [self.kindStr isEqual:@"收入纪录"]?80:60;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.kindStr isEqual:@"收入纪录"])
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

    }else
    {
        CashCell *cell = [tableView dequeueReusableCellWithIdentifier:inden];
        if (!cell) {
            cell = [[CashCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:inden];
        }
        CashModel *history = self.dataList[indexPath.row];
        cell.regtimeLab.text = [NSString stringWithFormat:@"+%@",history.regtime];
        cell.typeLab.text = history.type;
        cell.moneyLab.text = history.money;
        cell.statusLab.text = history.status;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }
}
-(void)requestToGetData
{
    NSMutableDictionary *dic  =[NSMutableDictionary dictionary];
    if ([LWAccountTool account].uid &&[LWAccountTool account].token) {
        [dic setObject:[LWAccountTool account].uid forKey:@"uid"];
        [dic setObject:[LWAccountTool account].token forKey:@"token"];
    }
   NSString *urlStr = [self.kindStr isEqual:@"收入纪录"]?INCASH_RECORD:INCOME_RECORD;

    [[AFEngine share] requestPostMethodURL:[NSString stringWithFormat:@"%@%@&dataType=%@",BASE_URL,urlStr,DATATYPE] parameters:dic withVC:self success:^(NSURLSessionDataTask *task, id responseObj){
     
        
        NSArray *respDataArr = [self.kindStr isEqual:@"收入纪录"]?responseObj[@"detail"]:responseObj[@"re"];
        
        [_dataList removeAllObjects];
        
        _dataList = [self.kindStr isEqual:@"收入纪录"]?[History mj_objectArrayWithKeyValuesArray:respDataArr]:[CashModel mj_objectArrayWithKeyValuesArray:respDataArr];
        
        if (respDataArr.count==1||respDataArr.count==0)
        {
            if ([self.kindStr isEqual:@"收入纪录"]&&respDataArr.count==1)
            {
                History *his = _dataList[0];
                if ([his.money isEqualToString:@""]){
                    [_dataList removeAllObjects];
                    [self.view addSubview:_nonelabel];
                } else if ([self.kindStr isEqual:@"收入纪录"]&&respDataArr.count==0)
                {
                    [_dataList removeAllObjects];
                    [self.view addSubview:_nonelabel];
                }
                else
                {
                  self.view.backgroundColor = [UIColor whiteColor];
                }
            }else
            {
                if (!respDataArr.count) {
                     [_dataList removeAllObjects];
                    [self.view addSubview:_nonelabel];
                }else
                {
                    self.view.backgroundColor = [UIColor whiteColor];
                }
            }
        }else
        {

           self.view.backgroundColor = [UIColor whiteColor];

        }
        
        self.rtLabel.hidden = NO;
        [self.tableView reloadData];

        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

        self.rtLabel.hidden = YES;
        UIImageView*imghold = [RTool setViewPlaceHoldImage:SCREEN_HEIGHT/2-50 WithBgView:self.view];
        imghold.userInteractionEnabled = YES;
        UILabel *clickLabel = [imghold viewWithTag:100];
        clickLabel.userInteractionEnabled = YES;
        [clickLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loadData:)]];
    }];

}
-(void)requestToGetAlet
{
    
    [[AFEngine share] requestGetMethodURL:[NSString stringWithFormat:@"%@%@&dataType=%@",BASE_URL,txAlt,DATATYPE] parameters:nil withVC:self success:^(NSURLSessionDataTask *task, id responseObj)
    {
        if ([responseObj[@"status"] isEqualToString:@"ok"])
        {
            [[RAltView shareInstance]showAlt:@"提示" style:RAltViewStyleNormal WithArr:@[responseObj[@"detail"]]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

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
    self.rtLabel.hidden = NO;
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
    _nonelabel.text = [NSString stringWithFormat:@"没有%@",self.kindStr];

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
-(void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
