//
//  InCashVC.m
//  RenRen
//
//  Created by Beyondream on 16/6/20.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "InCashVC.h"
#import "RAltView.h"
#import "HistoryVC.h"
@interface InCashVC ()<UITextFieldDelegate,RAltViewDelegate>
@property(nonatomic,strong) UIScrollView *scrollView;
@end

@implementation InCashVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [IQKeyboardManager sharedManager].enable = YES;
    self.navigationController.navigationBarHidden = NO;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"提现";
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:self.scrollView];
    if (iPhone4) {
        self.scrollView.contentSize = CGSizeMake(0, 480);
    }else
    {
        self.scrollView.scrollEnabled = NO;
    }
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;

    [self creatUI];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}
// UI 布局
-(void)creatUI
{
    NSString *titlestr = self.isWX==YES?@"微信账号":@"支付宝账号";
    NSArray *titleArr = [NSArray arrayWithObjects:titlestr,@"再次输入账号",@"联盟密码",@"收款人姓名",@"可用余额",@"选择提现金额", nil];
    for (int i = 0; i<6; i++) {
        
        UITextField *tf  = [[UITextField alloc]initWithFrame:CGRectMake(20, 15*SCREEN_POINT+(40+5)*i, SCREEN_WIDTH - 40, 40)];
        tf.placeholder = titleArr[i];
        tf.tag = i+1;
        if (i == 0) {
            [tf becomeFirstResponder];
        }
        if (i==2)
        {
            tf.secureTextEntry = YES;
        }
        tf.delegate = self;
        tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(tf.minX, tf.maxY+1, tf.boundsWidth, 1)];
        lineLabel.backgroundColor = COLOR_LIGHTGRAY;
        [self.scrollView addSubview:lineLabel];
        [self.scrollView addSubview:tf];
        
        if (i>3) {
            tf.enabled = NO;
            tf.font = Font(19);
            UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-200, 40)];
            
            tf.rightViewMode = UITextFieldViewModeAlways;
            tf.rightView = bgView;
            
            UILabel *rLabel = [[UILabel alloc]initWithFrame:CGRectMake(bgView.maxX-20, 0, 20, 40)];
            rLabel.textColor = UIColorFromRGB(0xe5e5e5);
            rLabel.text = @"元";
            rLabel.textAlignment = NSTextAlignmentRight;
            [bgView addSubview:rLabel];

            
            UILabel*moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, bgView.boundsWidth-20, 40)];
            moneyLab.font = Font(19);
            moneyLab.textAlignment = NSTextAlignmentRight;
            moneyLab.textColor = CUSTOMERCLOCR;
            [bgView addSubview:moneyLab];
            if (i==4) {
                moneyLab.text = self.leftMoney;
            }else
            {
                
                moneyLab.text = @"30";
                moneyLab.tag = 100;
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(SCREEN_WIDTH-200, tf.minY, 160, tf.boundsHeight);
                btn.backgroundColor = [UIColor clearColor];
                [btn addTarget:self action:@selector(incashClick:)];
                [self.scrollView addSubview:btn];
            }
            
        }
        
    }
    
    //说明
    UILabel *shuomingLabel = [[UILabel alloc]initWithFrame:CGRectMake(20,25*SCREEN_POINT+(40+5)*6, SCREEN_WIDTH-40, 70)];
    shuomingLabel.numberOfLines = 0;
    shuomingLabel.font = Font(14);
    shuomingLabel.textColor = COLOR_999;
    shuomingLabel.text = @"由于提现用户较多，为了能尽快打款，目前系统只支持30元、60元、120元、180元额度选择，支付宝提现收取手续费1元。";
    [self.scrollView addSubview:shuomingLabel];
    
    UIButton *apbtn = [[UIButton alloc]initWithFrame:CGRectMake(20, shuomingLabel.maxY+25*SCREEN_POINT, SCREEN_WIDTH-40, 40)];
    [apbtn setBackgroundColor:CUSTOMERCLOCR];
    [apbtn addTarget:self action:@selector(apBtnClick:)];
    [apbtn setTitle:@"申请提现" forState:UIControlStateNormal];
    [apbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    apbtn.layer.cornerRadius = 5;
    apbtn.clipsToBounds = YES;
    [self.scrollView addSubview:apbtn];
    
}

-(void)incashClick:(UIGestureRecognizer*)getsure
{

    [[RAltView shareInstance]showAlt:@"选择取款金额" style:RAltViewStyleTab WithArr:nil];
    [RAltView shareInstance].delegate = self;
}
#pragma mark----raletDelegate
-(void)rAltView:(RAltView *)altView withIndex:(NSInteger)index
{
    UILabel *label = (UILabel*)[self.view viewWithTag:100];
    switch (index) {
        case 1:
        {
            label.text = @"30";
        }
            break;
        case 2:
        {
            label.text = @"60";
        }
            break;
        case 3:
        {
            label.text = @"120";
        }
            break;
        case 4:
        {
            label.text = @"180";
        }
            break;
            
        default:
            break;
    }
}
#pragma mark ---uitextdelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger Tag = textField.tag;
    if (Tag<=3)
    {
        UITextField *tf = (UITextField*)[self.view viewWithTag:Tag+1];
        [tf becomeFirstResponder];
    }else
    {
        [textField resignFirstResponder];
    }

    return YES;
}
//申请提现
-(void)apBtnClick:(UIButton*)sender
{
    UITextField *nameTF = (UITextField*)[self.view viewWithTag:1];
    if ([nameTF.text isEqualToString:@""]) {
        [MBProgressHUD showMessage:@"请输入账号"];
        return;
    }
    
    UITextField *nameTFOnce = (UITextField*)[self.view viewWithTag:2];
    if ([nameTFOnce.text isEqualToString:@""]) {
        [MBProgressHUD showMessage:@"请两次输入账号"];
       return;
    }
    
    UITextField *codeTF = (UITextField*)[self.view viewWithTag:3];
    if ([codeTF.text isEqualToString:@""]) {
        [MBProgressHUD showMessage:@"请输入联盟密码"];
       return;
    }
    
    UITextField *name = (UITextField*)[self.view viewWithTag:4];
    if ([name.text isEqualToString:@""]) {
        [MBProgressHUD showMessage:@"请收款人姓名"];
        return;
    }
    if (![nameTF.text isEqualToString:nameTFOnce.text])
    {
        [MBProgressHUD showMessage:@"两次账号输入不一致"];
        return;
    }
    //提交数据
    [self requestPostData];
    
}
//键盘下去
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.scrollView endEditing:YES];
}
//提交数据
-(void)requestPostData
{
    NSMutableDictionary *dic  = [NSMutableDictionary dictionary];
    if ([LWAccountTool account].uid &&[LWAccountTool account].token) {
        [dic setObject:[LWAccountTool account].token forKey:@"token"];
        [dic setObject:[LWAccountTool account].uid forKey:@"uid"];
        if (self.isWX==YES) {
           [dic setObject:@"1" forKey:@"type"];
        }else
        {
            [dic setObject:@"0" forKey:@"type"];
        }
        //提款人账号
        UITextField *account = (UITextField*)[self.view viewWithTag:1];
        UITextField *codeTF = (UITextField*)[self.view viewWithTag:3];
        //提款人姓名
        UITextField *name = (UITextField*)[self.view viewWithTag:4];
        UILabel *moneyLabel = (UILabel*)[self.view viewWithTag:100];
        [dic setObject:name.text forKey:@"name"];
        [dic setObject:moneyLabel.text forKey:@"moneynum"];
        [dic setObject:account.text forKey:@"account"];
        [dic setObject:codeTF.text forKey:@"password"];
    }

    [[AFEngine share] requestPostMethodURL:[NSString stringWithFormat:@"%@%@&dataType=%@",BASE_URL,txACtion,DATATYPE] parameters:dic withVC:self success:^(NSURLSessionDataTask *task, id responseObj){
        if ([responseObj[@"msg"] isEqualToString:@"提现成功"])
        {
           [MBProgressHUD showSuccess:responseObj[@"msg"]];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

                HistoryVC *VC = [[HistoryVC alloc]init];
                
                VC.kindStr = @"提现纪录";
                
                [self.navigationController pushViewController:VC animated:YES];
            });


        }else
        {
            [MBProgressHUD showSuccess:responseObj[@"msg"]];
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
