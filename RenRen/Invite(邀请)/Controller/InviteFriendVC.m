//
//  InviteFriendVC.m
//  RenRen
//
//  Created by miaomiaokeji on 16/6/16.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "InviteFriendVC.h"
#import "IntFriendTopView.h"
#import "InviteViewCell.h"
#import "YaoQingFriendModel.h"


@interface InviteFriendVC ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property(nonatomic,strong)UITableView *MT_tableView;
@property(nonatomic,strong)IntFriendTopView *topMenu ;
@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)NSMutableArray *MsortdataArr;
@property(nonatomic,strong)NSMutableArray *TsortdataArr;

@end


static NSString *cellIdentifier = @"cell";

@implementation InviteFriendVC
{
    NSInteger les;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    
    
    [self initWithZhuCheRequest];

}

-(void)initWithCreateUI{

    //顶部导航条
    IntFriendTopView *topMenu = [[IntFriendTopView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 40) selectedItem:^(NSInteger index) {
        NSLog(@"click---------- = %ld",index);
        
        les = index;
       
            [self.MT_tableView reloadData];
        [UIView animateWithDuration:0.5 animations:^{
            
            self.scrollView.contentOffset =CGPointMake(SCREEN_WIDTH *index,0);
        }];
        
    } ];
    
    //默认选择状态
    [topMenu selectIndex:0];
    [self.view addSubview:topMenu];
    
    self.topMenu =topMenu;
    
    self.scrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0 , 104, SCREEN_WIDTH, SCREEN_HEIGHT-104)];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2, 0);
    self.scrollView.pagingEnabled =NO;
    self.scrollView.bounces =NO;
    self.scrollView.showsHorizontalScrollIndicator =NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    self.scrollView.clipsToBounds = YES;
    
    [self.view addSubview:self.scrollView];
    
    for (int i =0; i<2; i++)
    {
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0+SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT-104) style:UITableViewStylePlain];
        tab.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
        tab.dataSource = self;
        tab.delegate   = self;
        tab.tag = i+1;
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.scrollView addSubview:tab];
        
    }
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

        return _MsortdataArr.count;

   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

        InviteViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier ];
        if (!cell) {
            cell = [[InviteViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    
    if (les==0) {
    
        YaoQingFriendModel *ONEModel;
        ONEModel = self.MsortdataArr[indexPath.row];
        
        cell.fenhongLab.text =ONEModel.fh;
        [cell.touxiangIMG sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",ONEModel.headimg]] placeholderImage:[UIImage imageNamed:@"ic_loading_failure"]];
        cell.touxiangIMG.cornerRadius = 20;
        cell.numberLab.text = ONEModel.tel;
        
        cell.timeLab.text = ONEModel.regtime;
        
    }
    
    if (les==1) {
        
        YaoQingFriendModel *ONEModel;
        ONEModel = self.TsortdataArr[indexPath.row];
        
        cell.fenhongLab.text =ONEModel.fh;
        [cell.touxiangIMG sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",ONEModel.headimg]] placeholderImage:[UIImage imageNamed:@"ic_loading_failure"]];
        cell.touxiangIMG.cornerRadius = 20;
        cell.numberLab.text = ONEModel.tel;
        
        cell.timeLab.text = ONEModel.regtime;
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];


}
#pragma mark---scrollViewdelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    CGFloat x = scrollView.contentOffset.x;
    self.topMenu.slider.transform = CGAffineTransformMakeTranslation( x/2, 0);
   
}

#pragma mark - 注册数据请求
-(void)initWithZhuCheRequest{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    
    GRLog(@"----------->>%@",[LWAccountTool account].uid);
    if (![LWAccountTool account].uid) {
        return;
    }else{
        
        [dic setObject:[LWAccountTool account].uid  forKey:@"uid"];
        [dic setValue:[LWAccountTool account].token forKey:@"token"];
       
    }
    
    GRLog(@"----%@",dic);
    
    [[AFEngine share] POST:[NSString stringWithFormat:@"%@%@&dataType=%@",BASE_URL,GETYqPersonList,[LWAccountTool account].dataType] parameters:dic  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject)
     {
         
         GRLog(@"Success: %@", responseObject);
         NSString *message =[responseObject objectForKey:@"status"];
         
         
         if ((NSNull *)message == [NSNull null])
         {
             return ;
         }
         if ([message isEqualToString:@"ok"]) {
            
             NSDictionary *dic;
             dic=[responseObject objectForKey:@"data"];
             GRLog(@"------0-------%@",dic);
             
             if ([(NSNull *)dic isEqual:[NSNull null]]) return;
             
             NSArray *arr;
             NSArray *ARR;
             arr = dic[@"m_sort"];
             ARR = dic[@"t_sort"];
            
             _MsortdataArr= [YaoQingFriendModel mj_objectArrayWithKeyValuesArray:arr];
             _TsortdataArr =[YaoQingFriendModel mj_objectArrayWithKeyValuesArray:ARR];
             
             GRLog(@"-----11111111-----%@,%@",_MsortdataArr,_TsortdataArr);
             [self.MT_tableView reloadData];
             
             if (_MsortdataArr.count) {
                 [self initWithCreateUI];
             }
             
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         GRLog(@"Error: %@", error);
         [MBProgressHUD showMessage:@"网络链接错误!"];
         
     }];
}

#pragma mark - UITableViewDelegate

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
