//
//  SpreadCell.h
//  MIAOTUI2
//
//  Created by Beyondream on 16/5/18.
//  Copyright © 2016年 miaoMiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ArticalDetailVC;

@interface SpreadCell : UICollectionViewCell

@property (nonatomic, strong) ArticalDetailVC *newsVC;

- (void)setUrlString:(NSString *)urlString WithTitle:(NSString*)title;
@end
