//
//  CodeButton.h
//  RenRen
//
//  Created by tangxiaowei on 16/6/20.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CodeButton : UIButton
@property (nonatomic) int timeOut; // 设置超时时间
-(void)startCountdown;// 倒计时
-(void)addTarget:(id)target action:(SEL)action;
@end
