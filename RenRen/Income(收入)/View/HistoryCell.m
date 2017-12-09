//
//  HistoryCell.m
//  RenRen
//
//  Created by Beyondream on 16/6/21.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "HistoryCell.h"

@implementation HistoryCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
        self.moneyLabel.font = Font(14);
        self.moneyLabel.textAlignment = NSTextAlignmentCenter;
        self.moneyLabel.textColor = CUSTOMERCLOCR;
        [self addSubview:self.moneyLabel];
        
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 79, SCREEN_WIDTH, 1)];
        lineLabel.backgroundColor = COLOR_999;
        [self addSubview:lineLabel];
        
        
        UILabel *shulabel =[[UILabel alloc]initWithFrame:CGRectMake(80, 8, 1.5, 64)];
        shulabel.backgroundColor = UIColorFromRGB(0xe5e5e5);
        [self addSubview:shulabel];
        
        self.title =[[UILabel alloc]initWithFrame:CGRectMake(90, 20, SCREEN_WIDTH-120, 20)];
        self.title.font = Font(15);
        [self addSubview:self.title];
        
        self.readtime =[[UILabel alloc]initWithFrame:CGRectMake(self.title.minX, self.title.maxY, self.title.boundsWidth, 20)];
        self.readtime.textColor = COLOR_888;
        self.readtime.font = Font(15);
        [self addSubview:self.readtime];
    }
    return self;
}
@end
