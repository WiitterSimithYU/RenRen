//
//  centerTableViewCell.h
//  RenRen
//
//  Created by tangxiaowei on 16/6/20.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface centerTableViewCell : UITableViewCell
@property (nonatomic , strong)UILabel *rightLabel,*leftLabel,*bleftLabel;
@property (nonatomic , strong)UIImageView *imgView;
@property (nonatomic , strong)UIView *smallView;//小单元格的线
@property (nonatomic , strong)UIView *bigView;//大单元格的线
@property(nonatomic,strong)UIView *headImgView;

@end
