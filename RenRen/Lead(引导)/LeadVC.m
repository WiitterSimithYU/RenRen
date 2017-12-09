//
//  LeadVC.m
//  RenRen
//
//  Created by Beyondream on 16/6/15.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "LeadVC.h"
#import "STPageControl.h"
#import "RTabBarController.h"
#import "SHLUILabel.h"
@interface LeadVC ()<UIScrollViewDelegate,RLabelDelegate>

@property(nonatomic,strong)UIScrollView *startScrollView;
@property (strong, nonatomic)STPageControl *pageControl;

@end

@implementation LeadVC

//隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    // iOS7后,[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    // 已经不起作用了
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createUI];
}

- (void)createUI
{
    
    NSArray * startImageArr=@[@"ic_guide_01",@"ic_guide_02",@"ic_guide_03",@"ic_guide_04",@"ic_guide_05"];
    
    _startScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _startScrollView.delegate = self;
    _startScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * startImageArr.count, 0);
    _startScrollView.showsVerticalScrollIndicator = NO;
    _startScrollView.showsHorizontalScrollIndicator = NO;
    _startScrollView.pagingEnabled = YES;
    _startScrollView.bounces = NO;
    _startScrollView.delegate = self;
    [self.view addSubview:_startScrollView];
    
    
    for (NSInteger index = 0; index < startImageArr.count; index++) {
        UIImageView * imageV = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * index, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        imageV.userInteractionEnabled = YES;
        imageV.image = [UIImage imageNamed:startImageArr[index]];
        //后期添加跳不跳过/////////
        UIButton *buUon = [UIButton buttonWithType:UIButtonTypeCustom];
        buUon.frame = CGRectMake(SCREEN_WIDTH-50*SCREEN_POINT,40*SCREEN_POINT, 40*SCREEN_POINT,40*SCREEN_POINT);
        [buUon setImage:[UIImage imageNamed:@"ic_guide_skip"] forState:UIControlStateNormal];
        buUon.backgroundColor =[UIColor clearColor];
        [buUon addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [imageV addSubview:buUon];
        //后期添加跳不跳过/////////
        
        if (index == startImageArr.count-1) {
            SHLUILabel *stareLabel = [[SHLUILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-125, SCREEN_HEIGHT-120, 250, 60)];
            stareLabel.layer.borderColor = [UIColor whiteColor].CGColor;
            stareLabel.characterSpacing = 5;
            stareLabel.layer.borderWidth = 1.0f;
            stareLabel.layer.cornerRadius = 30;
            stareLabel.text = @"立即开赚  ";
            stareLabel.font = [UIFont boldSystemFontOfSize:22];
            stareLabel.textAlignment = NSTextAlignmentCenter;
            stareLabel.lineBreakMode = NSLineBreakByWordWrapping;;
            stareLabel.numberOfLines = 1;
            stareLabel.delegate = self;
            stareLabel.textColor = [UIColor whiteColor];
            stareLabel.clipsToBounds = YES;
            [imageV addSubview:stareLabel];
            
        }
        
        [_startScrollView addSubview:imageV];
    }
    _pageControl = [STPageControl pageControlDefaultWithFrame:CGRectMake(0, 0, 0, 0) numberOfPages:startImageArr.count coreNormalColor:UIColorFromRGB(0xd3d3d3) coreSelectedColor:[UIColor whiteColor] lineNormalColor:UIColorFromRGB(0xd3d3d3)
                                            lineSelectedColor:[UIColor whiteColor]];
    _pageControl.userInteractionEnabled = NO;
    _pageControl.frame = CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT-15, 100, 15);
    _pageControl.diameter = 5;
    [self.view addSubview:_pageControl];
    
}

-(void)buttonClick:(UIButton *)btn
{
    [UIApplication sharedApplication].statusBarHidden = NO;
    UIApplication *al = [UIApplication sharedApplication];
    al.delegate.window.rootViewController = [[RTabBarController alloc]init];
    [al.delegate.window makeKeyAndVisible];
    
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat scrollViewW = scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = x/scrollViewW;
    
    _pageControl.currentPage = page;
}
/**
 *  shuluilabel 协议方法
 */
-(void)Rlabel:(SHLUILabel *)label
{
    [UIApplication sharedApplication].statusBarHidden = NO;
    UIApplication *al = [UIApplication sharedApplication];
    al.delegate.window.rootViewController = [[RTabBarController alloc]init];
    [al.delegate.window makeKeyAndVisible];
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
