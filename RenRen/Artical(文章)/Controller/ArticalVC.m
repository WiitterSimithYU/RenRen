//
//  ArticalVC.m
//  RenRen
//
//  Created by Beyondream on 16/6/15.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "ArticalVC.h"
#import "ArticalDetailVC.h"
#import "ChanneLabel.h"
#import "SortView.h"
#import "SpreadCell.h"
#import "ArticalList.h"

#define SMALL_H  40
static NSString * const reuseID  = @"Cell";

@interface ArticalVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
/** 频道数据模型 */
/** 频道数据模型 */
@property (nonatomic, strong) NSMutableArray *channelList;
/*选中的索引*/
@property(nonatomic,assign)NSInteger selectInteger;
/** 频道列表 */
@property (nonatomic, strong) UIScrollView *smallScrollView;
/** 新闻视图 */
@property (nonatomic, strong) UICollectionView *bigCollectionView;
/** 右侧添加删除排序按钮 */
@property (nonatomic, strong) UIButton *sortButton;

/*更多选择页面*/
@property(nonatomic,strong)SortView *sortView;

@property(nonatomic,strong)NSString *questionIDStr;


@end

@implementation ArticalVC
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSArray *titArr = [NSArray arrayWithObjects:@"人人转",@"轻松转",@"凤凰转",@"万家转",@"家家转",@"全心转",@"全速转",@"全球转",@"天天转", nil];
    NSInteger inde =[DATATYPE integerValue]==0?1:[DATATYPE integerValue];
    DLog(@"inde======%ld",inde);
    self.navigationItem.title = titArr[inde-1];
    [self requestGetHeadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.shadowViewUp addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeClick:)]];
    [self.shadowViewDown addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeClick:)]];
    self.view.backgroundColor = [UIColor whiteColor];
    
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.channelList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SpreadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    ArticalList *art = _channelList[indexPath.row];
    [cell setUrlString:art.urlStr WithTitle:art.title];
    // 如果不加入响应者链，则无法利用NavController进行Push/Pop等操作。
    [self addChildViewController:(UIViewController *)cell.newsVC];
    return cell;
}


#pragma mark - UICollectionViewDelegate
/** 正在滚动 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat value = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (value < 0) {return;} // 防止在最左侧的时候，再滑，下划线位置会偏移，颜色渐变会混乱。
    
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    if (rightIndex >= [self getLabelArrayFromSubviews].count) {  // 防止滑到最右，再滑，数组越界，从而崩溃
        rightIndex = [self getLabelArrayFromSubviews].count - 1;
    }
    
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft  = 1 - scaleRight;
    
//    ChanneLabel *labelLeft  = [self getLabelArrayFromSubviews][leftIndex];
//    ChanneLabel *labelRight = [self getLabelArrayFromSubviews][rightIndex];
    
//    labelLeft.scale  = scaleLeft;
//    labelRight.scale = scaleRight;
    
    
    // 点击label会调用此方法1次，会导致【scrollViewDidEndScrollingAnimation】方法中的动画失效，这时直接return。
    if (scaleLeft == 1 && scaleRight == 0) {
        return;
    }

}

/** 手指滑动BigCollectionView，滑动结束后调用 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.bigCollectionView]) {
        [self scrollViewDidEndScrollingAnimation:scrollView];
    }
}

/** 手指点击smallScrollView */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x / self.bigCollectionView.width;

    // 滚动标题栏到中间位置
    ChanneLabel *titleLable = [self getLabelArrayFromSubviews][index];
    CGFloat offsetx   =  titleLable.center.x - _smallScrollView.width * 0.5;
    CGFloat offsetMax = _smallScrollView.contentSize.width - _smallScrollView.width;
    // 在最左和最右时，标签没必要滚动到中间位置。
    if (offsetx < 0)		 {offsetx = 0;}
    if (offsetx > offsetMax)
    {
        offsetx = offsetMax;
    }
    [_smallScrollView setContentOffset:CGPointMake(offsetx, 0) animated:YES];
    
    // 先把之前着色的去色：（快速滑动会导致有些文字颜色深浅不一，点击label会导致之前的标题不变回黑色）
    for (ChanneLabel *label in [self getLabelArrayFromSubviews]) {
        label.textColor = UIColorFromRGB(0x666666);
        label.scale = 1.0f;
    }
    // 下划线滚动并着色
    [UIView animateWithDuration:0.5 animations:^{
        titleLable.textColor = UIColorFromRGB(0x1E6DA7);
        titleLable.scale = 1.2f;
    }];
     DLog(@"-++++++%ld",(long)titleLable.tag);
}



#pragma mark - getter
//属性初始化
-(NSMutableArray*)channelList
{
    if (!_channelList) {
        _channelList = [NSMutableArray array];
    }
    return _channelList;
}

- (UIScrollView *)smallScrollView
{
    if (_smallScrollView == nil) {
        _smallScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 44)];
        _smallScrollView.backgroundColor = UIColorFromRGB(0xECEDEF);
        _smallScrollView.showsHorizontalScrollIndicator = NO;
        // 设置频道

        [self setupChannelLabel];
        
        if ([self getLabelArrayFromSubviews].count==0) {
            return nil;
        }
        ChanneLabel *firstLabel = [self getLabelArrayFromSubviews][0];
        firstLabel.textColor =  UIColorFromRGB(0x1E6DA7);
        firstLabel.scale = 1.2f;
    }
    return _smallScrollView;
}

- (UICollectionView *)bigCollectionView
{
    if (_bigCollectionView == nil) {
        // 高度 = 屏幕高度 - 导航栏高度64 - 频道视图高度44
        CGFloat h = SCREEN_HEIGHT - 64 - self.smallScrollView.height ;
        CGRect frame = CGRectMake(0, self.smallScrollView.maxY, SCREEN_WIDTH, h);
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _bigCollectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        _bigCollectionView.backgroundColor = [UIColor whiteColor];
        _bigCollectionView.delegate = self;
        _bigCollectionView.dataSource = self;
        [_bigCollectionView registerClass:[SpreadCell class] forCellWithReuseIdentifier:reuseID];
        
        // 设置cell的大小和细节
        flowLayout.itemSize = _bigCollectionView.bounds.size;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        _bigCollectionView.pagingEnabled = YES;
        _bigCollectionView.showsHorizontalScrollIndicator = NO;
    }
    return _bigCollectionView;
}

- (UIButton *)sortButton
{
    if (!_sortButton) {
        _sortButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-SMALL_H+3, 64, SMALL_H, SMALL_H)];
        [_sortButton setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
        [_sortButton setImage:[UIImage imageNamed:@"arrow_up"] forState:UIControlStateSelected];
        [_sortButton setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 6, 8)];
        _sortButton.backgroundColor = UIColorFromRGB(0xECEDEF);
        _sortButton.layer.borderColor = [UIColor clearColor].CGColor;
        [_sortButton addTarget:self action:@selector(sortBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sortButton;

}

- (SortView *)sortView
{
    if (!_sortView) {
        
        _sortView = [[SortView alloc] initWithFrame:CGRectMake(0,SMALL_H,SCREEN_WIDTH,_bigCollectionView.height -100) channelList:self.channelList withSelect:self.selectInteger];
        
        // 上面高度44的描述栏(覆盖smallScrollView)
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH-SMALL_H+3, 44)];
        label.backgroundColor =UIColorFromRGB(0xECEDEF);
        label.text = @"      切换栏目";
        label.tag = 1000;
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:16];
        [self.view addSubview:label];

        __block typeof(self) weakSelf = self;
        // 排序完成回调
        _sortView.sortCompletedBlock = ^(NSMutableArray *channelList,NSInteger selectInteger){
            weakSelf.channelList = channelList;
            // 去除旧的排序
            for (ChanneLabel *label in [weakSelf getLabelArrayFromSubviews]) {
                [label removeFromSuperview];
            }
            // 加入新的排序
            [weakSelf setupChannelLabel];
            // 滚到第一个频道！offset、下划线、着色，都去第一个. 直接模拟第一个label被点击：
            ChanneLabel *label = [weakSelf getLabelArrayFromSubviews][selectInteger];
            UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
            [tap setValue:label forKey:@"view"];
            [weakSelf labelClick:tap];
        };
        // cell按钮点击回调
        _sortView.cellButtonClick = ^(UIButton *button){
            // 模拟label被点击
            for (ChanneLabel *label in [weakSelf getLabelArrayFromSubviews]) {
                if ([label.text isEqualToString:button.titleLabel.text]) {
                    [weakSelf sortBtnClick:weakSelf.sortButton]; // 关闭sortView
                    UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
                    [tap setValue:label forKey:@"view"];
                    [weakSelf labelClick:tap];
                }
            }
        };
    }
    return _sortView;
}

#pragma mark -
/** 设置频道标题 */
- (void)setupChannelLabel
{
    CGFloat margin = 10.0f;
    CGFloat x = 8;
    CGFloat h = _smallScrollView.bounds.size.height;
    for (int i = 0; i<self.channelList.count; i++) {
        ArticalList *art = self.channelList[i];
        ChanneLabel *lable= [ChanneLabel channelLabelWithTitle:art.title];
        lable.font = Font(15);
        lable.frame = CGRectMake(x, 0, lable.width+margin, h);
        lable.textColor = UIColorFromRGB(0x666666);;
        [_smallScrollView addSubview:lable];
        x += lable.bounds.size.width;
        lable.tag = i;
        [lable addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
    }
    _smallScrollView.contentSize = CGSizeMake(x+margin +self.sortButton.width, 0);

}

/** 频道Label点击事件 */
- (void)labelClick:(UITapGestureRecognizer *)recognizer
{
    
    ChanneLabel *label = (ChanneLabel *)recognizer.view;
    if (self.selectInteger == label.tag) {
        return;
    }
    DLog(@"-----%ld",(long)label.tag);
    self.selectInteger = label.tag;
    // 点击label后，让bigCollectionView滚到对应位置。
    [_bigCollectionView setContentOffset:CGPointMake(label.tag * _bigCollectionView.frame.size.width, 0)];
    // 重新调用一下滚定停止方法，让label的着色和下划线到正确的位置。
    [self scrollViewDidEndScrollingAnimation:self.bigCollectionView];
}

/** 获取smallScrollView中所有的DDChannelLabel，合成一个数组，因为smallScrollView.subViews中有其他非Label元素 */
- (NSArray *)getLabelArrayFromSubviews
{
    NSMutableArray *arrayM = [NSMutableArray array];
    for (ChanneLabel *label in _smallScrollView.subviews) {
        if ([label isKindOfClass:[ChanneLabel class]]) {
            [arrayM addObject:label];
        }
    }
    return arrayM.copy;
}

/** 排序按钮点击事件 */
-(void)sortBtnClick:(UIButton*)sender
{
    UILabel *label = (UILabel*)[self.view viewWithTag:1000];
    if (self.smallScrollView.hidden==NO) {
        self.shadowViewUp.hidden = NO;
        self.shadowViewDown.hidden = NO;
        self.smallScrollView.hidden  = YES;
        [self.view addSubview:self.sortView];
        self.sortButton.selected =YES;
        _sortView.y = SMALL_H+64;

    }else
    {
        self.shadowViewUp.hidden = YES;
        self.shadowViewDown.hidden = YES;
        self.smallScrollView.hidden  = NO;
        self.sortButton.selected = NO;
            [self.sortView removeFromSuperview];
            [label removeFromSuperview];
            self.sortView = nil;

    }
}
#pragma mark--获取头部试图数据
-(void)requestGetHeadData
{
    NSMutableDictionary *dic  = [NSMutableDictionary dictionary];
    if ([LWAccountTool account].uid ) {
        [dic setObject:[LWAccountTool account].uid forKey:@"uid"];
    }
    __weak typeof(self) weakSelf = self;
    [[AFEngine share] requestGetMethodURL:[NSString stringWithFormat:@"%@%@&dataType=%@",BASE_URL,GET_ART_SORT,DATATYPE] parameters:dic withVC:self success:^(NSURLSessionDataTask *task, id responseObj){
        
        NSArray *respDataArr = responseObj[@"cates"];
        _channelList = [ArticalList mj_objectArrayWithKeyValuesArray:respDataArr];
        
        NSArray *arr = [NSArray arrayWithObjects:@"热门",@"推荐",@"最新", nil];
        NSMutableArray*firArr = [NSMutableArray array];
        for (int i=0; i<3; i++) {
            ArticalList *art = [[ArticalList alloc]init];
            if (i==0) {
                art.artID = @"1";
            }else if (i==1)
            {
                art.artID = @"3";
            }else
            {
                art.artID = @"2";
            }
            art.title = arr[i];
            [firArr addObject:art];
        }
        for (int i=0; i<3; i++) {
            [_channelList insertObject:firArr[i] atIndex:i];
        }
        for (int i=0; i<_channelList.count; i++)
        {
            ArticalList *art = _channelList[i];
            art.urlStr = [NSString stringWithFormat:@"%d",[art.artID intValue]];

        }
        if (_channelList.count!=0) {
            
            [self.view addSubview:self.smallScrollView];
            [self.view addSubview:self.bigCollectionView];
            [self.view addSubview:self.sortButton];
            weakSelf.smallScrollView.hidden = NO;
            weakSelf.bigCollectionView.hidden = NO;
            weakSelf.sortButton.hidden = NO;
        }

        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        weakSelf.smallScrollView.hidden = YES;
        weakSelf.bigCollectionView.hidden = YES;
        weakSelf.sortButton.hidden = YES;
        UIImageView*imghold = [RTool setViewPlaceHoldImage:SCREEN_HEIGHT/2-50 WithBgView:self.view];
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
    [self.smallScrollView removeFromSuperview];
    self.smallScrollView = nil;
    [self requestGetHeadData];//获取头部数据
}
//手势
-(void)removeClick:(UIGestureRecognizer*)recognize
{
    [self sortBtnClick:self.sortButton];

}
@end
