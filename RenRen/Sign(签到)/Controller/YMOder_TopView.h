//
//  YMOder_TopView.h
//  YiMiao
//
//  Created by miaomiaokeji on 15/12/15.
//  Copyright © 2015年 yimiao.tm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMOder_TopView : UIView
-(instancetype)initWithFrame:(CGRect)frame selectedItem:(void (^)(NSInteger index))selectedItem;
@property (nonatomic, copy)void (^selectedItem)(NSInteger index);
- (void)selectIndex:(NSInteger)index;

@end
