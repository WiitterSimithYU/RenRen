//
//  ForgetCodeVC.m
//  RenRen
//
//  Created by Beyondream on 16/6/28.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "ForgetCodeVC.h"
#import "CodeButton.h"
@interface ForgetCodeVC ()
{
    UITextField *phoneTF;
    UITextField *mailTextFiled;
    UIButton *registBtn;
    UITextField *sureTextFiled;
    UITextField *codeTextFiled;
}
@property (strong, nonatomic) CodeButton *VerificationButton;
@end

@implementation ForgetCodeVC

- (void)viewDidLoad {
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
-(void)creatUI
{
    //手机号
    phoneTF =[[UITextField alloc] initWithFrame:CGRectMake(20, 60*SCREEN_POINT, SCREEN_WIDTH-40, 40*SCREEN_POINT)];
    phoneTF.font = Font(15);
    phoneTF.placeholder =@"手机号";
    phoneTF.keyboardType= UIKeyboardTypeNumberPad;
    phoneTF.clearButtonMode= UITextFieldViewModeWhileEditing;
    phoneTF.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:phoneTF];
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, phoneTF.maxY+0.25, SCREEN_WIDTH-40, 0.5)];
    lineLabel.backgroundColor = COLOR_LIGHTGRAY;
    [self.view addSubview:lineLabel];
    
    //短信验证码
    mailTextFiled =[[UITextField alloc] initWithFrame:CGRectMake(20, phoneTF.maxY+1, SCREEN_WIDTH-170, 40*SCREEN_POINT)];
    mailTextFiled.font = Font(15);
    mailTextFiled.placeholder =@"验证码";
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
    [_VerificationButton setTitleColor:UIColorFromRGB(0x6C93BC)  forState:UIControlStateNormal];
    [_VerificationButton setTitleEdgeInsets:UIEdgeInsetsMake(10, 40, 10, 10)];
    [_VerificationButton addTarget:self action:@selector(veriButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_VerificationButton];
    
    
    UILabel *lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(20, mailTextFiled.maxY+0.25, SCREEN_WIDTH-40, 0.5)];
    lineLabel1.backgroundColor = COLOR_LIGHTGRAY;
    [self.view addSubview:lineLabel1];
    
    //密码
    sureTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(20, mailTextFiled.maxY+1, SCREEN_WIDTH-40, 40*SCREEN_POINT)];
    sureTextFiled.placeholder =@"输入新密码";
    sureTextFiled.clearButtonMode= UITextFieldViewModeWhileEditing;
    sureTextFiled.keyboardType= UIKeyboardTypeASCIICapable;
    sureTextFiled.backgroundColor = [UIColor whiteColor];
    sureTextFiled.font = Font(15);
    sureTextFiled.secureTextEntry = YES;
    sureTextFiled.userInteractionEnabled=YES;
    [self.view addSubview:sureTextFiled];

    //确认密码
    UILabel *lineLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(20, sureTextFiled.maxY+0.25, SCREEN_WIDTH-40, 0.5)];
    lineLabel2.backgroundColor = COLOR_LIGHTGRAY;
    [self.view addSubview:lineLabel2];
    
    //密码
    codeTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(20, sureTextFiled.maxY+1, SCREEN_WIDTH-40, 40*SCREEN_POINT)];
    codeTextFiled.placeholder =@"再次输入新密码";
    codeTextFiled.clearButtonMode= UITextFieldViewModeWhileEditing;
    codeTextFiled.keyboardType= UIKeyboardTypeASCIICapable;
    codeTextFiled.backgroundColor = [UIColor whiteColor];
    codeTextFiled.font = Font(15);
    codeTextFiled.secureTextEntry = YES;
    codeTextFiled.userInteractionEnabled=YES;
    [self.view addSubview:codeTextFiled];
    
    UILabel *lineLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(20, codeTextFiled.maxY+0.25, SCREEN_WIDTH-40, 0.5)];
    lineLabel3.backgroundColor = COLOR_LIGHTGRAY;
    [self.view addSubview:lineLabel3];
    
    // 注册按钮
    registBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    registBtn.frame= CGRectMake(20, codeTextFiled.maxY+40, SCREEN_WIDTH-40, 40*SCREEN_POINT);
    registBtn.backgroundColor =CUSTOMERCLOCR;
    registBtn.layer.cornerRadius=3;
    NSString * titleStr =@"重置密码";
    [registBtn setTitle:titleStr forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registBtn.titleLabel.font =[UIFont boldSystemFontOfSize:16];
    [registBtn addTarget:self action:@selector(regiclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
}
-(void)veriButton:(CodeButton *)btn
{
    
//    if (![phoneTF.text isValidateMobile]) {
//        [MBProgressHUD showMessage:@"请输入正确格式的手机号"];
//        
//        return ;
//    }
    if (![NSString isMobileNumber:phoneTF.text]) {
         [MBProgressHUD showMessage:@"请输入正确格式的手机号"];
    }
    
    else{
        //获取验证码
        [self GetCode:(CodeButton *)btn];
        [mailTextFiled becomeFirstResponder];
        
    }
}
#pragma mark - 验证码接口请求
- (void) GetCode:(CodeButton *)btn
{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:phoneTF.text forKey:@"mobile"];
    
    [[AFEngine share] requestPostMethodURL:[NSString stringWithFormat:@"%@%@&dataType=%@",BASE_URL,findCode,DATATYPE] parameters:dic withVC:self success:^(NSURLSessionDataTask *task, id responseObj){
        
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
#pragma mark -注册按钮事件

-(void)regiclick{
    
    if (mailTextFiled.text.length == 0) {
        [MBProgressHUD showMessage:@"请输入验证码"];
        return ;
    }else if (sureTextFiled.text.length<6||sureTextFiled.text.length>16)
    {
        [MBProgressHUD showError:@"请输入6-16个字符的密码！"];
        return;
    }else if (![codeTextFiled.text isEqualToString:sureTextFiled.text])
    {
        [MBProgressHUD showError:@"两次输入密码不一致！"];
        return;
    }
    //注册
    [self regist];
    
}
-(void)regist
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:phoneTF.text forKey:@"mobile"];
    [dic setObject:sureTextFiled.text forKey:@"password"];
    [dic setObject:mailTextFiled.text forKey:@"code"];
    
    [[AFEngine share] requestPostMethodURL:[NSString stringWithFormat:@"%@%@&dataType=%@",BASE_URL,changeCode,DATATYPE] parameters:dic withVC:self  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject)
     {
         if ([responseObject[@"status"] isEqualToString:@"fail"])
         {
             [MBProgressHUD showMessage:@"请求错误，请稍候再试"];
             
         }else {
                [MBProgressHUD showMessage:@"修改密码成功"];
                 [self.navigationController popViewControllerAnimated:YES];
             }

         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

     }];
    
}

//返回
-(void)backBtn:(UIButton*)sender
{
    self.navigationController.navigationBar.hidden = YES;
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
