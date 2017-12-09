//
//  MRHomeViewController.m
//  RenRen
//
//  Created by Beyondream on 16/7/6.
//  Copyright © 2016年 Beyondream. All rights reserved.
//
#import "MRHomeViewController.h"
#import "MROneViewController.h"
#import "MRNavigationLabel.h"

#define MRScreenW [UIScreen mainScreen].bounds.size.width
#define MRScreenH [UIScreen mainScreen].bounds.size.height

@interface MRHomeViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *titleScrollView;

@property (nonatomic,strong) UIScrollView *contentScrollView;
/** 下划线 */
@property (nonatomic, strong) UIView *underline;

@end

@implementation MRHomeViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    UIButton *fenxiangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    fenxiangBtn.frame = CGRectMake(0, 0, 45, 30);
    NSArray * arr = [NSArray arrayWithObjects:@"人人转",@"轻松转",@"凤凰转",@"万家转",@"家家转",@"全新转",@"全速转",@"全球转",@"天天转", nil];
    NSInteger inde =[DATATYPE integerValue]==0?1:[DATATYPE integerValue];
    [fenxiangBtn setTitle:arr[inde-1] forState:UIControlStateNormal];
    fenxiangBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [fenxiangBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:fenxiangBtn];
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 设置背景色
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.titleScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MRScreenW, 44)];
    self.titleScrollView.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.0];
    self.titleScrollView.bounces = YES;
    self.titleScrollView.showsVerticalScrollIndicator = NO;
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.titleScrollView];
    
    self.contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.titleScrollView.maxY, MRScreenW, MRScreenH-self.titleScrollView.maxY)];
    self.contentScrollView.delegate = self;
    self.contentScrollView.showsVerticalScrollIndicator = NO;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.contentScrollView];
    
    // 取消系统自动设置第一个子scrollView的contentInset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 添加子控制器
    [self addChildViewControllers];
    
    _underline = [[UIView alloc]initWithFrame:CGRectMake(0, self.titleScrollView.boundsHeight-2, self.titleScrollView.boundsWidth/2, 2)];
    _underline.backgroundColor = CUSTOMERCLOCR;
    [self.titleScrollView addSubview:_underline];
    
    // 添加标签栏
    [self addNavigationLabels];
    
    // 默认滑动到第一个tab, 显示第一个控制器view
    [self scrollViewDidEndScrollingAnimation: self.contentScrollView];
}

/**
 *  添加子控制器
 */
- (void)addChildViewControllers {
    
    MROneViewController *vc1 = [[MROneViewController alloc] init];
    vc1.title = @"分享收益明细";
    vc1.kindStr = @"收入纪录";
    [self addChildViewController:vc1];
    
    MROneViewController *vc2 = [[MROneViewController alloc] init];
    vc2.title = @"高收益明细";
    vc2.kindStr = @"收入纪录";
    [self addChildViewController:vc2];

    
    self.contentScrollView.contentSize = CGSizeMake(self.childViewControllers.count * MRScreenW, MRScreenH-94);
    
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.directionalLockEnabled = YES;
    self.contentScrollView.bounces = NO;
}


/**
 *  添加导航标签栏
 */
- (void)addNavigationLabels {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width/2;
    
    CGFloat height = self.titleScrollView.frame.size.height;
    
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
        
        MRNavigationLabel *navigationLabel = [[MRNavigationLabel alloc] init];
        
        navigationLabel.tag = i;
        
        navigationLabel.frame = CGRectMake(i * width, 0, width, height);
        
        navigationLabel.text = [self.childViewControllers[i] title];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        
        [navigationLabel addGestureRecognizer:tap];
        
        [self.titleScrollView addSubview:navigationLabel];
        
        if(i == 0&&self.scaleEnable) {    // 第一个Label标签
            navigationLabel.scale = 1.0;
        }
    }
    
    self.titleScrollView.contentSize = CGSizeMake(width * self.childViewControllers.count, height);
    
    self.titleScrollView.bounces = NO;
}


/**
 *  手势事件
 */
- (void)tap:(UITapGestureRecognizer *)tap {
    
    NSInteger index = tap.view.tag;
    
    // 定位到指定位置
    CGPoint offset = self.contentScrollView.contentOffset;
    
    offset.x = index * MRScreenW;
    
    [self.contentScrollView setContentOffset:offset animated:YES];
}


#pragma mark - <UIScrollViewDelegate>

/**
 *  当scrollView进行动画结束的时候会调用这个方法, 例如调用[self.contentScrollView setContentOffset:offset animated:YES];方法的时候
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (scrollView ==self.contentScrollView)
    {
        // 一些临时变量
        CGFloat width = scrollView.frame.size.width;
        CGFloat height = scrollView.frame.size.height;
        CGFloat offsetX = scrollView.contentOffset.x;
        
        // 当前控制器需要显示的控制器的索引
        NSInteger index = offsetX / width;
        
        // 让对应的顶部标题居中显示
        MRNavigationLabel *label = self.titleScrollView.subviews[index];
        CGPoint titleOffsetX = self.titleScrollView.contentOffset;
        titleOffsetX.x = label.center.x - width/2;
        // 左边偏移量边界
        if(titleOffsetX.x < 0) {
            titleOffsetX.x = 0;
        }
        
        CGFloat maxOffsetX = self.titleScrollView.contentSize.width - width;
        // 右边偏移量边界
        if(titleOffsetX.x > maxOffsetX) {
            titleOffsetX.x = maxOffsetX;
        }
        
        // 修改偏移量
        self.titleScrollView.contentOffset = titleOffsetX;
        
        // 取出需要显示的控制器
        UIViewController *willShowVc = self.childViewControllers[index];
        
        // 如果当前位置的控制器已经显示过了，就直接返回，不需要重复添加控制器的view
        if([willShowVc isViewLoaded]) return;
        
        // 如果你没有显示过，则将控制器的view添加到contentScrollView上
        willShowVc.view.frame = CGRectMake(index * width, 0, width, height);
        
        [scrollView addSubview:willShowVc.view];
        

    }
}


/**
 *  当手指抬起停止减速的时候会调用这个方法
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView ==self.contentScrollView) {
            [self scrollViewDidEndScrollingAnimation:scrollView];
    }

}


/**
 *  scrollView滚动时调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView==self.contentScrollView) {
        CGFloat scale = scrollView.contentOffset.x / scrollView.frame.size.width;
        if (self.scaleEnable)
        {
            // 获取需要操作的的左边的Label
            NSInteger leftIndex = scale;
            MRNavigationLabel *leftLabel = self.titleScrollView.subviews[leftIndex];
            
            // 获取需要操作的右边的Label
            NSInteger rightIndex = scale + 1;
            MRNavigationLabel *rightLabel = (rightIndex == self.titleScrollView.subviews.count) ?  nil : self.titleScrollView.subviews[rightIndex];
            
            // 右边的比例
            CGFloat rightScale = scale - leftIndex;
            // 左边比例
            CGFloat leftScale = 1- rightScale;
            
            // 设置Label的比例
            leftLabel.scale = leftScale;
            rightLabel.scale = rightScale;
            
        }else
        {
            //下划线滚动  头部视图滑动
            [UIView animateWithDuration:0.5 animations:^{
                _underline.frame = CGRectMake(scale*SCREEN_WIDTH/2, _underline.maxY-2, _underline.boundsWidth, 2);
            }];
        }

    }
    
}

@end
