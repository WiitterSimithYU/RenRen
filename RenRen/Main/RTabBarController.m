//
//  RTabBarController.m
//  RenRen
//
//  Created by Beyondream on 16/6/15.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "RTabBarController.h"
#import "ArticalVC.h"
#import "InComeVC.h"
#import "SignVC.h"
#import "InviteVC.h"
#import "MyVC.h"
#import "RTabBar.h"
#import "RNavigationController.h"
#import "LWAccountTool.h"
#import "RAltView.h"
#import "regiseViewController.h"
#import "loginViewController.h"

#define kPath       [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@interface RTabBarController ()<UITabBarControllerDelegate,RAltViewDelegate>
@property(nonatomic,assign)NSInteger selectedBar;
@end

@implementation RTabBarController

+(void)initialize {
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    //通过appearance统一设置tabbarItem的样式
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

-(void)viewDidLoad {
    [super viewDidLoad];

    
    self.delegate = self;
    //添加子控制器
    [self setChildController:[[ArticalVC alloc] init] title:@"文章" WithNavTitle:@"人人转" image:@"tab_icon_home_normal" selectedImage:@"tab_icon_home_checked"];
    
    [self setChildController:[[InComeVC alloc] init] title:@"收入" WithNavTitle:@"收入" image:@"tab_icon_income_normal" selectedImage:@"tab_icon_income_checked"];
    
    [self setChildController:[[InviteVC alloc] init] title:@"邀请" WithNavTitle:@"邀请" image:@"tab_icon_invite_normal" selectedImage:@"tab_icon_invite_checked"];
    
    [self setChildController:[[SignVC alloc] init] title:@"签到" WithNavTitle:@"每天签到" image:@"tab_icon_sign_normal" selectedImage:@"tab_icon_sign_checked"];
    
    [self setChildController:[[MyVC alloc] init] title:@"我的" WithNavTitle:@"我的" image:@"tab_icon_mine_normal" selectedImage:@"tab_icon_mine_checked"];
    
    //设置tabBar
    [self setValue:[[RTabBar alloc] init] forKey:@"tabBar"];
    
    NSString *datestring = UserDefaultObjectForKey(@"date");
    
    int chaDate = [RTool intervalSinceNow:datestring];
    //判断是否超时或者已经登录
    if ([LWAccountTool isLogin]&&[NetHelp isConnectionAvailable]&&chaDate<1)
    {
        self.selectedIndex = 1;
        
    }
}

/**
 *  初始化子控制器
 *
 *  @param vc            控制器
 *  @param title         名称
 *  @param image         默认图片
 *  @param selectedImage 选中图片
 */
-(void)setChildController:(UIViewController *)vc title:(NSString *)title WithNavTitle:(NSString*)navTitle image:(NSString *)image selectedImage:(NSString *)selectedImage {
    //设置文字和图片
    vc.navigationItem.title = navTitle;
    vc.tabBarItem.title = title;
    [vc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGB(0x1E6DA7),NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    vc.tabBarItem.image = [UIImage imageNamed:image] ;
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //包装一个导航控制器，添加导航控制器为tabbarController的子控制器
    RNavigationController *nav = [[RNavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.barTintColor = UIColorFromRGB(0x1E6DA7);
    [self addChildViewController:nav];
    
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    
    statusBarView.backgroundColor=[UIColor blackColor];
    
    [self.view addSubview:statusBarView];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}
// 判断界面登录
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    DLog(@"-----%@",viewController.tabBarItem.title  );
    if ([viewController.tabBarItem.title  isEqual: @"文章"])
    {
        self.selectedBar = 0;
        [self.tabBarController.viewControllers.lastObject removeFromParentViewController];
        return YES;
        
    }else if ([viewController.tabBarItem.title  isEqual: @"我的"])
    {
        self.selectedBar = 4;
        [self.tabBarController.viewControllers.lastObject removeFromParentViewController];
        return YES;
    }
    else
    {
        NSString *datestring = UserDefaultObjectForKey(@"date");
        
        int chaDate = [RTool intervalSinceNow:datestring];
        if (![LWAccountTool isLogin]||![NetHelp isConnectionAvailable])
        {
            [[RAltView shareInstance]showAlt:@"亲：新用户先注册，老用户先登录" style:RAltViewStyleAlert WithArr:@[@"注册",@"登录"]];
            [RAltView shareInstance].delegate = self;
            return NO;
        }else if (chaDate>=1)
        {
            UIAlertController *alt = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"密码已失效，请重新登录！" preferredStyle:UIAlertControllerStyleAlert];
            [alt addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                loginViewController*vc =  [[loginViewController alloc]init];
                RNavigationController *nav = self.childViewControllers[self.selectedIndex];
                [nav pushViewController:vc animated:YES];
                
            }]];
            [self presentViewController:alt animated:YES completion:nil];
            return NO;
        }
        else
        {
        return YES;
        }
    }

}

-(void)rAltView:(RAltView *)altView withIndex:(NSInteger)index
{
    if (index == 1) {
        DLog(@"======注册");
        [[RAltView shareInstance]remove];
        RNavigationController *nav = self.childViewControllers[self.selectedBar];
        regiseViewController*vc =  [[regiseViewController alloc]init];
        [nav pushViewController:vc animated:YES];
    }else
    {
        DLog(@"-----登录");
        [[RAltView shareInstance]remove];
        loginViewController*vc =  [[loginViewController alloc]init];
        RNavigationController *nav = self.childViewControllers[self.selectedBar];
        [nav pushViewController:vc animated:YES];
    }
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIDeviceOrientationPortrait);
    } else {
        return YES;
    }
}
@end
