//
//  zhanShiView.m
//  RenRen
//
//  Created by miaomiaokeji on 16/6/17.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "zhanShiView.h"
#define klabel_w 50
#define klabel_h 20

@implementation zhanShiView

-(instancetype)initWithFrame:(CGRect)frame getN:(NSString *)N{
    self = [super initWithFrame:frame];
    if (self) {
        self.N = N;
        [self initCreateUI];
    }
    return self;
}

-(void)initCreateUI{

    UIView *showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height)];
    showView.backgroundColor = [UIColor whiteColor];
    [self addSubview:showView];
    
    UILabel *oneLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, klabel_w, klabel_h)];
    oneLab.text = @"第1天";
    oneLab.textAlignment = NSTextAlignmentCenter;
    oneLab.font = Font(15);
    oneLab.backgroundColor = [UIColor clearColor];
    [showView addSubview:oneLab];
    
    UILabel *twoLab = [[UILabel alloc] initWithFrame:CGRectMake(10+90, 10, klabel_w, klabel_h)];
    twoLab.text = @"第10天";
    twoLab.font = Font(15);
    twoLab.textAlignment = NSTextAlignmentCenter;
    twoLab.backgroundColor = [UIColor clearColor];
    [showView addSubview:twoLab];

    UILabel *threeLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-klabel_w-10, 10, klabel_w, klabel_h)];
    threeLab.text = @"第30天";
    threeLab.font = Font(15);
    threeLab.textAlignment = NSTextAlignmentCenter;
    threeLab.backgroundColor = [UIColor clearColor];
    [showView addSubview:threeLab];
    
    UIView *lianjieView = [[UIView alloc] initWithFrame:CGRectMake(0, 10 + oneLab.frame.size.height + 19,SCREEN_WIDTH , 3)];
    lianjieView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    [showView addSubview:lianjieView];
    
    
    UIView *jingduView = [[UIView alloc] init];
    
    NSInteger n =[self.N integerValue];
    if (n==1) {
        jingduView.frame = CGRectMake(0, 10 + oneLab.frame.size.height + 19, 15, 3);
        
    }else if (n>1&&n<10){
      jingduView.frame = CGRectMake(0, 10 + oneLab.frame.size.height + 19, 60+4*n, 3);
        
    }else if (n ==10){
    jingduView.frame = CGRectMake(0, 10 + oneLab.frame.size.height + 19, 110, 3);
        
    }else if (n>10&&n<30){
    
        CGFloat W = (SCREEN_WIDTH -210)/20;
        jingduView.frame = CGRectMake(0, 10 + oneLab.frame.size.height + 19, 150+ W*(n-10), 3);
        
    }else if (n==30){
    
    jingduView.frame = CGRectMake(0, 10 + oneLab.frame.size.height + 19, SCREEN_WIDTH, 3);
    }
    
    jingduView.backgroundColor = CUSTOMERCLOCR;
    [showView addSubview:jingduView];
   
    
    
    UIView *firLab1 = [[UIView alloc] initWithFrame:CGRectMake(10, 10 +oneLab.frame.size.height+10, klabel_w, klabel_h)];
    firLab1.backgroundColor = [UIColor whiteColor];
    firLab1.cornerRadius = 10;
    [showView addSubview:firLab1];
    UILabel *firLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 +oneLab.frame.size.height+10, klabel_w, klabel_h)];
    firLab.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    firLab.cornerRadius = 10;
    firLab.text = @"￥0.1";
    firLab.textAlignment = NSTextAlignmentCenter;
    firLab.textColor = [UIColor whiteColor];
    firLab.font = Font(13);
    [showView addSubview:firLab];

    
    UIView *seconLab1 = [[UIView alloc] initWithFrame:CGRectMake(10 +90, 10 +oneLab.frame.size.height+10, klabel_w, klabel_h)];
    seconLab1.backgroundColor = [UIColor whiteColor];
    seconLab1.cornerRadius = 10;
    [showView addSubview:seconLab1];
    
    UILabel *seconLab = [[UILabel alloc] initWithFrame:CGRectMake(10 +90, 10 +oneLab.frame.size.height+10, klabel_w, klabel_h)];
    seconLab.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    seconLab.cornerRadius = 10;
    seconLab.textAlignment = NSTextAlignmentCenter;
    seconLab.text = @"￥0.2";
    seconLab.textColor = [UIColor whiteColor];
    seconLab.font = Font(13);
    [showView addSubview:seconLab];
    
    
    
    UILabel *thirdLab1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-klabel_w-10, 10 +oneLab.frame.size.height+10, klabel_w, klabel_h)];
    thirdLab1.backgroundColor = [UIColor whiteColor];
    [showView addSubview:thirdLab1];
    
    UILabel *thirdLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-klabel_w-10, 10 +oneLab.frame.size.height+10, klabel_w, klabel_h)];
    thirdLab.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    thirdLab.cornerRadius = 10;
    thirdLab.textAlignment = NSTextAlignmentCenter;
    thirdLab.text = @"￥0.2";
    thirdLab.textColor = [UIColor whiteColor];
    thirdLab.font = Font(13);
    [showView addSubview:thirdLab];

    
}


@end
