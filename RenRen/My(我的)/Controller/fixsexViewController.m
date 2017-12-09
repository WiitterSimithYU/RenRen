//
//  fixsexViewController.m
//  RenRen
//
//  Created by iOS03 on 16/6/28.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "fixsexViewController.h"
#import "fixSexTableViewCell.h"

@interface fixsexViewController ()
@property (nonatomic,strong) UIImageView     *fixSexImage;//选择图片
@end

@implementation fixsexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0f];
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 88) style:UITableViewStyleGrouped];
    _tableview.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0f];
    _tableview.dataSource=self;
    _tableview.delegate=self;
   self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
//    _tableview.isScrollEnabled=YES;
// _tableview.userInteractionEnabled = NO;
    [_tableview registerClass:[fixSexTableViewCell class] forCellReuseIdentifier:@"centerCell1"];
    [self.view addSubview:_tableview];
//    self.fixSexImage=[UIImageView alloc]init
    //选择图片

    
}
#pragma UITableView的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    fixSexTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"centerCell1" forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[fixSexTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"centerCell1"];
        
    }
   
    

    if (indexPath.row==0) {
        cell.leftLabel.text=@"男";
        if ([[LWAccountTool account].sex isEqualToString:@"1"]) {
            cell.imgView.image=[UIImage imageNamed:[NSString stringWithFormat:@"ic_change_sex_select"]];
        }

    }
    else{
        
        if ([[LWAccountTool account].sex isEqualToString:@"2"]) {
            cell.imgView.image=[UIImage imageNamed:[NSString stringWithFormat:@"ic_change_sex_select"]];
        }

    cell.leftLabel.text=@"女";
        
    }
    
   
    
    //去除默认分割线
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //去掉单元格的点击效果
   cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    //修改性别
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[LWAccountTool account].token forKey:@"token"];
    [dic setObject:[LWAccountTool account].uid forKey:@"uid"];
  [dic setObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1] forKey:@"sex"];
    
    [[AFEngine share] requestPostMethodURL:[NSString stringWithFormat:@"%@%@&dataType=%@",BASE_URL,POST_FIXSEX,DATATYPE] parameters:dic withVC:self success:^(NSURLSessionDataTask *task, id responseObj){
        
        if ([responseObj[@"status"] isEqual:@"fail"])
        {
            [MBProgressHUD showError:responseObj[@"msg"]];
        }
        else{
            
            
            [MBProgressHUD showMessage:@"性别修改成功"];
            LWAccount *account=[LWAccountTool account];
            account.sex=[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
            [LWAccountTool saveAccount:account];
            [_tableview reloadData];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    

    
    
    
}
@end
