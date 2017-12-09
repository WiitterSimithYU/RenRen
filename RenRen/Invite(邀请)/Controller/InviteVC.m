//
//  InviteVC.m
//  RenRen
//
//  Created by Beyondream on 16/6/15.
//  Copyright © 2016年 Beyondream. All rights reserved.


#import "InviteVC.h"
#import "InviteFriendVC.h"
#import "ShareView.h"
#import "MoreShareView.h"
#import "CodeShareView.h"
#import "YaoQingModel.h"
#import "RAltView.h"

//#define kFirstV_H  [[UIScreen mainScreen] bounds].size.height * 60/568
//#define kSecond_H  [[UIScreen mainScreen] bounds].size.height *205/568

#define kleftIMG_H  30

@interface InviteVC ()

@property(nonatomic,strong)YaoQingModel *yaoqingModel;

@end

@implementation InviteVC
{
    UIView *firstView;
     UIView *secondView;
    int TAG;//tag传值

}



-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    if (![LWAccountTool account].uid) {
        
    }else{
    [self initWithYaoQingRequest];
    }
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.0];
    
    
    if (![LWAccountTool account].uid) {
    
        
    }else{
        
        [self initCreateUI];
        
        [self daohangBar];
        
        [self initWithYaoQingRequest];

    }
    
}

-(void)daohangBar{
    UIButton *fenxiangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    fenxiangBtn.frame = CGRectMake(0, 0, 45, 30);
    NSArray * arr = [NSArray arrayWithObjects:@"人人转",@"轻松转",@"凤凰转",@"万家转",@"家家转",@"全新转",@"全速转",@"全球转",@"天天转", nil];
    NSInteger inde =[DATATYPE integerValue]==0?1:[DATATYPE integerValue];
    DLog(@"inde======%ld",inde);
    [fenxiangBtn setTitle:arr[inde-1] forState:UIControlStateNormal];
    fenxiangBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    fenxiangBtn.backgroundColor = [UIColor purpleColor];
    [fenxiangBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [fenxiangBtn addTarget:self action:@selector(shuaClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:fenxiangBtn];

}
#pragma mark - 刷新
-(void)shuaClick{
    
    [firstView removeFromSuperview];
    [secondView removeFromSuperview];
    firstView = nil;
    secondView= nil;
    self.yaoqingModel=nil;
    [self initCreateUI];
   //数据刷新
    [self initWithYaoQingRequest];
    
}


-(void)initCreateUI{
//第一底层view
    
    firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 50)];
    firstView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:firstView];
    UIView *fistLine = [[UIView alloc] initWithFrame:CGRectMake(0, firstView.frame.size.height-0.5, SCREEN_WIDTH, 0.5)];
    fistLine.backgroundColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0];
    [firstView addSubview:fistLine];
    
    UIView *fengeView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, 1, firstView.frame.size.height)];
    fengeView.backgroundColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0];
    [firstView addSubview:fengeView];
    
    UILabel *titleFenhong = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 70, 15)];
    titleFenhong.backgroundColor = [UIColor clearColor];
    titleFenhong.text = @"累计分红";
    titleFenhong.font = Font(15);
    [firstView addSubview:titleFenhong];
    
    UILabel *fenhongLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 90, 15)];
    fenhongLab.backgroundColor = [UIColor clearColor];
//    fenhongLab.text = @"￥;
    fenhongLab.text = [NSString stringWithFormat:@"￥%@",self.yaoqingModel.ljfh];
    fenhongLab.font = Font(15);
    fenhongLab.textColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    [firstView addSubview:fenhongLab];
    
    UIImageView *leftIMgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-50 +10, 10, kleftIMG_H+2, kleftIMG_H)];
    leftIMgView.image = [UIImage imageNamed:@"ic_invite_total_dividend"];
    leftIMgView.backgroundColor = [UIColor clearColor];
    [firstView addSubview:leftIMgView];
    
    UILabel *titleFriend = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+20, 10, 75, 15)];
    titleFriend.backgroundColor = [UIColor clearColor];
    titleFriend.text = @"已邀请好友";
    titleFriend.font = Font(15);
    [firstView addSubview:titleFriend];
    
    UILabel *peopleLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+ 20, 30, 70, 15)];
    peopleLab.backgroundColor = [UIColor clearColor];
//    peopleLab.text = @"0人";
    peopleLab.text = [NSString stringWithFormat:@"%@人",self.yaoqingModel.hynum];
    peopleLab.textColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    peopleLab.font = Font(15);
    [firstView addSubview:peopleLab];
    
//跳转邀请好友
    UIImageView *rightIMgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, 10, kleftIMG_H+12, kleftIMG_H)];
    rightIMgView.image = [UIImage imageNamed:@"ic_invite_friend"];
    rightIMgView.userInteractionEnabled = YES;
    rightIMgView.backgroundColor = [UIColor clearColor];
    [firstView addSubview:rightIMgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TAPGRT)];
    [rightIMgView addGestureRecognizer:tap];
    
    
//第二底层 view
   
    secondView = [[UIView alloc] initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH, SCREEN_WIDTH+10)];
    secondView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:secondView];
    
    UIView *seconLINE= [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    seconLINE.backgroundColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0];
    [secondView addSubview:seconLINE];
    
    UIView *secondLine = [[UIView alloc] initWithFrame:CGRectMake(0, secondView.frame.size.height-0.5, SCREEN_WIDTH, 0.5)];
    secondLine.backgroundColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0];
    [secondView addSubview:secondLine];
    
    UIImageView *codeImg = [[UIImageView alloc] initWithFrame:CGRectMake(60, 40, SCREEN_WIDTH -120, SCREEN_WIDTH -120)];
    codeImg.backgroundColor = [UIColor whiteColor];
    codeImg.layer.borderWidth = 1;
    codeImg.layer.borderColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0].CGColor;
    [secondView addSubview:codeImg];
    
    UIImageView *shaoCodeIMg = [[UIImageView alloc] initWithFrame:CGRectMake(10,5, codeImg.frame.size.width-20, codeImg.frame.size.width-20)];
//    shaoCodeIMg.backgroundColor = [UIColor yellowColor];
    [shaoCodeIMg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.yaoqingModel.imgurl]] placeholderImage:nil];
    [codeImg addSubview:shaoCodeIMg];
    
    UILabel *xiecodeLab = [[UILabel alloc] initWithFrame:CGRectMake(54 , codeImg.frame.size.height-25 , codeImg.frame.size.width-108, 15)];
    xiecodeLab.text = @"面对面扫码邀请";
    xiecodeLab.textAlignment = NSTextAlignmentCenter;
    xiecodeLab.textColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    xiecodeLab.font = [UIFont systemFontOfSize:13];
    xiecodeLab.backgroundColor = [UIColor clearColor];
    [codeImg addSubview:xiecodeLab];
//注册码
    UILabel *zhucheLab = [[UILabel alloc] initWithFrame:CGRectMake(0, secondView.frame.size.height - 75, SCREEN_WIDTH, 15)];
    zhucheLab.backgroundColor = [UIColor clearColor];
//    zhucheLab.text = @"注册码:1234567";
    zhucheLab.text = [NSString stringWithFormat:@"注册码:%@",[LWAccountTool account].uid];
    zhucheLab.textColor= [UIColor blackColor];
    zhucheLab.textAlignment = NSTextAlignmentCenter;
    zhucheLab.font = Font(13);
    [secondView addSubview:zhucheLab];
    
 //分享好友
    UIButton *fenxiangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    fenxiangBtn.frame = CGRectMake(50, secondView.frame.size.height - 50, SCREEN_WIDTH-100, 30);
    [fenxiangBtn setTitle:@"分享邀请好友" forState:UIControlStateNormal];
    [fenxiangBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    fenxiangBtn.titleLabel.font = Font(18);
    fenxiangBtn.layer.cornerRadius = 15;
    fenxiangBtn.backgroundColor = CUSTOMERCLOCR;
    [fenxiangBtn addTarget:self action:@selector(fenxiangClick)];
    [secondView addSubview:fenxiangBtn];
    
}
//分享邀请好友
-(void)fenxiangClick{

    GRLog(@"1111111111");
    
    ShareView * share = [ShareView creatXib];
    [share setGetTouch:^(int tag)
     {
         [self tiaoZhuan:tag];
     }];
    [share show];
}

-(void)TAPGRT{
    GRLog(@"------oooooo--");
    InviteFriendVC *InviteVC = [[InviteFriendVC alloc] init];
    InviteVC.title = @"邀请的好友";
    [self.navigationController pushViewController:InviteVC animated:YES];
    
}

-(void)tiaoZhuan:(int)tag{

    switch (tag) {
        case 1:
            [self initFenXiang];
            break;
        case 2:
            [self GetCodeShare];
            break;
        case 3:
            [self initfuzhilianjie];
            break;
            
        default:
            break;
    }

}
#pragma mark - 分享
-(void)initFenXiang{

    /**
    使用原始的Safari调用微信
     */
    //要分享的内容，加要一个数组里边，初始化UIActivityViewController

    NSString *copyStr = @"动动手指就赚钱,每天一分钟,一起来赚钱吧,空闲时间点一点,现金红包轻松到手,注册就送1~5元红包.";

    UIImage *copyIMG = [UIImage imageNamed:@"ic_launcher"];
    
//    NSString *COPYString = [NSString stringWithFormat:@"%@%@",copyStr,self.yaoqingModel.linkurl];
    
    NSArray *activityItems = @[copyStr,copyIMG,[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.yaoqingModel.linkurl]]];

    //展示
    [UIActivityViewController showShare:self WithItemArr:activityItems WithActivitiesApp:nil];

}


#pragma mark - 二维码邀请
-(void)GetCodeShare{

    CodeShareView *codeShare = [[CodeShareView alloc] init];
    codeShare.CodeUrl = self.yaoqingModel.imgurl;
    
    
    [self.view addSubview:codeShare];
    

}

#pragma mark - 复制链接
-(void)initfuzhilianjie{

    if ([(NSNull *)self.yaoqingModel.linkurl isEqual:[NSNull null] ]) {
        [MBProgressHUD showMessage:@"复制链接失败!"];
    }else{
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.yaoqingModel.linkurl;
        [MBProgressHUD showMessage:@"复制链接成功!"];
    }

    GRLog(@"----11");
}

#pragma mark - 邀请数据请求
-(void)initWithYaoQingRequest{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    
    GRLog(@"----------->>%@",[LWAccountTool account].uid);
    if (![LWAccountTool account].uid) {
        return;
    }else{
        
        [dic setObject:[LWAccountTool account].uid  forKey:@"uid"];
        [dic setValue:[LWAccountTool account].token forKey:@"token"];
        
    }
    
    GRLog(@"----%@",dic);
    
    [[AFEngine share] POST:[NSString stringWithFormat:@"%@%@&dataType=%@",BASE_URL,GETYqDate,[LWAccountTool account].dataType] parameters:dic  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject)
     {
         
         GRLog(@"Success: %@", responseObject);
         NSString *message =[responseObject objectForKey:@"status"];
         
         if ((NSNull *)message == [NSNull null])
         {
             return ;
         }
         if ([message isEqualToString:@"ok"]) {
             
             NSDictionary *dataDic;
             dataDic=[responseObject objectForKey:@"data"];
  
             self.yaoqingModel = [YaoQingModel mj_objectWithKeyValues:dataDic];
             GRLog(@"00-------%@",self.yaoqingModel);
             
             
             if (self.yaoqingModel) {
                 
             [self initCreateUI];
             }
             
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         GRLog(@"Error: %@", error);
         [MBProgressHUD showMessage:@"网络链接错误!"];

     }];

}

#pragma mark - 名片数据请求
-(void)intiwithMINGPIANRequest{

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    GRLog(@"----------->>%@",[LWAccountTool account].uid);
    if (![LWAccountTool account].uid) {
        return;
    }else{
        
        [dic setObject:[LWAccountTool account].uid  forKey:@"uid"];
        [dic setValue:[LWAccountTool account].token forKey:@"token"];
        
    }
    
    GRLog(@"----%@",dic);
    
    [[AFEngine share] POST:[NSString stringWithFormat:@"%@%@&dataType=%@",BASE_URL,GETYqDate,[LWAccountTool account].dataType] parameters:dic  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject)
     {
         
         GRLog(@"Success: %@", responseObject);
         NSString *message =[responseObject objectForKey:@"status"];
         
         if ((NSNull *)message == [NSNull null])
         {
             return ;
         }
         if ([message isEqualToString:@"ok"]) {
             
             NSDictionary *dataDic;
             dataDic=[responseObject objectForKey:@"data"];
             
             self.yaoqingModel = [YaoQingModel mj_objectWithKeyValues:dataDic];
             GRLog(@"00-------%@",self.yaoqingModel);
             
             
             if (self.yaoqingModel) {
                 
                 [self initCreateUI];
             }
             
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         GRLog(@"Error: %@", error);
         [MBProgressHUD showMessage:@"网络链接错误!"];
         
     }];



}



-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
