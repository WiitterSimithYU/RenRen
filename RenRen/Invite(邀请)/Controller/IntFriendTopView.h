//
//  IntFriendTopView.h
//  RenRen
//
//  Created by miaomiaokeji on 16/6/16.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntFriendTopView : UIView

@property (nonatomic, strong)UIView *slider;

-(instancetype)initWithFrame:(CGRect)frame selectedItem:(void (^)(NSInteger index))selectedItem;
@property (nonatomic, copy)void (^selectedItem)(NSInteger index);
- (void)selectIndex:(NSInteger)index;

@end
