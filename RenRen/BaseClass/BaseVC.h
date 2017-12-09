//
//  BaseVC.h
//  RenRen
//
//  Created by Beyondream on 16/6/15.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseVC : UIViewController

@property(nonatomic,strong)UIView *shadowViewUp;

@property(nonatomic,strong)UIView *shadowViewDown;
/**
 *  加蒙层
 */
-(void)showShadowView;

@end
