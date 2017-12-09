//
//  JLCalendarScrollView.h
//  JLCustomCalendar
//
//  Created by eall_linger on 16/5/11.
//  Copyright © 2016年 eall_linger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLCalendarItem.h"

@protocol JLCalendarScrollViewDeleagte <NSObject>

- (void)seletedOneDay:(NSInteger )day withMonth:(NSInteger )month withYear:(NSInteger )year;
- (void)monthOnclick:(NSInteger)lastOrNext;
- (void)yearOnclick:(NSInteger)lastOrNext;

@end

@interface JLCalendarScrollView : UIView <UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,JLCalendarItemDelegate>

@property (nonatomic,assign)NSInteger currentDay;
@property (nonatomic,assign)NSInteger currentMonth;
@property (nonatomic,assign)NSInteger currentYear;
@property (nonatomic,assign)id <JLCalendarItemDelegate>delegate;


@property (nonatomic, strong) NSMutableArray *signArray;//签到
@property (nonatomic,strong) NSString *passStr;//传值判断

@end
