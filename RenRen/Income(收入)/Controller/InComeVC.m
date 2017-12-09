//
//  InComeVC.m
//  RenRen
//
//  Created by Beyondream on 16/6/15.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "InComeVC.h"
#import "RTLabel.h"
#import "InCashVC.h"
#import "HistoryVC.h"
#import "EarnMoneyVC.h"
#import "MRHomeViewController.h"
#import "RAltView.h"

@interface  InComeVC()<RTLabelDelegate,RAltViewDelegate>

@property(nonatomic,strong)UILabel *moneyLabel;
@property(nonatomic,strong) UIScrollView *scrollView;
@end

@implementation InComeVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self getShowInterface];
    self.navigationController.navigationBarHidden = NO;
    UIButton *fenxiangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    fenxiangBtn.frame = CGRectMake(0, 0, 45, 30);
    NSArray * arr = [NSArray arrayWithObjects:@"人人转",@"轻松转",@"凤凰转",@"万家转",@"家家转",@"全新转",@"全速转",@"全球转",@"天天转", nil];
    NSInteger inde =[DATATYPE integerValue]==0?1:[DATATYPE integerValue];
    DLog(@"inde======%ld",inde);
    [fenxiangBtn setTitle:arr[inde-1] forState:UIControlStateNormal];
    fenxiangBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    //    fenxiangBtn.backgroundColor = [UIColor purpleColor];
    [fenxiangBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:fenxiangBtn];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:self.scrollView];
    if (iPhone4) {
        self.scrollView.contentSize = CGSizeMake(0, 480);
    }
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    [self creatUI];
    
    //增加数据
//    [self initWithRequestData];
}

-(void)creatUI
{
    UILabel *accountlabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-100*SCREEN_POINT, 10, 200*SCREEN_POINT, 30)];
    accountlabel.text = @"账户余额(元)";
    accountlabel.textColor = CUSTOMERCLOCR;
    accountlabel.textAlignment = NSTextAlignmentCenter;
    accountlabel.font = Font(15);
    [self.scrollView addSubview:accountlabel];
    
    self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-100*SCREEN_POINT, accountlabel.maxY, 200*SCREEN_POINT, 30*SCREEN_POINT)];
    self.moneyLabel.textColor = [UIColor redColor];
    self.moneyLabel.textAlignment = NSTextAlignmentCenter;
    self.moneyLabel.font = Font(28);
    [self.scrollView addSubview:self.moneyLabel];

    UIButton *incomeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [incomeBtn setTitle:@"收入记录 >" forState:UIControlStateNormal];
    [incomeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    incomeBtn.frame = CGRectMake(25, self.moneyLabel.maxY+5*SCREEN_POINT, SCREEN_WIDTH/2-30, 35);
    [incomeBtn addTarget:self action:@selector(incomeClick:)];
    incomeBtn.userInteractionEnabled = NO;
    incomeBtn.titleLabel.font = Font(15);
    incomeBtn.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    incomeBtn.layer.borderWidth = 0.8f;
    incomeBtn.tag = 1;
    [self.scrollView addSubview:incomeBtn];
    
    UIButton *cashBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cashBtn.userInteractionEnabled = NO;
    cashBtn.frame = CGRectMake(incomeBtn.maxX +10, self.moneyLabel.maxY+5*SCREEN_POINT, SCREEN_WIDTH/2-30, 35);
    cashBtn.titleLabel.font = Font(15);
    [cashBtn setTitle:@"提现记录 >" forState:UIControlStateNormal];
    [cashBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cashBtn.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    [cashBtn addTarget:self action:@selector(cashBtnClick:)];
    cashBtn.layer.borderWidth = 0.8f;
    cashBtn.tag = 2;
    [self.scrollView addSubview:cashBtn];
    //四个展示label
    NSArray *titleArr = [NSArray arrayWithObjects:@"今日收入(元)",@"个人累计(元)",@"昨日收入(元)",@"邀请累计(元)", nil];
    
    //NSMutableArray *contentArr = [NSMutableArray arrayWithObjects:@"￥0.0",@"￥0.0",@"￥0.0",@"￥0.0", nil];
    
    UILabel *lineH = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-0.5, cashBtn.maxY+20, 1, 140)];
    lineH.backgroundColor =UIColorFromRGB(0xe5e5e5);
    [self.scrollView addSubview:lineH];
    
    UILabel *lineW = [[UILabel alloc]initWithFrame:CGRectMake(40, cashBtn.maxY+90, SCREEN_WIDTH-80, 1)];
    lineW .backgroundColor =UIColorFromRGB(0xe5e5e5);
    [self.scrollView addSubview:lineW ];
    
    for (int i = 0; i<titleArr.count; i++)
    {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60+i%2*(SCREEN_WIDTH/2-40), cashBtn.maxY +30 +i/2*(20+50), 100, 20)];
        titleLabel.text = titleArr[i];
        titleLabel.textColor =COLOR_GRAY_;
        titleLabel.font = Font(15);
        [self.scrollView addSubview:titleLabel];
        
        UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabel.minX, titleLabel.maxY, titleLabel.boundsWidth, 35)];
       contentLabel.font = Font(17);
       contentLabel.tag = 10+i;
        if (i>1) {
            contentLabel.textColor = COLOR_888;
        }else
        {
            contentLabel.textColor = CUSTOMERCLOCR;
        }
        [self.scrollView addSubview:contentLabel];
    }
    // 提现按钮

    UIButton *wantBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    wantBtn.frame = CGRectMake(25, lineH.maxY +20*SCREEN_POINT,SCREEN_WIDTH-50, 30*SCREEN_POINT);
    wantBtn.titleLabel.font = Font(17);
    [wantBtn setTitle:@"提现" forState:UIControlStateNormal];
    [wantBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    wantBtn.layer.cornerRadius = 5;
    wantBtn.clipsToBounds = YES;
    [wantBtn addTarget:self action:@selector(wantBtnClick:)];
    wantBtn.backgroundColor = CUSTOMERCLOCR;
    [self.scrollView addSubview:wantBtn];
    
    UILabel *arlLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, wantBtn.maxY+2, wantBtn.boundsWidth, 30)];
    arlLabel.font = Font(15);
    arlLabel.textColor = COLOR_GRAY_;
    arlLabel.text = @"首次提现，账户余额不能低于30元";
    arlLabel.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:arlLabel];
    
    RTLabel * rtLabel = [[RTLabel alloc]initWithFrame:CGRectMake(0, arlLabel.maxY+2, SCREEN_WIDTH, 30)];
    NSString *txt = [NSString stringWithFormat:@"<font face='System' size=15><a href='%@%@'>如何领取红包</a>",moneyUrl,DATATYPE];
    [rtLabel setText:txt];
    rtLabel.delegate = self;
    rtLabel.lineSpacing = 30.0;
    rtLabel.textAlignment = NSTextAlignmentRight;
    [self.scrollView addSubview:rtLabel];
    

}
// 展示接口
-(void)getShowInterface
{
    NSMutableDictionary *dic  =[NSMutableDictionary dictionary];
    
    if ([LWAccountTool account].uid &&[LWAccountTool account].token) {
        [dic setObject:[LWAccountTool account].uid forKey:@"uid"];
        [dic setObject:[LWAccountTool account].token forKey:@"token"];
    }

    [[AFEngine share] requestPostMethodURL:[NSString stringWithFormat:@"%@%@&dataType=%@",BASE_URL,INCOME_DETAIL,DATATYPE] parameters:dic withVC:self success:^(NSURLSessionDataTask *task, id responseObj){
        //数据分别对应 frtodayMoney 个人累计  fryesMoney  邀请累计  shengyu 剩余  todayMoney 今日数据  yesMoney 昨日数据
        
        if (responseObj[@"shengyu"]==nil)
        {
            self.moneyLabel.text =@"0.00";
        }else
        {
        self.moneyLabel.text = [NSString stringWithFormat:@"￥%@ ",responseObj[@"shengyu"]];
            UIButton*btn = (UIButton*)[self.view viewWithTag:1];
            btn.userInteractionEnabled = YES;
            
            UIButton*btn1 = (UIButton*)[self.view viewWithTag:2];
            btn1.userInteractionEnabled = YES;
        }
        
        
        NSString *todayMoneyStr =responseObj[@"todayMoney"];
         NSString *todayMoney = [NSString stringWithFormat:@"%.2f",[todayMoneyStr floatValue]];
        NSString *frtodayMoneyStr =responseObj[@"frtodayMoney"];
        NSString *frtodayMoney = [NSString stringWithFormat:@"%.2f",[frtodayMoneyStr floatValue]];
        NSString *yesMoneyStr =responseObj[@"yesMoney"];
        NSString *yesMoney = [NSString stringWithFormat:@"%.2f",[yesMoneyStr floatValue]];
        NSString *fryesStr =responseObj[@"fryesMoney"];
        NSString *fryesMoney = [NSString stringWithFormat:@"%.2f",[fryesStr floatValue]];
        
        NSArray *arr = [NSArray arrayWithObjects:todayMoney,frtodayMoney,yesMoney,fryesMoney, nil];
        for (int i=0; i<arr.count; i++)
        {
        UILabel *label = (UILabel*)[self.view viewWithTag:10+i];
            NSString *string = arr[i];
            if (string ==nil) {
                label.text = @"0.00";
            }else
            {
              label.text =arr[i];
            }
        }

        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
//收入纪录
-(void)incomeClick:(UIButton*)sender
{
    MRHomeViewController *VC = [[MRHomeViewController alloc]init];
    //HistoryVC *VC = [[HistoryVC alloc]init];

     VC.kindStr = @"收入纪录";
    
    [self.navigationController pushViewController:VC animated:YES];
}
//提现纪录
-(void)cashBtnClick:(UIButton*)sender
{
    HistoryVC *VC = [[HistoryVC alloc]init];

    VC.kindStr = @"提现纪录";

    [self.navigationController pushViewController:VC animated:YES];
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
//提现
-(void)wantBtnClick:(UIButton*)sender
{
    UIAlertController *alt = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *weixinAct = [UIAlertAction actionWithTitle:@"微信红包提现" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        InCashVC *vc = [[InCashVC alloc]init];
        
        vc.leftMoney =[self.moneyLabel.text componentsSeparatedByString:@"￥"][1];
         vc.isWX = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    UIAlertAction *zhifubaoAct = [UIAlertAction actionWithTitle:@"支付宝提现" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        InCashVC *vc = [[InCashVC alloc]init];
        vc.leftMoney =[self.moneyLabel.text componentsSeparatedByString:@"￥"][1];
        vc.isWX = NO;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    UIAlertAction *cancleAct = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alt addAction:weixinAct];
    [alt addAction:zhifubaoAct];
    [alt addAction:cancleAct];
    [self.navigationController presentViewController:alt animated:YES completion:nil];
    
}
//6.15增加
#pragma mark =========== 增加弹出视图 ==============
-(void)initWithRequestData
{
    NSMutableDictionary *dic  = [NSMutableDictionary dictionary];
    if ([LWAccountTool account].uid ) {
        [dic setObject:[LWAccountTool account].uid forKey:@"uid"];
    }

//    __weak typeof(self) weakSelf = self;
    [[AFEngine share] requestGetMethodURL:[NSString stringWithFormat:@"%@%@",GetNotice,DATATYPE] parameters:dic withVC:self success:^(NSURLSessionDataTask *task, id responseObj){
        
       GRLog(@"===========%@",responseObj);
        NSString *datestring = UserDefaultObjectForKey(@"dateTime");
        int Ydate = [RTool timeFromNow:datestring];
        
//            //判断是否超时或者已经登录
            if ([LWAccountTool isLogin]&&[NetHelp isConnectionAvailable]&&Ydate==1)
            {
        RAltView *altView = [RAltView shareInstance];
        altView.delegate = self;
        [altView showTitleWithContent:[NSString stringWithFormat:@"%@",responseObj[@"msg"]] style:RAltViewStyleNotice];
    }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    
    }];
    
}
-(void)rAltView:(RAltView *)altView withDate:(NSString *)dateTime
{
    GRLog(@"----++++++");
    NSString *datestring = [RTool dateToString:[NSDate date]];
    GRLog(@"------%@",datestring);
    UserDefaultSetObjectForKey(datestring, @"dateTime");
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
