//
//  ChangeInforViewController.m
//  Community
//
//  Created by apple on 14-8-3.
//  Copyright (c) 2014年 hylapp.com. All rights reserved.
//
//    更新个人信息

#import "ChangeInforViewController.h"

@interface ChangeInforViewController ()<UITextFieldDelegate>
@property (nonatomic , strong)UITextField*textFile;
@end

@implementation ChangeInforViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.textFile=[[UITextField alloc]initWithFrame:CGRectMake(10, 74, SCREEN_WIDTH-20, 40)];
//    self.textFile.backgroundColor=[UIColor redColor];
    self.textFile.delegate = self;
    self.textFile.placeholder=@"请输入昵称";
    self.textFile.text= [LWAccountTool account].nickName;
    [self.view addSubview:self.textFile];
    
    
    UIButton*saveBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame=CGRectMake(10, 180, SCREEN_WIDTH-20, 50);
    saveBtn.backgroundColor=UIColorFromRGB(0x1E6DA7);
    saveBtn.layer.masksToBounds = YES;
    saveBtn.layer.cornerRadius = 6.0;
    [saveBtn addTarget:self action:@selector(fixNameClick) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.view addSubview:saveBtn];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged) name:UITextFieldTextDidChangeNotification object:nil];


}
-(void)textFieldChanged
{
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}
-(void)fixNameClick
{
//修改昵称
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[LWAccountTool account].token forKey:@"token"];
    [dic setObject:[LWAccountTool account].uid forKey:@"uid"];
     [dic setObject:self.textFile.text forKey:@"nick_name"];
    
    [[AFEngine share] requestPostMethodURL:[NSString stringWithFormat:@"%@%@&dataType=%@",BASE_URL,POST_FIXNAME,DATATYPE] parameters:dic withVC:self success:^(NSURLSessionDataTask *task, id responseObj){
        
        if ([responseObj[@"status"] isEqual:@"fail"])
        {
            [MBProgressHUD showError:responseObj[@"msg"]];
        }
        else{
            
            
            [MBProgressHUD showMessage:@"昵称修改成功"];
            LWAccount *account=[LWAccountTool account];
            account.nickName=self.textFile.text;
            [LWAccountTool saveAccount:account];
             [self.navigationController popViewControllerAnimated:YES];
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];



}
@end