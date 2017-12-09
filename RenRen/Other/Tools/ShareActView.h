//
//  ShareActView.h
//  RenRen
//
//  Created by Beyondream on 16/6/23.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^ActivityShareBlock)(NSString *theErrorMessage);

@interface ShareActView : UIActivity

@property (nonatomic,strong) UIImage *shareImage;
@property (nonatomic,copy)NSString *URL;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)ActivityShareBlock shareBlock;
@property (nonatomic,strong)NSArray *getShareArray;

+(ShareActView*)shareInstance;

-(ShareActView*)showWithImage:(UIImage *)shareImage atURL:(NSString *)URL atTitle:(NSString *)title atShareContentArray:(NSArray *)shareContentArray;
@end
