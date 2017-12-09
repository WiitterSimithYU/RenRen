//
//  regiseViewController.m
//  RenRen
//
//  Created by tangxiaowei on 16/6/20.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "regiseViewController.h"
#import "CodeButton.h"
#import "RAltView.h"
#import "RTLabel.h"
#import "loginViewController.h"
@interface regiseViewController ()<RAltViewDelegate,RTLabelDelegate>{
    UITextField *phoneTF;
    UITextField *mailTextFiled;
    UIButton *registBtn;
    UITextField *sureTextFiled;
    UIButton *showCodeBtn;
        UIButton *platformBtn ;
}
@property (strong, nonatomic) CodeButton *VerificationButton;

@end

@implementation regiseViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    self.edgesForExtendedLayout    = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 返回
    UIButton *button1                     = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame                         = CGRectMake(6, 25 ,30, 30);
    [button1 addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setImage:[UIImage imageNamed:@"back_img1.jpg"] forState:UIControlStateNormal];
    [self.view addSubview:button1];

    [self creatUI];
    
    [IQKeyboardManager sharedManager].enable = YES;
    
}
#pragma mark -输入框

-(void)creatUI
{
    //头部图片
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-75, 50*SCREEN_POINT, 150, 30)];
    img.image = [UIImage imageNamed:@"ic_welcome_100earn"];
    [self.view addSubview:img];
    //手机号
    phoneTF =[[UITextField alloc] initWithFrame:CGRectMake(20, img.maxY +20*SCREEN_POINT, SCREEN_WIDTH-40, 40*SCREEN_POINT)];
    phoneTF.font = Font(15);
    phoneTF.placeholder =@"手机号";
    phoneTF.keyboardType= UIKeyboardTypeNumberPad;
    phoneTF.clearButtonMode= UITextFieldViewModeWhileEditing;
    phoneTF.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:phoneTF];
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, phoneTF.maxY+0.25, SCREEN_WIDTH-40, 0.5)];
    lineLabel.backgroundColor = COLOR_LIGHTGRAY;
    [self.view addSubview:lineLabel];
    
    //密码
    sureTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(20, phoneTF.maxY+1, SCREEN_WIDTH-90, 40*SCREEN_POINT)];
    sureTextFiled.placeholder =@"密码(6-16个字符)";
    sureTextFiled.clearButtonMode= UITextFieldViewModeWhileEditing;
    sureTextFiled.keyboardType= UIKeyboardTypeASCIICapable;
    sureTextFiled.backgroundColor = [UIColor whiteColor];
    sureTextFiled.font = Font(15);
    sureTextFiled.secureTextEntry = YES;
    sureTextFiled.userInteractionEnabled=YES;
    [self.view addSubview:sureTextFiled];
    
    UILabel *lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(20, sureTextFiled.maxY+0.25, SCREEN_WIDTH-40, 0.5)];
    lineLabel1.backgroundColor = COLOR_LIGHTGRAY;
    [self.view addSubview:lineLabel1];
    
    //短信验证码
    mailTextFiled =[[UITextField alloc] initWithFrame:CGRectMake(20, sureTextFiled.maxY+1, SCREEN_WIDTH-170*SCREEN_POINT, 40*SCREEN_POINT)];
    mailTextFiled.font = Font(15);
    mailTextFiled.placeholder =@"短信验证码";
    mailTextFiled.clearButtonMode= UITextFieldViewModeWhileEditing;
    mailTextFiled.keyboardType= UIKeyboardTypeNumberPad;
    mailTextFiled.backgroundColor = [UIColor whiteColor];
    mailTextFiled.userInteractionEnabled=YES;
    [self.view addSubview:mailTextFiled];
    
    _VerificationButton = [CodeButton buttonWithType:UIButtonTypeCustom];
    _VerificationButton.frame = CGRectMake(SCREEN_WIDTH-130*SCREEN_POINT, mailTextFiled.minY,120*SCREEN_POINT, 40*SCREEN_POINT);
    _VerificationButton.backgroundColor = [UIColor whiteColor];
    [_VerificationButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    _VerificationButton.titleLabel.font =[UIFont boldSystemFontOfSize:14];
    _VerificationButton.timeOut =59;
    [_VerificationButton setTitleColor:UIColorFromRGB(0x6C93BC) forState:UIControlStateNormal];
    [_VerificationButton setTitleEdgeInsets:UIEdgeInsetsMake(10, 40, 10, 10)];
    [_VerificationButton addTarget:self action:@selector(veriButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_VerificationButton];
    
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
    [platformBtn setTitle:@"人人转" forState:UIControlStateNormal];
    [platformBtn addTarget:self action:@selector(platformBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [platformBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    platformBtn.titleLabel.font = Font(15);
    [choseView addSubview:platformBtn];

    
    // 注册按钮
    registBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    registBtn.frame= CGRectMake(20, mailTextFiled.maxY+60*SCREEN_POINT, SCREEN_WIDTH-40, 40*SCREEN_POINT);
    registBtn.backgroundColor =CUSTOMERCLOCR;
    registBtn.layer.cornerRadius=3;
    NSString * titleStr =@"注册";
    [registBtn setTitle:titleStr forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registBtn.titleLabel.font =[UIFont boldSystemFontOfSize:16];
    [registBtn addTarget:self action:@selector(regiclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
    
    
    RTLabel * rtLabel = [[RTLabel alloc]initWithFrame:CGRectMake(0, registBtn.maxY+10, SCREEN_WIDTH, 40)];
    [rtLabel setText:@"<font face='System' size=15></u>点击“注册”即同意 <a href='http://www.baidu.com'>人人大家庭服务条款</a>"];
    rtLabel.delegate = self;
    rtLabel.lineSpacing = 30.0;
    rtLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:rtLabel];
    
    // 注册按钮
    UIButton *loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame= CGRectMake(20, SCREEN_HEIGHT-35*SCREEN_POINT, SCREEN_WIDTH-40, 30*SCREEN_POINT);
    [loginBtn setTitle:@"登录已有账号 >" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = Font(15);
    [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font =[UIFont boldSystemFontOfSize:16];
    [loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];

}
-(void)loginClick
{
    loginViewController *vc = [[loginViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//平台点击方法
-(void)platformBtnClick:(UIButton*)sender
{
    [[RAltView shareInstance]showAlt:@"选择登录平台" style:RAltViewStylePlatForm WithArr:nil];
    [RAltView shareInstance].delegate = self;
}
//富文本delegate
-(void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL *)url
{
    NSLog(@"did select url %@", url);
}
#pragma mark====ralatdelegate
-(void)rAltView:(RAltView *)altView withIndex:(NSInteger)index WithTitle:(NSString *)title
{
    [platformBtn setTitle:title forState:UIControlStateNormal];
    DLog(@"------%ld",index);
}
-(void)veriButton:(CodeButton *)btn
{
    
    if (![NSString isMobileNumber:phoneTF.text]) {
        [MBProgressHUD showMessage:@"请输入正确格式的手机号"];
        
        return ;
    }
    else{
        //获取验证码
       [self GetCode:(CodeButton *)btn];

        
    }
}

#pragma mark -注册按钮事件

-(void)regiclick{
    
    if (mailTextFiled.text.length == 0) {
        [MBProgressHUD showMessage:@"请输入验证码"];
        return ;
    }else if (sureTextFiled.text.length<6||sureTextFiled.text.length>16)
    {
        [MBProgressHUD showError:@"请输入6-16个字符的密码"];
        return;
    }
    //注册
   [self regist];
    
}
-(void)backBtn:(UIButton*)sender
{
    if (self.navigationController.viewControllers.count>2) {
        self.navigationController.navigationBar.hidden = YES;
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        self.navigationController.navigationBar.hidden = NO;
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - 验证码接口请求
- (void) GetCode:(CodeButton *)btn
{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:phoneTF.text forKey:@"mobile"];

    [[AFEngine share] requestPostMethodURL:[NSString stringWithFormat:@"%@%@&dataType=%@",BASE_URL,CodeURL,DATATYPE] parameters:dic withVC:self success:^(NSURLSessionDataTask *task, id responseObj){
        
        if ([responseObj[@"status"] isEqual:@"fail"])
        {
            [MBProgressHUD showError:responseObj[@"msg"]];
        }
        else{

            [btn setTitleEdgeInsets:UIEdgeInsetsMake(10, 0, 10, 10)];
            [btn startCountdown];
            [MBProgressHUD showMessage:@"验证码发送成功"];
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
   
}
-(void)regist
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:phoneTF.text forKey:@"mobile"];
    [dic setObject:sureTextFiled.text forKey:@"password"];
    [dic setObject:mailTextFiled.text forKey:@"code"];

    
    [[AFEngine share] requestPostMethodURL:[NSString stringWithFormat:@"%@%@&dataType=%@",BASE_URL,regURL,DATATYPE] parameters:dic withVC:self  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject)
     {
         
         if (![responseObject[@"status"] isEqualToString:@"fail"]) {

                [MBProgressHUD showSuccess:@"注册成功"];
                 [self.navigationController popViewControllerAnimated:YES];
     
         }else
         {
             [MBProgressHUD showMessage:responseObject[@"msg"]];
         }
    
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     }];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [phoneTF becomeFirstResponder];
}
-(void)viewWillDisappear:(BOOL)animated{
    [phoneTF resignFirstResponder];
    //    [sureTextFiled resignFirstResponder];
    [mailTextFiled resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
