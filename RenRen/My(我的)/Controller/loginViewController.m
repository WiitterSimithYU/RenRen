//
//  loginViewController.m
//  RenRen
//
//  Created by tangxiaowei on 16/6/20.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "loginViewController.h"
#import "RAltView.h"
#import "regiseViewController.h"
#import "ForgetCodeVC.h"
@interface loginViewController ()<RAltViewDelegate>
{
    UITextField *phoneTF;
    UITextField *mailTextFiled;
    UIButton *logButton;
    UIButton *platformBtn ;
    UIButton *regBtn;
    UIButton *forgetBtn;
}


@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.edgesForExtendedLayout    = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatUI];
    
    // 返回
    UIButton *button1                     = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame                         = CGRectMake(6, 25 ,30, 30);
    [button1 addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setImage:[UIImage imageNamed:@"back_img1.jpg"] forState:UIControlStateNormal];
    [self.view addSubview:button1];

}
-(void)creatUI
{
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-75, 70, 150, 30)];
    img.image = [UIImage imageNamed:@"ic_welcome_100earn"];
    [self.view addSubview:img];
    
    
    phoneTF =[[UITextField alloc] initWithFrame:CGRectMake(20, img.maxY +30, SCREEN_WIDTH-40, 40*SCREEN_POINT)];
    phoneTF.font = Font(15);
    phoneTF.placeholder =@"请输入手机号码";
    if (UserDefaultObjectForKey(@"phone")) {
        phoneTF.text =UserDefaultObjectForKey(@"phone");
    }
    phoneTF.keyboardType= UIKeyboardTypeNumberPad;
    phoneTF.clearButtonMode= UITextFieldViewModeWhileEditing;
    phoneTF.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:phoneTF];
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(phoneTF.minX, phoneTF.maxY+0.25, phoneTF.boundsWidth, 0.5)];
    lineLabel.backgroundColor = COLOR_LIGHTGRAY;
    [self.view addSubview:lineLabel];
    
    
    mailTextFiled =[[UITextField alloc] initWithFrame:CGRectMake(20, phoneTF.maxY+1, SCREEN_WIDTH-40, 40*SCREEN_POINT)];
    mailTextFiled.font = Font(15);
    mailTextFiled.placeholder =@"请输入密码6-16位";
    if (UserDefaultObjectForKey(@"code")) {
        mailTextFiled.text =UserDefaultObjectForKey(@"code");
    }
    mailTextFiled. secureTextEntry=YES;
    mailTextFiled.clearButtonMode= UITextFieldViewModeWhileEditing;
    mailTextFiled.keyboardType= UIKeyboardTypeASCIICapable;
    mailTextFiled.backgroundColor = [UIColor whiteColor];
    mailTextFiled.userInteractionEnabled=YES;
    [self.view addSubview:mailTextFiled];
    
    
    UIView *choseView = [[UIView alloc]initWithFrame:CGRectMake(20, mailTextFiled.maxY+1, SCREEN_WIDTH-40, 40*SCREEN_POINT)];
    choseView.layer.cornerRadius = 4;
    choseView.clipsToBounds = YES;
    choseView.layer.borderColor = CUSTOMERCLOCR.CGColor;
    choseView.layer.borderWidth = 1;
    [self.view addSubview:choseView];
    
    UILabel *headlabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5*SCREEN_POINT, 130, 30*SCREEN_POINT)];
    headlabel.text = @"请选择登录平台:";
    headlabel.font = Font(15);
    [choseView addSubview:headlabel];
    
    platformBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    platformBtn.frame = CGRectMake(headlabel.maxX, 5, choseView.boundsWidth-headlabel.maxX, 30*SCREEN_POINT);
    [platformBtn setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
    [platformBtn setImageEdgeInsets:UIEdgeInsetsMake(5, choseView.boundsWidth-headlabel.maxX-20*SCREEN_POINT, 5, 5)];
    NSArray *titArr =[NSArray arrayWithObjects:@"人人转",@"轻松转",@"凤凰转",@"万家转",@"家家转",@"全心转",@"全速转",@"全球转",@"天天转", nil];
    NSInteger inde = [DATATYPE integerValue];
    [platformBtn setTitle:titArr[inde-1] forState:UIControlStateNormal];
    [platformBtn addTarget:self action:@selector(platformBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [platformBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    platformBtn.titleLabel.font = Font(15);
    [choseView addSubview:platformBtn];
    
    
    // 登陆按钮
    logButton=[UIButton buttonWithType:UIButtonTypeCustom];
    logButton.frame= CGRectMake(20, mailTextFiled.maxY+60*SCREEN_POINT, SCREEN_WIDTH-40, 40*SCREEN_POINT);
    logButton.backgroundColor =CUSTOMERCLOCR;
    logButton.layer.cornerRadius=3;
    [logButton setTitle:@"登陆" forState:UIControlStateNormal];
    logButton.titleLabel.font =Font(16);
    [logButton addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logButton];
    
    UILabel *shulabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-0.25, logButton.maxY+20*SCREEN_POINT, 0.5, 30)];
    shulabel.backgroundColor = COLOR_LIGHTGRAY;
    [self.view addSubview:shulabel];
    
    regBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    regBtn.frame= CGRectMake(shulabel.minX-80, shulabel.minY, 60, 30);
    [regBtn setTitle:@"注册账号" forState:UIControlStateNormal];
    [regBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    regBtn.titleLabel.font =Font(14);
    [regBtn addTarget:self action:@selector(regiclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:regBtn];
    
    forgetBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    forgetBtn.frame= CGRectMake(shulabel.maxX+20, shulabel.minY, 60, 30);
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    forgetBtn.titleLabel.font =Font(14);
    [forgetBtn addTarget:self action:@selector(forgetclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    
}
// 注册
-(void)regiclick
{
    regiseViewController *vc = [[regiseViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//忘记密码
-(void)forgetclick
{
    ForgetCodeVC *vc = [[ForgetCodeVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)backBtn:(UIButton*)sender
{
  self.navigationController.navigationBar.hidden = NO;
  [self.navigationController popToRootViewControllerAnimated:YES];
}
//平台点击方法
-(void)platformBtnClick:(UIButton*)sender
{
    [self.view endEditing:YES];
    [[RAltView shareInstance]showAlt:@"选择登录平台" style:RAltViewStylePlatForm WithArr:nil];
    [RAltView shareInstance].delegate = self;
}
#pragma mark====ralatdelegate
-(void)rAltView:(RAltView *)altView withIndex:(NSInteger)index WithTitle:(NSString *)title
{
    [platformBtn setTitle:title forState:UIControlStateNormal];
    DLog(@"------%ld",index);
    NSString *platformString =[NSString stringWithFormat:@"%ld",index];
    DLog(@"------%@",platformString);
    UserDefaultSetObjectForKey(platformString, @"platform");

    
}
//获取用户信息
-(void)loginClick
{
    if (![NSString isMobileNumber:phoneTF.text]) {
        [MBProgressHUD showMessage:@"请输入正确格式的手机号"];
        
        return ;
    }
    [MBProgressHUD showIndicator];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:phoneTF.text forKey:@"username"];
    [dic setObject:mailTextFiled.text forKey:@"password"];
    [[AFEngine share] requestPostMethodURL:[NSString stringWithFormat:@"%@%@&dataType=%@",BASE_URL,POST_LOGIN,DATATYPE] parameters:dic withVC:self success:^(NSURLSessionDataTask *task, id responseObj){

        [MBProgressHUD hideHUD];
         if ([responseObj[@"state"] isEqual:@"fail"]) {
             [MBProgressHUD showError:@"用户名或密码错误"];
         }
         else{

             // 存储用户信息
             LWAccount *account = [LWAccount mj_objectWithKeyValues:responseObj];
             account.codeSting = mailTextFiled.text;
             [LWAccountTool saveAccount:account];
             
             UserDefaultSetObjectForKey(account.q_tel, @"phone");
             UserDefaultSetObjectForKey(account.codeSting, @"code");
             
             NSString *datestring = [RTool dateToString:[NSDate date]];
             UserDefaultSetObjectForKey(datestring, @"date");
             
             //6.18增加
             NSString *dateTime = [RTool dateToString:[NSDate date]];
             UserDefaultSetObjectForKey(dateTime, @"dateTime");
             
            self.navigationController.navigationBar.hidden = NO;
            [self.tabBarController setSelectedIndex:1];
            [self.navigationController popToRootViewControllerAnimated:NO];
         }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
     [MBProgressHUD hideHUD];
    }];
  
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
