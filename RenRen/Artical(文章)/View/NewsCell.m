//
//  NewsCell.m
//  MIAOTUI2
//
//  Created by Beyondream on 16/5/19.
//  Copyright © 2016年 miaoMiao. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self CreatUI];
    }
    return self;
}
-(void)CreatUI
{
    self.hdImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 85, 60)];
    [self addSubview:self.hdImageView];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.hdImageView.maxX+10, 8, SCREEN_WIDTH-self.hdImageView.maxX-10-10, 40)];
    self.titleLabel.font = Font(15);
    self.titleLabel.textAlignment = NSTextAlignmentJustified;
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.textColor = UIColorFromRGB(0x333333);
    [self addSubview:self.titleLabel];
    
    //收益
    self.earning = [[UILabel alloc] initWithFrame:CGRectMake(self.hdImageView.maxX+10, 55, 50, 15)];
//    self.earning.text = @"￥0.08";
    self.earning.textColor = [UIColor redColor];
    self.earning.font = Font(15);
//    self.earning.backgroundColor = [UIColor yellowColor];
    [self addSubview:self.earning];
    
    //收益title
    self.earnTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.maxX-70, 55, 50, 15)];
//    self.earnTitle.text = @"高收益";
    self.earnTitle.textColor = [UIColor redColor];
    self.earnTitle.font = Font(15);
    self.earnTitle.textAlignment = NSTextAlignmentRight;
//    self.earnTitle.backgroundColor = [UIColor yellowColor];
    [self addSubview:self.earnTitle];
    
    //横线
    UILabel *linlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 79.5, SCREEN_WIDTH, 0.5)];
    linlabel.backgroundColor = UIColorFromRGB(0xe6e6e6);
    [self addSubview:linlabel];
    
}
+ (NSString *)cellReuseID:(NSString *)newString
{
    return @"xx";
}

+ (CGFloat)cellForHeight:(NSString *)newsString
{
    return 80;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
