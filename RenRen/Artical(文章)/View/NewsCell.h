//
//  NewsCell.h
//  MIAOTUI2
//
//  Created by Beyondream on 16/5/19.
//  Copyright © 2016年 miaoMiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCell : UITableViewCell

@property(nonatomic,strong)UIImageView *hdImageView;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *earning;

@property(nonatomic,strong)UILabel *earnTitle;


+ (NSString *)cellReuseID:(NSString *)newString;

+ (CGFloat)cellForHeight:(NSString *)newsString;
@end
