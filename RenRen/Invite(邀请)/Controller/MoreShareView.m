//
//  ShareView.m
//  RenRenShare
//
//  Created by 余晓辉 on 16/6/16.
//  Copyright © 2016年 yuxiaohui. All rights reserved.
//

#import "MoreShareView.h"


@implementation MoreShareView

-(void)awakeFromNib
{
    self.frame = [[UIScreen mainScreen] bounds];
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.2];
    self.shareView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 170);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCount)];
    [self addGestureRecognizer:tap];
}

-(void)tapCount{

    [self close];
}


+(instancetype)creatXib
{
    return [[[NSBundle mainBundle]loadNibNamed:@"MoreShareView" owner:nil options:nil]lastObject];
}

-(void)show
{
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self];
    [UIView animateWithDuration:0.2f animations:^{
        
        self.shareView.frame = CGRectMake(0, self.frame.size.height - 170, self.frame.size.width, 170);
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)close
{
    [UIView animateWithDuration:0.3f animations:^{
        
        self.shareView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 170);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


- (IBAction)buttonClose:(id)sender {
    
    [self close];
}

- (IBAction)ClickBtn:(UIButton*)sender {
    
//    GRLog(@"---1");
    
    self.getTouch((int)sender.tag);
    [self close];
}





@end
