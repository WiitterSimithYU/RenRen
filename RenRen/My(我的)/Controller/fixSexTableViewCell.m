//
//  fixSexTableViewCell.m
//  RenRen
//
//  Created by iOS03 on 16/6/29.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "fixSexTableViewCell.h"

@implementation fixSexTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        
        UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH- 30, 18, 12, 12)];
        [self.contentView addSubview:imageView];
        
        self.imgView = imageView;
        
        //创建控件
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 80, 20)];
        label.font=[UIFont systemFontOfSize:15];
        label.textColor=UIColorFromRGB(0x333333);
        
        [self.contentView addSubview:label];
        self.leftLabel = label;

        

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
