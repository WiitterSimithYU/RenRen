//
//  MyVC.m
//  RenRen
//
//  Created by Beyondream on 16/6/15.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "MyVC.h"
#import "wodeTableViewCell.h"
#import "regiseViewController.h"//注册页面
#import "loginViewController.h"//登录页面
#import "RAltView.h"
#import "fixViewController.h"//已经登录区头点击事件
#import "BanderDealViewController.h"

@interface MyVC ()<RAltViewDelegate>
{
    NSString *mNssStr;
}

#define kPath       [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]
@property(nonatomic,strong)NSArray *titleArr;//我的界面标题数组
@property(nonatomic,strong)NSArray *imageArr;//我的界面图片数组
@property(nonatomic)int  dataNumber;//监测平台

@end

@implementation MyVC
-(void)viewWillAppear:(BOOL)animated
{
    if ([DATATYPE isEqualToString:@"1"]) {
        _dataNumber=1;
    }
    else{
    _dataNumber=0;
    
    }
  [super viewWillAppear:animated];
   [_tableview reloadData];
    
    //本地缓存
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
                       NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                       
                       NSLog(@"files :%ld",[files count]);
                       
                       mNssStr = [NSString stringWithFormat:@"%ldM",[files count]];
                       
             
                   }
                   );
    NSString*str;
    if ([LWAccountTool isLogin]) {
        str=[NSString stringWithFormat:@"发布文章"];
    }
    else{
        str=[NSString stringWithFormat:@"联系客服"];
    }
    
    
    if (_dataNumber==1) {
        NSArray * arr1 =@[@"消息通知",@"赚钱攻略"];
        NSArray * arr3 =@[@"ic_mine_msg",@"ic_mine_raiders"];
        NSArray * arr2 =@[str,@"清除缓存",@"关于我们"];
        NSArray * arr4 =@[@"ic_mine_service",@"ic_mine_clean",@"ic_mine_aboutus"];
        _imageArr=@[arr3,arr4];
        
        _titleArr=@[arr1,arr2];
    }
    else{
        NSArray * arr1 =@[@"消息通知",@"赚钱攻略"];
        NSArray * arr3 =@[@"ic_mine_msg",@"ic_mine_raiders"];
        NSArray * arr2 =@[@"清除缓存",@"关于我们"];
        NSArray * arr4 =@[@"ic_mine_clean",@"ic_mine_aboutus"];
        _imageArr=@[arr3,arr4];
        
        _titleArr=@[arr1,arr2];
        
    }
    
    



}
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([DATATYPE isEqualToString:@"1"]) {
        _dataNumber=1;
    }
    else{
        _dataNumber=0;
        
    }

    self.view.backgroundColor=[UIColor whiteColor];
    self.title = @"我的";
    
    NSString*str;
    if ([LWAccountTool isLogin]) {
        str=[NSString stringWithFormat:@"发布文章"];
    }
    else{
        str=[NSString stringWithFormat:@"联系客服"];
    }
    
    
    if (_dataNumber==1) {
        NSArray * arr1 =@[@"消息通知",@"赚钱攻略"];
        NSArray * arr3 =@[@"ic_mine_msg",@"ic_mine_raiders"];
        NSArray * arr2 =@[str,@"清除缓存",@"关于我们"];
        NSArray * arr4 =@[@"ic_mine_service",@"ic_mine_clean",@"ic_mine_aboutus"];
        _imageArr=@[arr3,arr4];
        
        _titleArr=@[arr1,arr2];
    }
    else{
        NSArray * arr1 =@[@"消息通知",@"赚钱攻略"];
        NSArray * arr3 =@[@"ic_mine_msg",@"ic_mine_raiders"];
        NSArray * arr2 =@[@"清除缓存",@"关于我们"];
        NSArray * arr4 =@[@"ic_mine_clean",@"ic_mine_aboutus"];
        _imageArr=@[arr3,arr4];
        
        _titleArr=@[arr1,arr2];
        
    }
    
    

   
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableview.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    _tableview.dataSource=self;
    _tableview.delegate=self;
    [_tableview registerClass:[wodeTableViewCell class] forCellReuseIdentifier:@"wodeCell"];
    [self.view addSubview:_tableview];
   }
#pragma UITableView的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }
    if (section==1) {
        return 2;
    }
    if (section==2) {
        if (_dataNumber==1) {
            return 3;
        }
        return 2;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    wodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"wodeCell" forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[wodeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"wodeCell"];
        
    }
    if (indexPath.section==1) {
        NSArray*arr1= _titleArr[0];
        NSArray*arr2=_imageArr[0];
        cell.label.text=arr1[indexPath.row];
        cell.bimgView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",arr2[indexPath.row]]];
        
        
    }
    if (indexPath.section==2) {
        NSArray*arr1= _titleArr[1];
        cell.label.text=arr1[indexPath.row];
        NSArray*arr2=_imageArr[1];
        cell.bimgView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",arr2[indexPath.row]]];
        if (_dataNumber==1) {
            if (indexPath.row==0) {
                cell.label1.hidden=YES;
            }
            if (indexPath.row==1) {
                cell.label1.hidden=NO;
                cell.label1.text=mNssStr;
            }
            
        }
        else{
            if (indexPath.row==0) {
                cell.label1.hidden=NO;
                cell.label1.text=mNssStr;
            }else{
            
                cell.label1.hidden=YES;
            }
        
        }
       
    }
      //去除默认分割线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //去掉单元格的点击效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//清除缓存

- (void)clearTmpPics

{
    NSString*str=[NSString stringWithFormat:@"清理%@缓存",mNssStr];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag=0;
    [alert show];
    
    //delegate 可设为nil 表示不响应事件 需按钮响应时必须要设置delegate 并实现下面方法；
   
    
    
}

 - (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
     
     if (buttonIndex == 1) {
//         响应内容
         
         
         [[SDImageCache sharedImageCache] clearDisk];
         
         [[SDImageCache sharedImageCache] clearMemory];//可有可无
         //本地缓存
         
         NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
         NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
         
         NSLog(@"files :%ld",[files count]);
         
         //                       mNssStr = [NSString stringWithFormat:@"%ldM",[files count]];
         mNssStr = [NSString stringWithFormat:@"0M"];
         
         [_tableview reloadData];
         
         
         
         

     }
 }
//自定义区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section

{
    if ([LWAccountTool isLogin]) {
        if (section==0) {
            UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
            view.backgroundColor=[UIColor whiteColor];
            UIImageView*headImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 40, 40)];
           
            [headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[LWAccountTool account].headImg]] placeholderImage:HeadImg]; 
            
            headImg.layer.cornerRadius = 20;
            headImg.clipsToBounds = YES;
            [view addSubview:headImg];
            
            
            UILabel*label1=[[UILabel alloc]initWithFrame:CGRectMake(60, 20, SCREEN_WIDTH-80, 20)];
            label1.textColor=UIColorFromRGB(0x999999);
            if ([LWAccountTool account].nickName.length==0) {
                 label1.text=@"未设置昵称";
                
            }
            else{
            
            label1.text=[LWAccountTool account].nickName ;
            
            }
            
            label1.font=[UIFont systemFontOfSize:17];
            [view addSubview:label1];
            
            
            UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(60, label1.maxY, SCREEN_WIDTH-150, 20)];
            label.textColor=UIColorFromRGB(0x999999);
            label.text=[LWAccountTool account].q_tel;
            label.font=[UIFont systemFontOfSize:17];
            [view addSubview:label];
            UIImageView*image=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-25, 33, 8, 14)];
            image.image=[UIImage imageNamed:[NSString stringWithFormat:@"ic_arrow_right"]];
            [view addSubview:image];
            UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame=CGRectMake(0, 0, SCREEN_WIDTH, 80);
            [button addTarget:self action:@selector(fixloginClick) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button];
            
            return view;
            
            
        }
        if (section==3) {
            UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 66)];
            view.backgroundColor=[UIColor whiteColor];
            UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, 66)];
            label.text=@"退出当前账号";
            label.textColor=UIColorFromRGB(0x999999);
            label.textAlignment=NSTextAlignmentCenter;
            label.font=[UIFont systemFontOfSize:17];
            [view addSubview:label];
            UILabel*label1=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 66)];
            label1.text=@"切换联盟";
            label1.textColor=UIColorFromRGB(0x999999);
            label1.textAlignment=NSTextAlignmentCenter;
            label1.font=[UIFont systemFontOfSize:17];
            [view addSubview:label1];
            
            UIView*view1=[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 8, 0.5, 50)];
            view1.backgroundColor=COLOR_LIGHTGRAY;
            [view addSubview:view1];
            UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame=CGRectMake(0, 0, SCREEN_WIDTH, 66);
            [button addTarget:self action:@selector(quitClick) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button];
            
            return view;
        }
        

        
    }
    else{
        
        if (section==0) {
            UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
            view.backgroundColor=[UIColor whiteColor];
            UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(50, 0, SCREEN_WIDTH, 80)];
            label.text=@"未登录";
            label.textColor=UIColorFromRGB(0x999999);
           label.textColor=UIColorFromRGB(0x999999);
            label.font=[UIFont systemFontOfSize:17];
            [view addSubview:label];
            UIImageView*image=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-25, 33, 8, 14)];
            image.image=[UIImage imageNamed:[NSString stringWithFormat:@"ic_arrow_right"]];
            [view addSubview:image];
            UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame=CGRectMake(0, 0, SCREEN_WIDTH, 80);
            [button addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button];
            
            return view;
            
            
        }
        if (section==3) {
            UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 66)];
            view.backgroundColor=[UIColor whiteColor];
            UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 66)];
            label.text=@"注册账号";
             label.textColor=UIColorFromRGB(0x999999);

            label.textAlignment=NSTextAlignmentCenter;
            label.font=[UIFont systemFontOfSize:17];
            [view addSubview:label];
            UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame=CGRectMake(0, 0, SCREEN_WIDTH, 66);
            [button addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button];
            
            return view;
        }
        

    
    }
    
    
    return nil;

}

//注册点击事件
-(void)registerClick
{
    regiseViewController*regiseVC=[[regiseViewController alloc] init];
    [self.navigationController pushViewController:regiseVC animated:YES];

}
//未登录点击事件
-(void)loginClick
{
    loginViewController*loginVC=[[loginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
    
}

//登录点击事件
-(void)fixloginClick
{
    fixViewController*ficVC=[[fixViewController alloc] init];
    [self.navigationController pushViewController:ficVC animated:YES];
    
}


//退出登录点击事件
-(void)quitClick
{
    [[RAltView shareInstance]showAlt:@"确定退出当前账号吗？" style:RAltViewStyleAlert WithArr:@[@"取消",@"确定"]];
    [RAltView shareInstance].tag=0;
    
    [RAltView shareInstance].delegate = self;
}
-(void)rAltView:(RAltView *)altView withIndex:(NSInteger)index
{
    if (altView.tag==0) {
        if (index==1) {
            
            
            
        }else
        {
            
            loginViewController*loginVC=[[loginViewController alloc] init];
            [self.navigationController pushViewController:loginVC animated:YES];
            if ( [[NSFileManager defaultManager] removeItemAtPath:kPath error:nil])
            {
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isLogin"];
            }
            [_tableview reloadData];
        }

    }
    else{
    if (index==1) {
        
        regiseViewController*vc =  [[regiseViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else
    {
        
        loginViewController*loginVC=[[loginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
        if ( [[NSFileManager defaultManager] removeItemAtPath:kPath error:nil])
        {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isLogin"];
        }
        [_tableview reloadData];
    }
    }
}
//区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    if (section==0) {
        return 80;
    }
    if (section==3) {
        return 66;
    }
    return 0;

}
////自定义区尾
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    return view;

}
//区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==3) {
        return 0;
    }
    
    return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        
    if (indexPath.section == 1) {
        if (indexPath.row==0) {
            BanderDealViewController * dvc =[[BanderDealViewController alloc] init];
           dvc.title=@"消息通知";
            dvc.htmlString=[NSString stringWithFormat:@"%@/apkup/html/notice.php?uid=%@&token=%@&dataType=%@",MY_BASE_URL,[LWAccountTool account].uid,[LWAccountTool account].token,DATATYPE];
           
            [self.navigationController pushViewController:dvc animated:YES];
        }
        if (indexPath.row==1) {
            BanderDealViewController * dvc =[[BanderDealViewController alloc] init];
            dvc.title=@"赚钱攻略";
            dvc.htmlString=[NSString stringWithFormat:@"%@/apkup/html/gl.php?uid=%@&token=%@&dataType=%@",MY_BASE_URL,[LWAccountTool account].uid,[LWAccountTool account].token,DATATYPE];
            
            [self.navigationController pushViewController:dvc animated:YES];
        }

        
    }else if (indexPath.section ==2)
    {
        
        if (_dataNumber==1) {
            
            if (indexPath.row==0) {
                if ([LWAccountTool isLogin]) {
                    BanderDealViewController * dvc =[[BanderDealViewController alloc] init];
                    dvc.title=@"发布文章";
                    dvc.htmlString=[NSString stringWithFormat:@"%@/add.php?uid=%@&token=%@&dataType=%@",MY_BASE_URL,[LWAccountTool account].uid,[LWAccountTool account].token,DATATYPE];
                    
                    [self.navigationController pushViewController:dvc animated:YES];
                }
                else
                {
                    [[RAltView shareInstance]showAlt:@"亲：新用户先注册，老用户先登录" style:RAltViewStyleAlert WithArr:@[@"注册",@"登录"]];
                    [RAltView shareInstance].tag=1;
                    [RAltView shareInstance].delegate = self;
                
                }
                
            }
            if (indexPath.row==1) {
                NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
                
                NSArray * files = [[ NSFileManager defaultManager ] subpathsAtPath :cachPath];
                
                NSLog ( @"cachpath = %@--hhh:%ld" , cachPath,files.count);
                
                for ( NSString * p in files) {
                    
                    NSError * error = nil ;
                    
                    NSString * path = [cachPath stringByAppendingPathComponent :p];
                    
                    if ([[ NSFileManager defaultManager ] fileExistsAtPath :path]) {
                        
                        [[ NSFileManager defaultManager ] removeItemAtPath :path error :&error];
                        
                    }
                    
                }
                //清除缓存
                [self clearTmpPics];

            }
                if (indexPath.row==2) {
                BanderDealViewController * dvc =[[BanderDealViewController alloc] init];
                dvc.title=@"关于我们";
                dvc.htmlString=[NSString stringWithFormat:@"%@/apkup/html/about.php?uid=%@&token=%@&dataType=%@",MY_BASE_URL,[LWAccountTool account].uid,[LWAccountTool account].token,DATATYPE];
                
                [self.navigationController pushViewController:dvc animated:YES];
            }

        }
        else{
            if (indexPath.row==0) {
                NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
                
                NSArray * files = [[ NSFileManager defaultManager ] subpathsAtPath :cachPath];
                
                NSLog ( @"cachpath = %@--hhh:%ld" , cachPath,files.count);
                
                for ( NSString * p in files) {
                    
                    NSError * error = nil ;
                    
                    NSString * path = [cachPath stringByAppendingPathComponent :p];
                    
                    if ([[ NSFileManager defaultManager ] fileExistsAtPath :path]) {
                        
                        [[ NSFileManager defaultManager ] removeItemAtPath :path error :&error];
                        
                    }
                    
                }
                //清除缓存
                [self clearTmpPics];
            }
            if (indexPath.row==1) {
                BanderDealViewController * dvc =[[BanderDealViewController alloc] init];
                dvc.title=@"关于我们";
                dvc.htmlString=[NSString stringWithFormat:@"%@/apkup/html/about.php?uid=%@&token=%@&dataType=%@",MY_BASE_URL,[LWAccountTool account].uid,[LWAccountTool account].token,DATATYPE];
                
                [self.navigationController pushViewController:dvc animated:YES];
            }
            

        
        }
        


        
    }
        
    
    
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
