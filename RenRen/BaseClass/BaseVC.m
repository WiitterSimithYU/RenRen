//
//  BaseVC.m
//  RenRen
//
//  Created by Beyondream on 16/6/15.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "BaseVC.h"

@implementation BaseVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    NSArray * arr = [NSArray arrayWithObjects:UIColorFromRGB(0x1E6DA7),UIColorFromRGB(0xFB4206),UIColorFromRGB(0xA01C03),UIColorFromRGB(0x3A2342),UIColorFromRGB(0x1DA27E),UIColorFromRGB(0xB0251F),UIColorFromRGB(0x1E8999),UIColorFromRGB(0x226BAB),UIColorFromRGB(0x1571AA), nil];
    NSInteger inde =[DATATYPE integerValue]==0?1:[DATATYPE integerValue];
    DLog(@"inde======%ld",inde);
    self.navigationController.navigationBar.barTintColor = arr[inde-1];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.0];
    [self showShadowView];

}
/**
 *  加蒙层
 */
-(void)showShadowView
{
    if (!self.shadowViewUp) {
        
        self.shadowViewUp = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
        self.shadowViewUp.backgroundColor =COLOR(0.92, 0.92, 0.92, 0.2);
        self.shadowViewUp.hidden = YES;
        [KEYWINDOW addSubview:self.shadowViewUp];
        
        self.shadowViewDown = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT -115, SCREEN_WIDTH, 200)];
        self.shadowViewDown.backgroundColor =COLOR(0.92, 0.92, 0.92, 0.2);
        self.shadowViewDown.hidden = YES;
        [KEYWINDOW addSubview:self.shadowViewDown];
    }
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
