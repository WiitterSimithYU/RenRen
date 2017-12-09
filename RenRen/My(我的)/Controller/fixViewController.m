//
//  fixViewController.m
//  RenRen
//
//  Created by tangxiaowei on 16/6/20.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "fixViewController.h"
#import "centerTableViewCell.h"
#import "ChangeInforViewController.h"
#import "fixsexViewController.h"
#import "ForgetCodeVC.h"
#import "AFURLSessionManager.h"
@interface fixViewController ()
@property (nonatomic,strong) UIImageView     *chuanImage;//用户头像

@end

@implementation fixViewController
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
    [_tableview reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _buffer = [[NSMutableData alloc]init];
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.view.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0f];
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableview.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0f];
    _tableview.dataSource=self;
    _tableview.delegate=self;
    //    _tableview.userInteractionEnabled = NO;
    [_tableview registerClass:[centerTableViewCell class] forCellReuseIdentifier:@"centerCell"];
    [self.view addSubview:_tableview];
    
    _chuanImage = [[UIImageView alloc] init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 60;
        }
        return 45;
    }
    return 60;
    
}
#pragma UITableView的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    centerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"centerCell" forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[centerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"centerCell"];
        
    }
    if (indexPath.section==0) {
        
        if (indexPath.row==0) {
            
            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[LWAccountTool account].headImg]] placeholderImage:HeadImg];
            

            
            cell.headImgView.backgroundColor =UIColorFromRGB(0xf2f2f2);
            cell.headImgView.hidden = NO ;
            cell.bleftLabel.text=@"头像";
            cell.bleftLabel.minY =20;
            cell.leftLabel.hidden=YES;
            cell.bleftLabel.hidden=NO;
            cell.smallView.hidden=YES;
            cell.bigView.hidden=NO;
            //cell的小属性，右边箭头
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
        }
        if (indexPath.row==1) {
            cell.rightLabel.text=[LWAccountTool account].nickName;
            cell.leftLabel.text=@"昵称";
            cell.leftLabel.minY = 12.5;
            //        cell.rightLabel.text=[LWAccountTool account].phone;
            cell.rightLabel.minY = 12.5;
            cell.bleftLabel.hidden=YES;
            cell.leftLabel.hidden=NO;
            cell.smallView.hidden=NO;
            cell.bigView.hidden=YES;
            //cell的小属性，右边箭头
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
        }
        if (indexPath.row==2) {
            if ([[LWAccountTool account].sex isEqualToString:@"1"]) {
                cell.rightLabel.text=@"男";
            }
            else{
                cell.rightLabel.text=@"女";
            }
            
            cell.leftLabel.text=@"性别";
            cell.leftLabel.minY = 12.5;
            //        cell.rightLabel.text=[LWAccountTool account].phone;
            cell.rightLabel.minY = 12.5;
            //            cell.rightLabel.maxX = SCREEN_WIDTH-15;
            cell.bleftLabel.hidden=YES;
            cell.leftLabel.hidden=NO;
            cell.smallView.hidden=NO;
            cell.bigView.hidden=YES;
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        
        
    }
    else{
        
        cell.bleftLabel.text=@"忘记密码";
        cell.bleftLabel.minY =20;
        cell.leftLabel.hidden=YES;
        cell.bleftLabel.hidden=NO;
        cell.smallView.hidden=YES;
        cell.bigView.hidden=NO;
        //cell的小属性，右边箭头
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        
        
    }
    
    //去除默认分割线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //去掉单元格的点击效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

//区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section==0) {
        return 0;
    }
    return 10;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            
            UIActionSheet *choiceSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"从手机相册选择" destructiveButtonTitle:nil otherButtonTitles:@"拍照",nil];
            //            UIActionSheet *a=[UIActionSheet alloc]in
            
            [choiceSheet showInView:self.view];
            DLog(@"我要获取图片啦");
            
        }
        if (indexPath.row==1) {
            ChangeInforViewController *cvc =[[ChangeInforViewController alloc] init];
            cvc.navigationItem.title=@"修改昵称";
            [self.navigationController pushViewController:cvc animated:YES];
        }
        if (indexPath.row==2) {
            fixsexViewController *cvc =[[fixsexViewController alloc] init];
            cvc.navigationItem.title=@"修改性别";
            [self.navigationController pushViewController:cvc animated:YES];
        }
    }
    else{
        
        
        
        ForgetCodeVC *cvc =[[ForgetCodeVC alloc] init];
        cvc.navigationItem.title=@"修改密码";
        [self.navigationController pushViewController:cvc animated:YES];
        
    }
    
    
    
}
//UIActionSheet delegate代理事件
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex == 0){
        [self snapImage];// 从相机
    }else if(buttonIndex ==1){
        [self pickImage];// 从相册
    }
    
    
    
}
- (void) snapImage
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate =self;
    ipc.allowsEditing =YES;
    [self presentViewController:ipc animated:YES completion:nil];
}
-(void)pickImage{
    
    UIImagePickerController *imagePicker = [UIImagePickerController new];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate =self;
    imagePicker.allowsEditing = YES;
    [imagePicker setModalTransitionStyle: UIModalTransitionStyleCrossDissolve ];
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}
#pragma mark - UIimagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    /*
     //返回一个编辑后的图片UIImagePickerControllerEditedImage
     
     UIImage *selectedImage = [info objectForKey:UIImagePickerControllerEditedImage];
     _chuanImage.image = selectedImage;
     [_tableview reloadData];
     NSData *imgdata = [self getImageDataWith:selectedImage];
     //    NSString *encodingImgData = [imgdata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
     [self requestForDetailInformationWithImage:imgdata];//上传图片数据
     */
    //取出选中的图片 ；
    UIImage * image = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
#pragma mark 上传图片
    NSData *data = [self getImageDataWith:image];
 
    NSString *url = [NSString stringWithFormat:@"%@%@&dataType=%@",BASE_URL,POST_FIXHODEIMG,DATATYPE];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"token"]  = [LWAccountTool account].token;
       dic[@"uid"] =[LWAccountTool account].uid;

    [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        [formData appendPartWithFileData:data name:@"img" fileName:fileName mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"status"] isEqualToString:@"fail"]) {
            
        }
        else
        {
        [MBProgressHUD showMessage:@"图片修改成功"];
        LWAccount *account=[LWAccountTool account];
        account.headImg=responseObject[@"msg"];
        [LWAccountTool saveAccount:account];
            
            
            
            [[SDImageCache sharedImageCache] clearDisk];
            
            [[SDImageCache sharedImageCache] clearMemory];//可有可无
            //本地缓存
            
            NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
            NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
            
            NSLog(@"files :%ld",[files count]);

        [_tableview reloadData];
        }

        NSLog(@"上传成功 %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败 %@", error);
    }];
    
    
}
//+(AFHTTPSessionManager*) sessionManager
//{
//    AFHTTPSessionManager* sessinManager=[[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
//    sessinManager.responseSerializer=[AFJSONResponseSerializer serializer];
//
//    // 设置请求头
//    [sessinManager.requestSerializer setValue:@"" forHTTPHeaderField:@"xxx"];
//    [sessinManager.requestSerializer setValue:@"" forHTTPHeaderField:@"xxxx"];
//    // 时间戳
//    NSString *timeInterval = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
//    [sessinManager.requestSerializer setValue:timeInterval forHTTPHeaderField:@"r"];
//    NSString* passWord= [EncryPtionTool GetMd5String:[NSStringstringWithFormat:@"xxx%@%@",timeInterval,kKey]];
//    [sessinManager.requestSerializer setAuthorizationHeaderFieldWithUsername:kAppName password:passWord];
//
//    sessinManager.requestSerializer.timeoutInterval=5.0;
//
//    return sessinManager;
//}

//上传图片
// 将image 转化成nsdata
-(NSData *)getImageDataWith:(UIImage *)image{
    NSData *data =UIImagePNGRepresentation(image);
    
    if (data==nil) {
        data =UIImageJPEGRepresentation(image, 1);
    }
    return data;
}

- (void) requestForDetailInformationWithImage:(NSData *)encodingImgData
{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[LWAccountTool account].token forKey:@"token"];
    [dic setObject:[LWAccountTool account].uid forKey:@"uid"];
    [dic setObject:encodingImgData forKey:@"img"];
    
    [[AFEngine share] requestPostMethodURL:[NSString stringWithFormat:@"%@%@&dataType=%@",BASE_URL,POST_FIXHODEIMG,DATATYPE] parameters:dic withVC:self success:^(NSURLSessionDataTask *task, id responseObj){
        
        if ([responseObj[@"status"] isEqual:@"fail"])
        {
            //            [MBProgressHUD showError:responseObj[@"msg"]];
        }
        else{
            
            
            [MBProgressHUD showMessage:@"头像修改成功"];
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
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
