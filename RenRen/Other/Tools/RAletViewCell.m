//
//  RAletViewCell.m
//  RenRen
//
//  Created by Beyondream on 16/6/28.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "RAletViewCell.h"

@implementation RAletViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UILabel *linelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 49.5, SCREEN_WIDTH-50, 0.5)];
        linelabel.tag = 100;
        linelabel.backgroundColor = COLOR_LIGHTGRAY;
        [self.contentView addSubview:linelabel];
        //选中按钮
        self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.selectBtn.frame = CGRectMake(SCREEN_WIDTH-100, 15, 20, 20);
        [self.selectBtn setImage:[UIImage imageNamed:@"dotdefault-ico"] forState:UIControlStateNormal];
        [self.selectBtn setImage:[UIImage imageNamed:@"dotopt-ico"] forState:UIControlStateSelected];

        [self.contentView addSubview:self.selectBtn];
        
        self.txtlabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 100, 30)];
        self.txtlabel.font = Font(17);
        [self.contentView addSubview:self.txtlabel];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
