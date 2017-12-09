//
//  EarnMoneyVC.m
//  RenRen
//
//  Created by Beyondream on 16/7/1.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "EarnMoneyVC.h"

@interface EarnMoneyVC ()
@property(nonatomic,strong)UIWebView *web;
@end

@implementation EarnMoneyVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBarHidden = YES;
    _web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _web.scrollView.bounces=NO;
    _web.backgroundColor = [UIColor whiteColor];
    _web.scalesPageToFit = NO;
    [_web loadRequest:[NSURLRequest requestWithURL:self.linkUrl]];
    [self.view addSubview:_web];
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(20, 30, 0, 0);
    [backButton setImage:[UIImage imageNamed:@"back_img"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    backButton.size = CGSizeMake(70, 30);
    // 让按钮的内容往左边偏移10
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    // 让按钮内部的所有内容左对齐
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_web addSubview:backButton];
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
