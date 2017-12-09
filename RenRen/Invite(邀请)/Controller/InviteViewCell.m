//
//  InviteViewCell.m
//  RenRen
//
//  Created by miaomiaokeji on 16/6/18.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "InviteViewCell.h"

@implementation InviteViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self InitCreate];
    }
    return self;
}

-(void)InitCreate{

    UIView *diChengView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    diChengView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:diChengView];
    
    UIView *topLINE = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    topLINE.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    [diChengView addSubview:topLINE];
    
    UIView *bottomLINE = [[UIView alloc] initWithFrame:CGRectMake(0, diChengView.frame.size.height-0.5, SCREEN_WIDTH, 0.5)];
    bottomLINE.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    [diChengView addSubview:bottomLINE];
    
    
//标题
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(25, 10, 55, 20)];
    titleLab.text = @"累计分红";
    titleLab.font = Font(13);
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor =[UIColor colorWithWhite:0.5 alpha:1.0];
    titleLab.backgroundColor = [UIColor whiteColor];
    [diChengView addSubview:titleLab];
//分红
    UILabel * fenhongLab = [[UILabel alloc] initWithFrame:CGRectMake(30, 30, 50, 20)];
    fenhongLab.text = @"+0.50";
    fenhongLab.font = Font(13);
    fenhongLab.textAlignment = NSTextAlignmentCenter;
    fenhongLab.textColor = CUSTOMERCLOCR;
    fenhongLab.backgroundColor = [UIColor whiteColor];
    [diChengView addSubview:fenhongLab];
    self.fenhongLab =fenhongLab;
//分割线
    UIView *LINEView=[[UIView alloc] initWithFrame:CGRectMake(100, 10, 0.5, diChengView.frame.size.height-20)];
    LINEView.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    [diChengView addSubview:LINEView];
//头像
    UIImageView *touxiangIMG = [[UIImageView alloc] initWithFrame:CGRectMake(120, 10, 40, 40)];
    touxiangIMG.backgroundColor = [UIColor greenColor];
    [diChengView addSubview:touxiangIMG];
    
    self.touxiangIMG = touxiangIMG;
//号码
    UILabel * numberLab = [[UILabel alloc] initWithFrame:CGRectMake(180, 10, SCREEN_WIDTH-190, 15)];
    numberLab.text = @"18756572996";
    numberLab.textColor = [UIColor colorWithRed:56/255.f green:56/255.f blue:56/255.f alpha:1.0];
    numberLab.font = Font(15);
    numberLab.backgroundColor = [UIColor whiteColor];
    [diChengView addSubview: numberLab];
    self.numberLab = numberLab;
//时间
    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(180, diChengView.frame.size.height -25 , SCREEN_WIDTH-190, 15)];
    timeLab.text = @"16-06-18";
    timeLab.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    timeLab.font = Font(15);
    timeLab.backgroundColor = [UIColor whiteColor];
    [diChengView addSubview:timeLab];
    self.timeLab = timeLab;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
