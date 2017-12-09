//
//  CashCell.m
//  RenRen
//
//  Created by Beyondream on 16/6/24.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "CashCell.h"

@implementation CashCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        self.regtimeLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        self.regtimeLab.textColor = COLOR_888;
        self.regtimeLab.numberOfLines = 0;
        self.regtimeLab.textAlignment = NSTextAlignmentCenter;
        self.regtimeLab.font = Font(14);
        [self addSubview:self.regtimeLab];
        
        self.typeLab =[[UILabel alloc]initWithFrame:CGRectMake(self.regtimeLab.maxX, 0, 80, 60)];
        self.typeLab.textColor = COLOR_888;
        self.typeLab.font = Font(14);
        self.typeLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.typeLab];
        
        
        self.moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(self.typeLab.maxX, 0, 50, 60)];
        self.moneyLab.font = Font(14);
        self.moneyLab.numberOfLines = 0;
        self.moneyLab.textAlignment = NSTextAlignmentCenter;
        self.moneyLab.textColor = COLOR_888;
        [self addSubview:self.moneyLab];
        
        
        self.statusLab = [[UILabel alloc]initWithFrame:CGRectMake(self.moneyLab.maxX, 0, SCREEN_WIDTH-self.moneyLab.maxX, 60)];
        self.statusLab.font = Font(14);
        self.statusLab.numberOfLines = 0;
        self.statusLab.textAlignment = NSTextAlignmentCenter;
        self.statusLab.textColor = COLOR_888;
        [self addSubview:self.statusLab];
        
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 59, SCREEN_WIDTH, 1)];
        lineLabel.backgroundColor = COLOR_999;
        [self addSubview:lineLabel];
        
  
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
