//
//  JLCalendarScrollView.m
//  JLCustomCalendar
//
//  Created by eall_linger on 16/5/11.
//  Copyright © 2016年 eall_linger. All rights reserved.
//

#import "JLCalendarScrollView.h"

/**
 *  TotalNumber
 *
 *   总月数 从今天起 前4000/2 个月  后4000/2个月 前后333年 应该够用。可随意调节。4000时候创建后占用内存大概2M
 *   选择 上一年或下一年 的时候，数据会重置。同上。
 */

#define TotalNumber    4000
#define collection_H   180

@implementation JLCalendarScrollView
{
    UICollectionView * _collectionView;
    NSArray *dateArray;
    
    NSInteger _currentScrollIndexRow;
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initCalendarView];
    }
    return self;
}
- (void)initCalendarView
{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    flowLayout.minimumLineSpacing=0;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, collection_H)  collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    _collectionView.pagingEnabled = YES;
    _collectionView.userInteractionEnabled = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = self.backgroundColor;
    [self addSubview:_collectionView];
    [self createDate:[NSDate date]];
    
    
}
- (void)createDate:(NSDate *)date
{
    NSMutableArray *tmpArray= [[NSMutableArray alloc]init];
    
    NSDate * currentDate = date;
    
    for (NSInteger i = 0; i < TotalNumber/2; i++) {
        [tmpArray addObject:currentDate];
        currentDate = [self nextMonth:currentDate];
    }
    
    currentDate = [self lastMonth:date];
    
    for (NSInteger i = 0; i < TotalNumber/2; i++) {
        [tmpArray insertObject:currentDate atIndex:0];
        currentDate = [self lastMonth:currentDate];
    }
    
    dateArray = tmpArray;
    _currentScrollIndexRow = TotalNumber/2;
    
    [_collectionView reloadData];
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:TotalNumber/2 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return dateArray.count;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"UICollectionViewCell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    JLCalendarItem *tmpCalendarView = [cell viewWithTag:100];
    if (tmpCalendarView) {
        [tmpCalendarView removeFromSuperview];
        tmpCalendarView.delegate = nil;
        tmpCalendarView = nil;
    }
    
//展示页面顶层
    JLCalendarItem *calendarView = [[JLCalendarItem alloc] init];
    calendarView.frame      = CGRectMake(0, 0, self.frame.size.width, collection_H);
//    calendarView.backgroundColor = [UIColor greenColor];
    calendarView.tag        = 100;
    calendarView.delegate   = self;

    calendarView.currentDay     = _currentDay;
    calendarView.currentMonth   = _currentMonth;
    calendarView.currentYear    = _currentYear;
    
    calendarView.date = dateArray[indexPath.row];
    
    UIView *renView = [[UIView alloc] initWithFrame:CGRectMake(0, calendarView.frame.size.height-10, calendarView.frame.size.width, 10)];
    renView.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.0];
    [calendarView addSubview:renView];
    
    
    UIView *BBViewLine = [[UIView alloc] initWithFrame:CGRectMake(0, calendarView.frame.size.height-10, calendarView.frame.size.width, 1)];
    BBViewLine.backgroundColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0];
    [renView addSubview:BBViewLine];
    
    UIView *bView = [[UIView alloc] initWithFrame:CGRectMake(0, calendarView.frame.size.height-1, calendarView.frame.size.width, 1)];
    bView.backgroundColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0];
    [renView addSubview:bView];

    
    [cell.contentView addSubview:calendarView];
    
    
    return cell;
}
//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.frame.size.width, collection_H);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _collectionView) {
        _currentScrollIndexRow = _collectionView.contentOffset.x/self.frame.size.width;
    }
}

- (NSDate *)lastMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

- (NSDate*)nextMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

- (NSDate *)lastYear:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

- (NSDate*)nextYear:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}


- (void)seletedOneDay:(NSInteger)day withMonth:(NSInteger)month withYear:(NSInteger)year
{
    [self.delegate seletedOneDay:day withMonth:month withYear:year];
}

- (void)monthOnclick:(NSInteger)lastOrNext
{
    if (lastOrNext) {
        if (_currentScrollIndexRow < TotalNumber - 1) {
            [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_currentScrollIndexRow + 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        }
    }else{
        if (_currentScrollIndexRow > 0) {
            [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_currentScrollIndexRow - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        }
    }
    [self.delegate monthOnclick:lastOrNext];
}

- (void)yearOnclick:(NSInteger)lastOrNext
{
    NSDate *date = dateArray[_currentScrollIndexRow];
    if (lastOrNext) {
        [self createDate: [self nextYear:date]];
    }else{
        [self createDate: [self lastYear:date]];
    }
    [self.delegate yearOnclick:lastOrNext];
}

@end
