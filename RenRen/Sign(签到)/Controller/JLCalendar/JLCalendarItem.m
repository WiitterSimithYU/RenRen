//
//  JLCalendarItem.m
//  JLCustomCalendar
//
//  Created by eall_linger on 16/5/11.
//  Copyright © 2016年 eall_linger. All rights reserved.
//

#import "JLCalendarItem.h"

@implementation JLCalendarItem
{
    UIButton  *_selectButton;
    NSMutableArray *_daysArray;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _daysArray = [NSMutableArray arrayWithCapacity:42];
        for (int i = 0; i < 42; i++) {
            UIButton *button = [[UIButton alloc] init];
            [self addSubview:button];
            [_daysArray addObject:button];
        }
    }
    return self;
}

#pragma mark - date

- (NSInteger)day:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}


- (NSInteger)month:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}

- (NSInteger)year:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}


- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}

- (NSInteger)totaldaysInMonth:(NSDate *)date{
    NSRange daysInOfMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInOfMonth.length;
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

#pragma mark - createView

- (void)setDate:(NSDate *)date{
    _date = date;
    [self createCalendarViewWith:date];
}

- (void)createCalendarViewWith:(NSDate *)date{
    
    CGFloat itemW     = self.frame.size.width / 7;
    CGFloat itemH     = self.frame.size.height / 8;
    
    // 2.周
    NSArray *array = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    UIView *weekBg = [[UIView alloc] init];
//    weekBg.backgroundColor = [UIColor orangeColor];
    weekBg.frame = CGRectMake(0,0, self.frame.size.width, itemH+5);
    [self addSubview:weekBg];
//分割线
    UIView *topWeek = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    topWeek.backgroundColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0];
    [weekBg addSubview:topWeek];
    
    UILabel *week;
    for (int i = 0; i < 7; i++) {
        week = [[UILabel alloc] init];
        week.text     = array[i];
        week.font     = [UIFont systemFontOfSize:14];
        week.textColor = [UIColor blackColor];
        week.frame    = CGRectMake(itemW * i, 0, itemW, 32);
        week.textAlignment   = NSTextAlignmentCenter;
        week.backgroundColor = [UIColor clearColor];
      
        [weekBg addSubview:week];
    }
//分割线
    UIView *WeekLine = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(week.frame)-1, self.frame.size.width, 1)];
    WeekLine.backgroundColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0];
    [weekBg addSubview:WeekLine];
    
    //  3.日 (1-31)
    for (int i = 0; i < 42; i++) {
        
        int x = (i % 7) * itemW ;
        int y = (i / 7) * itemH + CGRectGetMaxY(weekBg.frame);
        
        UIButton *dayButton = _daysArray[i];
        dayButton.frame = CGRectMake(x, y+5, itemW, itemH );
//        dayButton.backgroundColor = [UIColor yellowColor];
        dayButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        dayButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        dayButton.layer.cornerRadius = 5.0f;
        [dayButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [dayButton addTarget:self action:@selector(logDate:) forControlEvents:UIControlEventTouchUpInside];
        
        NSInteger daysInLastMonth = [self totaldaysInMonth:[self lastMonth:date]];
        NSInteger daysInThisMonth = [self totaldaysInMonth:date];
        NSInteger firstWeekday    = [self firstWeekdayInThisMonth:date];
        
        NSInteger day = 0;
        
        
        if (i < firstWeekday) {
            day = daysInLastMonth - firstWeekday + i + 1;
            [self setStyleBeyondThisMonth:dayButton];
            
        }else if (i > firstWeekday + daysInThisMonth - 1){
            day = i + 1 - firstWeekday - daysInThisMonth;
            [self setStyleBeyondThisMonth:dayButton];
            
        }else{
            day = i - firstWeekday + 1;
            [self setStyleAfterToday:dayButton];
            
            // 选择的日期 高亮
            if ([self year:date] == self.currentYear && [self month:date] == self.currentMonth && day == self.currentDay && dayButton.enabled == YES) {
                _selectButton = dayButton;
                [self setStyleSeletedToday:dayButton];
            }
            
        }
        
        [dayButton setTitle:[NSString stringWithFormat:@"%li", day] forState:UIControlStateNormal];
        
        // 本月
        if ([self month:date] == [self month:[NSDate date]] && [self year:date] == [self year:[NSDate date]]) {
            
            NSInteger todayIndex = [self day:date] + firstWeekday - 1;
            
            if (i < todayIndex && i >= firstWeekday) {
//                本月 当天之前 不可选
//                [self setStyleBeforeToday:dayButton];
                
            }else if(i ==  todayIndex){
        //  当天  变色
                [self setStyleToday:dayButton];
            }
            
        }

    }
}

#pragma mark - output date
//选择某一天
-(void)logDate:(UIButton *)dayBtn
{
    [self setCancleStyleToday:_selectButton];
    _selectButton = dayBtn;
    [self setStyleSeletedToday:dayBtn];
    
//选择某天传值
//    NSInteger day = [[dayBtn titleForState:UIControlStateNormal] integerValue];
//    
//    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
//    
//    [self.delegate seletedOneDay:day withMonth:[comp month] withYear:[comp year]];
}


#pragma mark - date button style
//本月之后，不可选日期
- (void)setStyleBeyondThisMonth:(UIButton *)btn
{
    btn.enabled = NO;
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}
//本月之前，不可选日期
- (void)setStyleBeforeToday:(UIButton *)btn
{
    btn.enabled = NO;
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
   
}
//今天
- (void)setStyleToday:(UIButton *)btn
{
    btn.enabled = YES;
//    UILabel * redView = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 10, 10)];
//    redView.layer.masksToBounds = YES;
//    redView.layer.cornerRadius =redView.frame.size.width/2.0f;
//    redView.backgroundColor = [UIColor redColor];
//    redView.text =@"今";
//    redView.textAlignment = NSTextAlignmentCenter;
//    redView.textColor = [UIColor whiteColor];
//    redView.font = [UIFont systemFontOfSize:7];
//    [btn addSubview:redView];
    btn.layer.cornerRadius = self.frame.size.height / 16;;
    btn.layer.masksToBounds = YES;
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"今" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}
//今天 选择
- (void)setStyleSeletedToday:(UIButton *)btn
{
    btn.enabled = YES;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = self.frame.size.height / 16;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [btn setBackgroundColor:[UIColor orangeColor]];
    
}
//取消 选择
- (void)setCancleStyleToday:(UIButton *)btn
{
    btn.enabled = YES;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [btn setBackgroundColor:[UIColor whiteColor]];
}
//当月日期
- (void)setStyleAfterToday:(UIButton *)btn
{
    btn.enabled = YES;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}



@end
