//
//  SignVC.m
//  RenRen
//
//  Created by Beyondream on 16/6/15.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "SignVC.h"
#import "JLCalendarScrollView.h"
#import "YMOder_TopView.h"
#import "JLCalendar/JLCalendarItem.h"
#import "zhanShiView.h"
#import "signDayModel.h"


#define kqiandaoBtn_D  [[UIScreen mainScreen] bounds].size.height *164/568
#define kqiandaoBtn_H  [[UIScreen mainScreen] bounds].size.height *51/568
static  UIButton *qiandaoBtn;
@interface SignVC ()<UIScrollViewDelegate>
{
    NSString *mouthString;
}

@property(nonatomic,strong) NSString *signday;//签到共计多天
@property(nonatomic,strong) UILabel *QianLab;//签到显示多少天

@property(nonatomic,strong) NSMutableArray *signDataArr;
@property(nonatomic,strong) NSMutableArray *signLastArr;
@property(nonatomic,strong) NSMutableArray* nowMouthArr;
@property(nonatomic,strong) NSMutableArray* lastMouthArr;
@property(nonatomic,strong) NSString *PASS;
@end

@implementation SignVC
{
    UIView *HuadongView;
    JLCalendarScrollView * Calendarview;
    
    UIScrollView *scrollView;
    
    UIButton *qiandaoBtn;
}

//loadVIew加载在self.view前面self.view = nil时候加载
-(void)loadView{
    [super loadView];
 
    [self initWithCreateUI];
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets =NO;
    
    
    //获取当前月
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSMonthCalendarUnit ;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    //月数拼接
    NSString *zeroString = [dateComponent month]<=9?@"0":@"";
    mouthString = [NSString stringWithFormat:@"%@%ld",zeroString,[dateComponent month]];
   
}

//处理视觉落差
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    scrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT -80);
    //获取签到的日历天数
    [self initWithSignCanlender];
    //获取上个月签到
    [self initwithCANSIGNCANLENDR];
   
}
-(void)initWithCreateUI{
    
    //底层scrollview
    scrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0 , 0, SCREEN_WIDTH, SCREEN_HEIGHT-100)];
    scrollView.pagingEnabled =NO;
    scrollView.bounces =NO;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator =NO;
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    scrollView.clipsToBounds = YES;
    scrollView.backgroundColor = [UIColor redColor];
    scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 30, 0);
    [self.view addSubview:scrollView];
    
//底层view

    HuadongView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-20)];
    HuadongView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    [scrollView addSubview:HuadongView];
    
    //顶部导航条
    YMOder_TopView *topMenu = [[YMOder_TopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) selectedItem:^(NSInteger index) {
        NSLog(@"click---------- = %ld",index);
        
        if (index==0) {
            [Calendarview monthOnclick:1];
             Calendarview.signArray = self.nowMouthArr;
            
        }else if(index==1)
        {
            [Calendarview monthOnclick:0];
             Calendarview.signArray = self.lastMouthArr;
            
        }
        
    } ];
    //默认选择就状态

//        [topMenu selectIndex:0];

    topMenu.backgroundColor =[UIColor whiteColor];
    [HuadongView addSubview:topMenu];

    /*-------------------日历---------*/
    Calendarview = [[JLCalendarScrollView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 180)];
    Calendarview.backgroundColor = [UIColor whiteColor];
    
    //设置已经签到的天数日期

    Calendarview.signArray = self.nowMouthArr;
//    Calendarview.passStr = self.PASS;
    [HuadongView addSubview:Calendarview];

    
    
  /*-------------------日历---------*/
    UIView *qianView = [[UIView alloc] initWithFrame:CGRectMake(0, 10+topMenu.frame.size.height+Calendarview.frame.size.height, SCREEN_WIDTH, 30)];
    qianView.backgroundColor= [UIColor whiteColor];
    [HuadongView addSubview:qianView];
 //签到LAB
    self.QianLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0,qianView.frame.size.width ,qianView.frame.size.height )];
    self.QianLab.backgroundColor = [UIColor clearColor];
    
    if (!self.signday) {
        
        NSString *str = [NSString stringWithFormat:@"已经连续签到0天"];
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:str];
        
        [attributeStr addAttribute:NSForegroundColorAttributeName  //文字颜色
                             value:[UIColor colorWithRed:0.f green:129/255.f blue:190/255.f alpha:1.0]
                             range:NSMakeRange(6, 2)];
        [attributeStr addAttribute:NSFontAttributeName value:Font(16) range:NSMakeRange(6, 2)];
        self.QianLab.attributedText = attributeStr;
        
    }else{
    NSString *str = [NSString stringWithFormat:@"已经连续签到%@天",self.signday];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    [attributeStr addAttribute:NSForegroundColorAttributeName  //文字颜色
                         value:[UIColor colorWithRed:0.f green:129/255.f blue:190/255.f alpha:1.0]
                         range:NSMakeRange(6, 2)];
    [attributeStr addAttribute:NSFontAttributeName value:Font(16) range:NSMakeRange(6, 2)];
    self.QianLab.attributedText = attributeStr;
    }
    
    self.QianLab.font = Font(15);
    [qianView addSubview:self.QianLab];
    
    UIView *QianLINET =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    QianLINET.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
    [qianView addSubview:QianLINET];
//分割线
    UIView *QianLINEB =[[UIView alloc] initWithFrame:CGRectMake(0, qianView.frame.size.height-0.5, SCREEN_WIDTH, 0.5)];
    QianLINEB.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
    [qianView addSubview:QianLINEB];
//分割线
    UIView *QianLINEB1 =[[UIView alloc] initWithFrame:CGRectMake(0, 10+topMenu.frame.size.height+Calendarview.frame.size.height+qianView.frame.size.height+2.5, SCREEN_WIDTH, 0.5)];
    QianLINEB1.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
    [HuadongView addSubview:QianLINEB1];
//分割线
    UIView *QianLINEB2 =[[UIView alloc] initWithFrame:CGRectMake(0, 10+topMenu.frame.size.height+Calendarview.frame.size.height+qianView.frame.size.height+5, SCREEN_WIDTH, 0.5)];
    QianLINEB2.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
    [HuadongView addSubview:QianLINEB2];
    
    UIView *BiaoJiView = [[UIView alloc] initWithFrame:CGRectMake(0, 10+topMenu.frame.size.height+Calendarview.frame.size.height+qianView.frame.size.height+5+10, SCREEN_WIDTH, 150)];
    BiaoJiView.backgroundColor = [UIColor clearColor];
    [HuadongView addSubview:BiaoJiView];
    
 //显示view
    UIView *xianshiView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    xianshiView.backgroundColor = [UIColor whiteColor];
    [BiaoJiView addSubview:xianshiView];
    
    zhanShiView *zhanView = [[zhanShiView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, xianshiView.frame.size.height) getN:[NSString stringWithFormat:@"%@",self.signday]];
    [xianshiView addSubview:zhanView];
    
    //分割线
    UIView *QianLINEB3 =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    QianLINEB3.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
    [xianshiView addSubview:QianLINEB3];
    
    //分割线
    UIView *QianLINEB4 =[[UIView alloc] initWithFrame:CGRectMake(0, xianshiView.frame.size.height-0.5, SCREEN_WIDTH, 0.5)];
    QianLINEB4.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
    [xianshiView addSubview:QianLINEB4];
    
//    //分割线
//    UIView *QianLINEB5 =[[UIView alloc] initWithFrame:CGRectMake(0, BiaoJiView.frame.size.height-0.5, SCREEN_WIDTH, 0.5)];
//    QianLINEB5.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
//    [BiaoJiView addSubview:QianLINEB5];
    
//说明Lab
    UILabel *shuomingLab = [[UILabel alloc] initWithFrame:CGRectMake(10, xianshiView.frame.size.height, SCREEN_WIDTH-20, 80)];
    shuomingLab.backgroundColor = [UIColor clearColor];
    shuomingLab.text = @"第一次签到0.1元,连续签到每天增加0.01元,连续签到10天后每天奖励0.2元,连续签到中断会重新计算天数。";
    shuomingLab.font = Font(15);
    shuomingLab.numberOfLines=0;
    [BiaoJiView addSubview:shuomingLab];

//签到底层view
    UIView *diView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-113-kqiandaoBtn_H, SCREEN_WIDTH, kqiandaoBtn_H)];
    diView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:diView];

    UIView *diLIne = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    diLIne.backgroundColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0];
    [diView addSubview:diLIne];
    
//单例模式
    if (!qiandaoBtn) {
        qiandaoBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        qiandaoBtn.frame = CGRectMake(10, 10, SCREEN_WIDTH-20, diView.frame.size.height-20);
        qiandaoBtn.layer.cornerRadius =(diView.frame.size.height-20)/2;
        qiandaoBtn.titleLabel.font = Font(15);
        qiandaoBtn.backgroundColor = CUSTOMERCLOCR;
        [qiandaoBtn setTitle:@"签到" forState:UIControlStateNormal];
        [qiandaoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    
    [qiandaoBtn addTarget:self action:@selector(ClickBtn)];
   
    [diView addSubview:qiandaoBtn];

}



#pragma mark - 签到BTN
-(void)ClickBtn{
    //判断是否可以签到
    [self initWithCanSign];

}

#pragma mark - 判断是否可以签到
-(void)initWithCanSign{

        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        GRLog(@"----------->>%@",[LWAccountTool account].uid);
        if (![LWAccountTool account].uid) {
            return;
        }else{
            
        [dic setObject:[LWAccountTool account].uid  forKey:@"uid"];
        [dic setValue:[LWAccountTool account].token forKey:@"token"];
        }
        
        GRLog(@"----%@",dic);
        
        [[AFEngine share] POST:[NSString stringWithFormat:@"%@%@&dataType=%@",BASE_URL,CanSingUrl,[LWAccountTool account].dataType] parameters:dic  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject)
         {
             
             GRLog(@"Success: %@", responseObject);
             NSString *message =[responseObject objectForKey:@"status"];
             
             if ([message isEqualToString:@"ok"]) {
                 //签到
                 [self initWithQiandaoSIGN];
                 
             }else if ([message isEqualToString:@"fail"]){
                NSString *words = @"您在最近的24小时内没分享收入,请先分享文章获得分享收入再来签到!";
                 [MBProgressHUD showMessage:words];
             }
             
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             GRLog(@"Error: %@", error);
             [MBProgressHUD showMessage:@"网络链接错误!"];
             
         }];

}

#pragma mark - 签到sign
-(void)initWithQiandaoSIGN{

    self.PASS = nil;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    
    GRLog(@"----------->>%@",[LWAccountTool account].uid);
    if (![LWAccountTool account].uid) {
        return;
    }else{
        
    [dic setObject:[LWAccountTool account].uid  forKey:@"uid"];
    [dic setValue:@"sign" forKey:@"type"];
    [dic setValue:[LWAccountTool account].token forKey:@"token"];
   
    }
    
    GRLog(@"----%@",dic);
    
    [[AFEngine share] POST:[NSString stringWithFormat:@"%@%@&dataType=%@",BASE_URL,SINGURL,[LWAccountTool account].dataType] parameters:dic  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject)
     {
         
         GRLog(@"Success: %@", responseObject);
         NSString *message =[responseObject objectForKey:@"status"];
         
         if ([message isEqualToString:@"ok"]) {
             
             qiandaoBtn.backgroundColor = [[UIColor colorWithRed:46/255.f green:130/255.f blue:185/255.f alpha:1.0] colorWithAlphaComponent:0.6];
             qiandaoBtn.enabled = NO;
       self.PASS =@"OK";
//             //存储到本地对签到btn进行判断
//             NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//             [defaults setObject:@"ok" forKey:@"ok"];
             
             [self initWithCreateUI];
         }else if ([message isEqualToString:@"fail"]){
             qiandaoBtn.backgroundColor = [UIColor colorWithRed:46/255.f green:130/255.f blue:185/255.f alpha:1.0] ;
             qiandaoBtn.enabled = YES;
             //存储到本地对签到btn进行判断
             
         }
         
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         GRLog(@"Error: %@", error);
         [MBProgressHUD showMessage:@"网络链接错误!"];
         
     }];
}


#pragma mark - 签到天数
-(void)initWithQiandaoGETDAY{
    self.signday =nil;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    GRLog(@"----------->>%@",[LWAccountTool account].uid);
    if (![LWAccountTool account].uid) {
        return;
    }else{
        
        [dic setObject:[LWAccountTool account].uid  forKey:@"uid"];
        [dic setValue:@"getDay" forKey:@"type"];
        [dic setValue:[LWAccountTool account].token forKey:@"token"];
    }
    
    GRLog(@"----%@",dic);
    
    [[AFEngine share] POST:[NSString stringWithFormat:@"%@%@&dataType=%@",BASE_URL,SINGURL,[LWAccountTool account].dataType] parameters:dic  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject)
     {
         
         GRLog(@"Success: %@", responseObject);
         NSString *message =[responseObject objectForKey:@"status"];
         
         if ([message isEqualToString:@"ok"]) {
  //富文本改变字符串
         self.signday = [responseObject objectForKey:@"signdays"];

            
             GRLog(@"%@",self.signday);
         }else if ([message isEqualToString:@"fail"]){
             
//             self.signday = [NSString stringWithFormat:@"0"];
        
         }
         [self initWithQiandaoTYPE];
         
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         GRLog(@"Error: %@", error);
         [MBProgressHUD showMessage:@"网络链接错误!"];
         
//请求失败进行UI布局
         
     }];
    
    
    
}

#pragma mark - shifou签到type
-(void)initWithQiandaoTYPE{
    
    self.PASS = nil;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    
    GRLog(@"----------->>%@",[LWAccountTool account].uid);
    if (![LWAccountTool account].uid) {
        return;
    }else{
        
        [dic setObject:[LWAccountTool account].uid  forKey:@"uid"];
        [dic setValue:@"type" forKey:@"type"];
        
        [dic setValue:[LWAccountTool account].token forKey:@"token"];
    }
    
    GRLog(@"----%@",dic);
    
    [[AFEngine share] POST:[NSString stringWithFormat:@"%@%@&dataType=%@",BASE_URL,SINGURL,[LWAccountTool account].dataType] parameters:dic  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject)
     {
         
         GRLog(@"Success: %@", responseObject);
         NSString *message =[responseObject objectForKey:@"status"];
         
         if ([message isEqualToString:@"ok"]) {
             
             qiandaoBtn.backgroundColor = [UIColor colorWithRed:46/255.f green:130/255.f blue:185/255.f alpha:0.6];
             qiandaoBtn.enabled = NO;
             
             self.PASS =@"OK";
//             //存储到本地对签到btn进行判断
//             NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//             [defaults setObject:@"ok" forKey:@"ok"];
             
         }else if ([message isEqualToString:@"fail"]){
             
             qiandaoBtn.backgroundColor = [UIColor colorWithRed:46/255.f green:130/255.f blue:185/255.f alpha:1.0];
             qiandaoBtn.enabled = YES;
             
         }
       
         [self initWithCreateUI];
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         GRLog(@"Error: %@", error);
         [MBProgressHUD showMessage:@"网络链接错误!"];
         
     }];
    
}


#pragma mark - 签到本月日历
-(void)initWithSignCanlender{
    
    [self.signDataArr removeAllObjects];
   
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    GRLog(@"----------->>%@",[LWAccountTool account].uid);
    if (![LWAccountTool account].uid) {
        return;
    }else{
//获取当前日期
        NSDate *now = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
        NSInteger year = [dateComponent year];
        NSInteger MONTH = [dateComponent month];
        NSInteger day = [dateComponent day];
        NSString *yearStr = [NSString stringWithFormat:@"%ld",year];
        NSString *monthStr = [NSString stringWithFormat:@"%ld",MONTH];
        NSString *dayStr  = [NSString stringWithFormat:@"%ld",day];
        
        [dic setObject:[LWAccountTool account].uid  forKey:@"uid"];
        [dic setValue:[LWAccountTool account].token forKey:@"token"];
        [dic setValue:yearStr forKey:@"y"];
        [dic setValue:monthStr forKey:@"m"];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:dayStr forKey:@"day"];
        
    }
    
    GRLog(@"----%@",dic);
    
    [[AFEngine share] POST:[NSString stringWithFormat:@"%@%@&dataType=%@",BASE_URL,CanlenarURL,[LWAccountTool account].dataType] parameters:dic  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject)
     {
         
         GRLog(@"Success: %@", responseObject);
         NSString *message =[responseObject objectForKey:@"status"];
         
         if ([message isEqualToString:@"ok"])
         {
             
         NSArray *array = [responseObject objectForKey:@"signDate"];
           
         self.signDataArr =[signDayModel mj_objectArrayWithKeyValuesArray:array];
         self.nowMouthArr = [NSMutableArray array];
//        self.lastMouthArr = [NSMutableArray array];
           
         for (int i =0; i<self.signDataArr.count; i++)
         {

                 
            signDayModel *model = self.signDataArr[i];
             //将字符串截成数组
            NSArray *arr = [model.ymd componentsSeparatedByString:@"-"];
             if ([arr[1] isEqualToString:mouthString])
             {
                 [self.nowMouthArr addObject:[NSNumber numberWithInt:[arr[2] intValue]]];
                 
             }
             
             }
             
         }else if ([message isEqualToString:@"fail"]){
         }
         else
         {
          //请求失败时候进行UI布局
         }
        
          [self initWithQiandaoGETDAY];
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         GRLog(@"Error: %@", error);
         [MBProgressHUD showMessage:@"网络链接错误!"];
         
     }];

    
    
}

#pragma mark - 上个月签到数据
-(void)initwithCANSIGNCANLENDR{

    [self.signDataArr removeAllObjects];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    GRLog(@"----------->>%@",[LWAccountTool account].uid);
    if (![LWAccountTool account].uid) {
        return;
    }else{
//        //获取当前日期
        NSDate *now = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
        
        NSInteger year = [dateComponent year];
        NSInteger MONTH = [dateComponent month]-1;
        NSInteger day = [dateComponent day];
        NSString *yearStr = [NSString stringWithFormat:@"%ld",year];
        NSString *monthStr = [NSString stringWithFormat:@"%ld",MONTH];
        NSString *dayStr  = [NSString stringWithFormat:@"%ld",day];
        
        
        [dic setObject:[LWAccountTool account].uid  forKey:@"uid"];
        [dic setValue:[LWAccountTool account].token forKey:@"token"];
        [dic setValue:yearStr forKey:@"y"];
        [dic setValue:monthStr forKey:@"m"];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:dayStr forKey:@"day"];
        
    }
    
    GRLog(@"----%@",dic);
    
    [[AFEngine share] POST:[NSString stringWithFormat:@"%@%@&dataType=%@",BASE_URL,CanlenarURL,[LWAccountTool account].dataType] parameters:dic  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject)
     {
         
         GRLog(@"Success: %@", responseObject);
         NSString *message =[responseObject objectForKey:@"status"];
         
         if ([message isEqualToString:@"ok"])
         {
             
             NSArray *array = [responseObject objectForKey:@"signDate"];
             
             self.signDataArr =[signDayModel mj_objectArrayWithKeyValuesArray:array];
//             self.nowMouthArr = [NSMutableArray array];
             self.lastMouthArr = [NSMutableArray array];
             
             
             for (int i =0; i<self.signDataArr.count; i++)
             {
                 
                 signDayModel *model = [[signDayModel alloc] init];
                 model = self.signDataArr[i];
                 //将字符串截成数组
                 NSArray *arr = [model.ymd componentsSeparatedByString:@"-"];
                 
                 [self.lastMouthArr addObject:[NSNumber numberWithInt:[arr[2] intValue]]];
            
             }
             
         }else if ([message isEqualToString:@"fail"]){
             
             
         }
         else
         {
             //请求失败时候进行UI布局
            
         }
         
         [self initWithCreateUI];
         
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
