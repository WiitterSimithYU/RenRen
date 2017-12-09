//
//  IntFriendTopView.m
//  RenRen
//
//  Created by miaomiaokeji on 16/6/16.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "IntFriendTopView.h"

#define kTimeinterval      0.5

@interface IntFriendTopView()
{
    UIButton *selectedBtn;
}


@end

@implementation IntFriendTopView



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
    NSArray *titleArray = @[@"注册时间排序",@"分红数排序"];
    
    CGFloat item_w = self.frame.size.width / 2;
    
    for (int i = 0; i<titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(item_w * i, 0, item_w, self.frame.size.height);
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:0.44f green:0.45f blue:0.45f alpha:1.00f] forState:UIControlStateNormal];
        [button setTitleColor:CUSTOMERCLOCR forState:UIControlStateSelected];
        button.titleLabel.font =[UIFont systemFontOfSize:15];
        
        //        [button setBackgroundImage:[UIImage imageNamed:@"classify_topBtn"] forState:UIControlStateNormal];
        button.tag = 10000+i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    
    // 滑块
    UIView *slider = [[UIView alloc]initWithFrame:CGRectMake(3, self.frame.size.height - 1, item_w-6, 1)];
    slider.backgroundColor= CUSTOMERCLOCR;
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
    self.selectedItem(button.tag-10000);
    selectedBtn.selected = NO;
    button.selected = YES;
    selectedBtn = button;
    
    // 移动slider
    [UIView animateWithDuration:kTimeinterval animations:^{
        
        _slider.transform = CGAffineTransformMakeTranslation((button.tag-10000) * button.frame.size.width, 0);
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
