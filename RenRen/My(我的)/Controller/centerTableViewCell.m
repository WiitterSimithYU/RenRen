//
//  centerTableViewCell.m
//  MIAOTUI2
//
//  Created by tangxiaowei on 16/5/25.
//  Copyright © 2016年 miaoMiao. All rights reserved.
//

#import "centerTableViewCell.h"

@implementation centerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor=[UIColor whiteColor];
        //创建控件
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 80, 20)];
        label.font=[UIFont systemFontOfSize:15];
        label.textColor=UIColorFromRGB(0x333333);
        
        [self.contentView addSubview:label];
        self.leftLabel = label;
        //创建控件
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 80, 20)];
        label2.font=[UIFont systemFontOfSize:15];
        label2.textColor=UIColorFromRGB(0x333333);
        [self.contentView addSubview:label2];
        self.bleftLabel = label2;
        
        self.headImgView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-80, 7.5, 45, 45)];
        self.headImgView.hidden = YES;
        
        self.headImgView.clipsToBounds = YES;
        self.headImgView.layer.cornerRadius = 22.5;
        [self.contentView addSubview:self.headImgView];
        
        UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 45, 45)];
        imageView.clipsToBounds = YES;
        imageView.layer.cornerRadius = 22.5;
        [self.headImgView addSubview:imageView];
        
        self.imgView = imageView;
        
        //创建控件
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-180, 15, 150, 20)];
        label1.textColor = UIColorFromRGB(0x808080);
        label1.textAlignment = NSTextAlignmentRight;
        label.font=Font(14);
        [self.contentView addSubview:label1];
        self.rightLabel = label1;
        
        //划线
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
        view.backgroundColor=UIColorFromRGB(0xe6e6e6);
        [self.contentView addSubview:view];
        self.smallView=view;
        //划线大
        UIView*view1=[[UIView alloc]initWithFrame:CGRectMake(0, 59, SCREEN_WIDTH, 0.5)];
        view1.backgroundColor=UIColorFromRGB(0xe6e6e6);
        [self.contentView addSubview:view1];
        self.bigView=view1;
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
