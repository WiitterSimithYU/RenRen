//
//  LoadImgView.h
//  RenRen
//
//  Created by Beyondream on 16/6/20.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadImgView : UIView

+(LoadImgView*)shareInstance;

-(void)show:(CGRect)frame withVC:(UIViewController*)vc;
-(void)hiden;

@end
