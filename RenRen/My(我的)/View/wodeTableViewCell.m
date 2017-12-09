//
//  wodeTableViewCell.m
//  RenRen
//
//  Created by tangxiaowei on 16/6/17.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "wodeTableViewCell.h"

@implementation wodeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //创建控件
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 9, 150, 25)];
        label.font=[UIFont systemFontOfSize:15];
        [self.contentView addSubview:label];
        label.textColor=UIColorFromRGB(0x555555);
        label.font = [UIFont fontWithName:@"Arial" size:15];
        self.label = label;
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-170, 9, 140, 25)];
        label2.font=[UIFont systemFontOfSize:14];
        label2.textAlignment=NSTextAlignmentRight;
        
        label2.textColor=UIColorFromRGB(0x999999);
        [self.contentView addSubview:label2];
        self.label1 = label2;
//        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-70, 9, 140, 25)];
//        label3.font=[UIFont systemFontOfSize:14];
//        label3.textAlignment=NSTextAlignmentRight;
//        
//        label3.textColor=UIColorFromRGB(0x999999);
//        [self.contentView addSubview:label3];
//        self.label3 = label3;

        
        
        
        
        UIImageView*bimagView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 11, 20, 20)];
        [self.contentView addSubview:bimagView];
        
        //        self.bimgView = bimagView;
        //        UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-150, 8, 50, 50)];
        //        [self.contentView addSubview:bimagView];
        
        self.bimgView = bimagView;
        //右边尖头
        UIImageView*image=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-25, 15, 8, 14)];
        image.image=[UIImage imageNamed:[NSString stringWithFormat:@"ic_arrow_right"]];
        [self.contentView addSubview:image];
        
        //创建下划线
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 43.5, SCREEN_WIDTH, 0.5)];
        label1.backgroundColor=UIColorFromRGB(0xe5e5e5);
        [self.contentView addSubview:label1];
        //最右边图片
        
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
