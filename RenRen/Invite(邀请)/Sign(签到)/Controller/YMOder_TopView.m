//
//  YMOder_TopView.m
//  YiMiao
//
//  Created by miaomiaokeji on 15/12/15.
//  Copyright © 2015年 yimiao.tm. All rights reserved.
//

#import "YMOder_TopView.h"
//#import "JLCalendar/JLCalendarItem.h"


#define kTimeinterval      0.5


@interface YMOder_TopView()
{
    UIButton *selectedBtn;
}
@property (nonatomic, weak)UIView *slider;

@end

@implementation YMOder_TopView
-(instancetype)initWithFrame:(CGRect)frame selectedItem:(void (^)(NSInteger index))selectedItem
{
    if (self = [super initWithFrame:frame]) {
        
        [self createItem];
        self.selectedItem = selectedItem;
    }
    
    return self;
}
- (void)createItem
{
    NSArray *titleArray = @[@"上月",@"本月"];
    
    CGFloat item_w = self.frame.size.width /titleArray.count;
    
    for (int i = 0; i<titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(item_w * i, 0, item_w, self.frame.size.height);
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:0.44f green:0.45f blue:0.45f alpha:1.00f] forState:UIControlStateNormal];
        [button setTitleColor:CUSTOMERCLOCR forState:UIControlStateSelected];
        button.titleLabel.font =[UIFont systemFontOfSize:15];
        
//        [button setBackgroundImage:[UIImage imageNamed:@"classify_topBtn"] forState:UIControlStateNormal];
        if (i==0) {
            button.tag =1 +10000;
        }else{
            button.tag =10000;
        }
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    
    UIView *shuView = [[UIView alloc] initWithFrame:CGRectMake(item_w, 0, 1, self.frame.size.height)];
    shuView.backgroundColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0];
    [self addSubview:shuView];
    UIView *bottomLine =[[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
    bottomLine.backgroundColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0];
    [self addSubview:bottomLine];
    
    
    // 滑块
    UIView *slider = [[UIView alloc]initWithFrame:CGRectMake(item_w, self.frame.size.height - 1, item_w, 1)];
    slider.backgroundColor = CUSTOMERCLOCR;
    [self addSubview:slider];
    self.slider = slider;
    
}

- (void)selectIndex:(NSInteger)index
{
    UIButton *button = (UIButton *)[self viewWithTag:index+10000];
    
    [self buttonClick:button];
}
- (void)buttonClick:(UIButton *)button
{
    if (selectedBtn == button) {
        return;
    }
   
    self.selectedItem(button.tag-10000);
    selectedBtn.selected = NO;
    button.selected = YES;
    selectedBtn = button;
    
    // 移动slider
    [UIView animateWithDuration:kTimeinterval animations:^{
        
        _slider.transform = CGAffineTransformMakeTranslation(-(button.tag-10000) * button.frame.size.width, 0);
    }];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
