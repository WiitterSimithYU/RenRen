//
//  UIActivityViewController+ShareView.h
//  RenRen
//
//  Created by Beyondream on 16/6/23.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActivityViewController (ShareView)

//菊花转动
+ (void)showShare:(UIViewController*)VC WithItemArr:(NSArray*)itemArr WithActivitiesApp:(NSArray*)appArr;

@end
