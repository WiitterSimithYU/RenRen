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

@interface SignVC ()<JLCalendarItemDelegate,UIScrollViewDelegate>

@end

@implementation SignVC
{
    JLCalendarScrollView * view;
    UIScrollView *scrollView;
}
-(void)viewDidLoad
{
    [super viewDidLoad];

    
    [self initWithCreateUI];
    
}

//处理视觉落差
-(void)viewWillAppear:(BOOL)animated
{
    scrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT - 20 -103);

}
-(void)initWithCreateUI{
  //底层scrollview
    scrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0 , 0, SCREEN_WIDTH, SCREEN_HEIGHT-20)];
    scrollView.pagingEnabled =NO;
    scrollView.bounces =NO;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator =NO;
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    scrollView.clipsToBounds = YES;
    scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 30, 0);
    [self.view addSubview:scrollView];
    
//底层view
    UIView *HuadongView;
    HuadongView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-20)];
    HuadongView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    [scrollView addSubview:HuadongView];
    
    //顶部导航条
    YMOder_TopView *topMenu = [[YMOder_TopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) selectedItem:^(NSInteger index) {
        NSLog(@"click---------- = %ld",index);
        
        if (index==0) {
            [view monthOnclick:1];
            
        }else if(index==1){
            [view monthOnclick:0];
            
        }
        
    } ];
    //默认选择就状态
    //    [topMenu selectIndex:1];
    topMenu.backgroundColor =[UIColor whiteColor];
    [HuadongView addSubview:topMenu];
    
    view = [[JLCalendarScrollView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 180)];
    view.backgroundColor = [UIColor yellowColor];
    view.delegate = self;
    //    当前选择的年月日
    //    view.currentDay = 10;
    //    view.currentMonth = 5;
    //    view.currentYear = 2016;
    [HuadongView addSubview:view];

    UIView *qianView = [[UIView alloc] initWithFrame:CGRectMake(0, 10+topMenu.frame.size.height+view.frame.size.height, SCREEN_WIDTH, 30)];
    qianView.backgroundColor= [UIColor whiteColor];
    [HuadongView addSubview:qianView];
 //签到LAB
    UILabel *QianLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0,qianView.frame.size.width ,qianView.frame.size.height )];
    QianLab.backgroundColor = [UIColor clearColor];
    QianLab.text = @"已经连续签到0天";
    QianLab.font = Font(15);
    [qianView addSubview:QianLab];
    
    UIView *QianLINET =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    QianLINET.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
    [qianView addSubview:QianLINET];
//分割线
    UIView *QianLINEB =[[UIView alloc] initWithFrame:CGRectMake(0, qianView.frame.size.height-0.5, SCREEN_WIDTH, 0.5)];
    QianLINEB.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
    [qianView addSubview:QianLINEB];
//分割线
    UIView *QianLINEB1 =[[UIView alloc] initWithFrame:CGRectMake(0, 10+topMenu.frame.size.height+view.frame.size.height+qianView.frame.size.height+2.5, SCREEN_WIDTH, 0.5)];
    QianLINEB1.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
    [HuadongView addSubview:QianLINEB1];
//分割线
    UIView *QianLINEB2 =[[UIView alloc] initWithFrame:CGRectMake(0, 10+topMenu.frame.size.height+view.frame.size.height+qianView.frame.size.height+5, SCREEN_WIDTH, 0.5)];
    QianLINEB2.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
    [HuadongView addSubview:QianLINEB2];
    
    UIView *BiaoJiView = [[UIView alloc] initWithFrame:CGRectMake(0, 10+topMenu.frame.size.height+view.frame.size.height+qianView.frame.size.height+5+10, SCREEN_WIDTH, 150)];
    BiaoJiView.backgroundColor = [UIColor clearColor];
    [HuadongView addSubview:BiaoJiView];
    
 //显示view
    UIView *xianshiView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    xianshiView.backgroundColor = [UIColor whiteColor];
    [BiaoJiView addSubview:xianshiView];
    
    zhanShiView *zhanView = [[zhanShiView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, xianshiView.frame.size.height) getN:[NSString stringWithFormat:@"5"]];
  
    
    [xianshiView addSubview:zhanView];
    
    //分割线
    UIView *QianLINEB3 =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    QianLINEB3.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
    [xianshiView addSubview:QianLINEB3];
    
    //分割线
    UIView *QianLINEB4 =[[UIView alloc] initWithFrame:CGRectMake(0, xianshiView.frame.size.height-0.5, SCREEN_WIDTH, 0.5)];
    QianLINEB4.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
    [xianshiView addSubview:QianLINEB4];
    
    //分割线
    UIView *QianLINEB5 =[[UIView alloc] initWithFrame:CGRectMake(0, BiaoJiView.frame.size.height-0.5, SCREEN_WIDTH, 0.5)];
    QianLINEB5.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
    [BiaoJiView addSubview:QianLINEB5];
    
//说明Lab
    UILabel *shuomingLab = [[UILabel alloc] initWithFrame:CGRectMake(10, xianshiView.frame.size.height, SCREEN_WIDTH-20, 80)];
    shuomingLab.backgroundColor = [UIColor clearColor];
    shuomingLab.text = @"第一次签到0.1元,连续签到每天增加0.01元,连续签到10天后每天奖励0.2元,连续签到中断会重新计算天数。";
    shuomingLab.font = Font(15);
    shuomingLab.numberOfLines=0;
    [BiaoJiView addSubview:shuomingLab];
    
    
    
    
//签到底层view
    UIView *diView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-100, SCREEN_WIDTH, 51)];
    diView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:diView];
    UIView *diLIne = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    diLIne.backgroundColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0];
    [diView addSubview:diLIne];
    
    UIButton *qiandaoBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    qiandaoBtn.frame = CGRectMake(10, 10, SCREEN_WIDTH-20, diView.frame.size.height-20) ;
    qiandaoBtn.layer.cornerRadius =(diView.frame.size.height-20)/2;
    qiandaoBtn.titleLabel.font = Font(15);
    qiandaoBtn.backgroundColor = CUSTOMERCLOCR;
    [qiandaoBtn setTitle:@"签到" forState:UIControlStateNormal];
    [qiandaoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [qiandaoBtn addTarget:self action:@selector(qiandaoBtn)];
    [diView addSubview:qiandaoBtn];

    
}


-(void)qiandaoBtn{
    GRLog(@"000000");

}
- (void)seletedOneDay:(NSInteger)day withMonth:(NSInteger)month withYear:(NSInteger)year
{
    NSLog(@"%li-%li-%li", year,month,day);
    
    view.currentDay     = day;
    view.currentMonth   = month;
    view.currentYear    = year;
}
-(void)monthOnclick:(NSInteger)lastOrNext
{
    if (lastOrNext) {
        NSLog(@"下一个月");
    }else{
        NSLog(@"上一个月");
    }
}

-(void)yearOnclick:(NSInteger)lastOrNext
{
    if (lastOrNext) {
        NSLog(@"下一个年");
    }else{
        NSLog(@"上一个年");
    }
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
