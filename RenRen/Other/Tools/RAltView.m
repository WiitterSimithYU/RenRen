//
//  RAltView.m
//  RenRen
//
//  Created by Beyondream on 16/6/17.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "RAltView.h"
#import "STPageControl.h"
#import "RAletViewCell.h"
 RAltView *instance = nil;
 static NSString * indenfier = @"cell";

@interface PlatformItem : NSObject

@property(nonatomic,strong)NSString *platformtit;
@property(nonatomic,assign)BOOL isSelected;
@property(nonatomic,assign)NSInteger platformindex;
@end

@implementation PlatformItem

@end

@interface RAltView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *platformArr;

@property(nonatomic,strong)UITableView *tab;

@end

@implementation RAltView

//创建实例
+(RAltView*)shareInstance
{
    if (!instance) {
        
        instance = [[RAltView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20)];
        instance.backgroundColor =COLOR(0.92, 0.92, 0.92, 0.5);
    }
    return instance;
}
//增加锁
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    @synchronized (self) {
        if (!instance) {
            instance = [super allocWithZone:zone];
        }
    }
    return instance;
}
//实现copy协议需要实现NSCopying协议
- (id)copyWithZone:(NSZone *)zone
{
    return self;
}
//创建弹出框
-(void)showAlt:(NSString*)title style:(RAltViewStyle)style WithArr:(NSArray*)arr
{
    [KEYWINDOW addSubview:instance];
    UITapGestureRecognizer *tapgesture =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(instanceClick:)];
    [instance addGestureRecognizer:tapgesture];
    
    if (style == RAltViewStyleTab)
    {
        [self setupChooseMoney:title];
        
    }else if (style == RAltViewStyleAlert)
    {
        [self setUpViewWithRegAndLog:title WithArr:arr];
    }else if (style == RAltViewStylePlatForm)
    {
        [self setUpViewWithPlatForm:title];
    }else if (style ==RAltViewStyleNormal)
    {
        [self setUpViewWithAlt:title  WithArr:arr];
    }
}
//普通提示框
-(void)setUpViewWithAlt:(NSString*)title WithArr:(NSArray*)arr
{

    UIView * alt = [[UIView alloc]initWithFrame:CGRectMake(25, SCREEN_HEIGHT/2-90 , SCREEN_WIDTH-50, 180)];
    alt.backgroundColor = [UIColor whiteColor];
    alt.tag = 1000;
    [KEYWINDOW addSubview:alt];

    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, alt.boundsWidth-30, 20)];
    titleLabel.textColor = UIColorFromRGB(0x2ca6d7);
    titleLabel.font = Font(17);
    titleLabel.text = title;
    [alt addSubview:titleLabel];
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, titleLabel.maxY+10, alt.boundsWidth, 2)];
    lineLabel.backgroundColor = UIColorFromRGB(0x2ca6d7);
    [alt addSubview:lineLabel];
    
    UILabel *infoLabel  =[[UILabel alloc]initWithFrame:CGRectMake(15, lineLabel.maxY, alt.boundsWidth-30, alt.boundsHeight - lineLabel.maxY-41)];
    //infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.numberOfLines = 0;
    infoLabel.font = Font(17);
    infoLabel.text = arr[0];
    [alt addSubview:infoLabel];
    
    UILabel *lineLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, alt.boundsHeight-41, alt.boundsWidth, 1)];
    lineLabel2.backgroundColor = COLOR_LIGHTGRAY;
    [alt addSubview:lineLabel2];
    
    UIButton*sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame= CGRectMake(0, alt.boundsHeight-40, titleLabel.boundsWidth, 40);
    [sureBtn setTitle:@"我知道了" forState:UIControlStateNormal];
    [sureBtn setTitleColor:COLOR_333 forState:UIControlStateNormal];
    sureBtn.titleLabel.font =Font(16);
    [sureBtn addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(remove)]];
    [alt addSubview:sureBtn];
 
}
//选择金额
-(void)setupChooseMoney:(NSString*)title
{
    UIView * alt = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-110*SCREEN_POINT, 20+SCREEN_HEIGHT/2+10-160, 220*SCREEN_POINT, 220)];
    alt.tag = 1000;
    alt.layer.cornerRadius = 10;
    alt.clipsToBounds = YES;
    alt.backgroundColor = [UIColor whiteColor];
    [KEYWINDOW addSubview:alt];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, alt.boundsWidth-40, 40)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = Font(16);
    titleLabel.text = title;
    [alt addSubview:titleLabel];
    NSArray *titleArr = [NSArray arrayWithObjects:@"30元",@"60元",@"120元",@"180元", nil];
    for (int i =0; i<4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 40+45*i, alt.boundsWidth, 45);
        [btn setTitleColor:CUSTOMERCLOCR forState:UIControlStateNormal];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.tag = 100+i;
        [btn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choseClick:)]];
        [alt addSubview:btn];
        
        if (i>0&&i<4) {
            UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 40+45*i, SCREEN_WIDTH-20, 0.5)];
            lineLabel.backgroundColor = COLOR_LIGHTGRAY;
            [alt addSubview:lineLabel];
        }
    }

}
//登陆注册
-(void)setUpViewWithRegAndLog:(NSString*)title WithArr:(NSArray*)arr
{
    
    UIView * alt = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-140*SCREEN_POINT, 20+SCREEN_HEIGHT/2+10-60, 280*SCREEN_POINT, 120)];
    alt.tag = 1000;
    alt.layer.cornerRadius = 10;
    alt.clipsToBounds = YES;
    alt.backgroundColor = [UIColor whiteColor];
    [KEYWINDOW addSubview:alt];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, alt.boundsWidth-40, 30)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = Font(16);
    titleLabel.text = title;
    [alt addSubview:titleLabel];
    
    UIButton *regBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [regBtn setTitle:arr[0] forState:UIControlStateNormal];
    [regBtn setTitleColor:UIColorFromRGB(0x1E6DA7) forState:UIControlStateNormal];
    regBtn.frame = CGRectMake(20, alt.boundsHeight - 50, alt.boundsWidth/2-40, 35);
    regBtn.layer.cornerRadius = 7.5;
    regBtn.clipsToBounds = YES;
    regBtn.titleLabel.font = Font(15);
    regBtn.layer.borderColor = UIColorFromRGB(0x1E6DA7).CGColor;
    regBtn.layer.borderWidth = 1;
    regBtn.tag = 1;
    [regBtn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(instanceClick:)]];
    [alt addSubview:regBtn];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(regBtn.maxX +40, alt.boundsHeight - 50, alt.boundsWidth/2-40, 35);
    loginBtn.titleLabel.font = Font(15);
    [loginBtn setTitle:arr[1] forState:UIControlStateNormal];
    [loginBtn setTintColor:[UIColor whiteColor]];
    loginBtn.layer.cornerRadius = 7.5;
    loginBtn.clipsToBounds = YES;
    loginBtn.backgroundColor = UIColorFromRGB(0x1E6DA7);
    loginBtn.tag = 2;
    [loginBtn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(instanceClick:)]];
    [alt addSubview:loginBtn];

}
//选择平台
-(void)setUpViewWithPlatForm:(NSString*)title
{
    self.platformArr = [NSMutableArray array];
    NSArray *titArr =[NSArray arrayWithObjects:@"人人转",@"轻松转",@"凤凰转",@"万家转",@"家家转",@"全心转",@"全速转",@"全球转",@"天天转", nil];
    NSInteger inde = [DATATYPE integerValue];
    for (int i =0; i<titArr.count; i++)
    {
        PlatformItem *item = [[PlatformItem alloc]init];
        item.platformtit = titArr[i];
        if (i==inde-1) {
            item.isSelected = YES;
        }else
        {
            item.isSelected = NO;
        }
        item.platformindex = i;
        
        [self.platformArr addObject:item];
    }
    UIView * alt = [[UIView alloc]initWithFrame:CGRectMake(25, 20+50 , SCREEN_WIDTH-50, SCREEN_HEIGHT-160)];
    alt.backgroundColor = [UIColor whiteColor];
    alt.tag = 1000;
    [KEYWINDOW addSubview:alt];
    
    UIImageView *headimg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 8, 44, 44)];
    headimg.image = [UIImage imageNamed:@"ic_launcher"];
    [alt addSubview:headimg];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(headimg.maxX+10, 15, alt.boundsWidth-100, 30)];
    titleLabel.textColor = UIColorFromRGB(0x2ca6d7);
    titleLabel.font = Font(20);
    titleLabel.text = title;
    [alt addSubview:titleLabel];
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, titleLabel.maxY+15, alt.boundsWidth, 2)];
    lineLabel.backgroundColor = UIColorFromRGB(0x2ca6d7);
    [alt addSubview:lineLabel];
    
    
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0, lineLabel.maxY, alt.boundsWidth, alt.boundsHeight-lineLabel.maxY-60) style:UITableViewStyleGrouped];
    self.tab.backgroundColor= [UIColor whiteColor];
    self.tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tab.delegate =self;
    self.tab.dataSource = self;
    [alt addSubview:self.tab];
    
    [self.tab registerClass:[RAletViewCell class] forCellReuseIdentifier:indenfier];
    
    UIButton*sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame= CGRectMake(0, alt.boundsHeight-60, self.tab.boundsWidth, 60);
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font =Font(16);
    [sureBtn addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sureBtnclick:)]];
    [alt addSubview:sureBtn];
}

-(void)showTitleWithContent:(NSString *)ContentStr style:(RAltViewStyle)style
{
    [KEYWINDOW addSubview:instance];
    UITapGestureRecognizer *tapgesture =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(instanceClick:)];
    [instance addGestureRecognizer:tapgesture];
    
    UIView * alt = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-140*SCREEN_POINT, 20+SCREEN_HEIGHT/2+10-100, 280*SCREEN_POINT, 200)];
    alt.tag = 1000;
    alt.layer.cornerRadius = 10;
    alt.clipsToBounds = YES;
    alt.backgroundColor = [UIColor whiteColor];
    [KEYWINDOW addSubview:alt];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, alt.boundsWidth-40, 30)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.text = @"重要通知";
    titleLabel.textColor = [UIColor redColor];
    [alt addSubview:titleLabel];
    
    UILabel *contentLab = [UILabel new];
    contentLab.frame = CGRectMake(30, titleLabel.bottom + 20,alt.boundsWidth-60 , 60);
    contentLab.font = Font(14);
    contentLab.numberOfLines = 0;
    contentLab.text = ContentStr;
    contentLab.textColor = UIColorFromRGB(0x444444);
    [alt addSubview:contentLab];
    
    UIButton *knowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [knowBtn setTitle:@"我知道了" forState:UIControlStateNormal];
    [knowBtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    knowBtn.frame = CGRectMake(0, alt.boundsHeight - 50, alt.boundsWidth, 35);
    knowBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [knowBtn addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(knowClick)]];
    [alt addSubview:knowBtn];

}

-(void)knowClick
{
    if (_delegate && [_delegate respondsToSelector:@selector(rAltView:withDate:)]) {
        [_delegate rAltView:self withDate:nil];
    }
    
    [self remove];
}

#pragma mark-----tablViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.platformArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RAletViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indenfier forIndexPath:indexPath];
    if (!cell) {
        cell = [[RAletViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indenfier];
    }
    
    [cell.selectBtn addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectedClick:)]];
    PlatformItem *platformItem = self.platformArr[indexPath.row];
    cell.txtlabel.text = platformItem.platformtit;

    cell.selectBtn.selected = platformItem.isSelected;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)selectedClick:(UIGestureRecognizer*)gesture
{
    //刚选中
    RAletViewCell*cell = (RAletViewCell*)gesture.view.superview.superview;
    NSIndexPath *inde = [self.tab indexPathForCell:cell];
    for (int i=0; i<self.platformArr.count; i++)
    {
        PlatformItem *item = self.platformArr[i];
        if (inde.row==i)
        {
            item.isSelected = YES;
        }else
        {
            item.isSelected = NO;
        }
    }
    [self.tab reloadData];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (int i=0; i<self.platformArr.count; i++)
    {
        PlatformItem *item = self.platformArr[i];
        if (indexPath.row==i)
        {
            item.isSelected = YES;
        }else
        {
            item.isSelected = NO;
        }
    }
     [self.tab reloadData];
}
//确定
-(void)sureBtnclick:(UITapGestureRecognizer*)gesture
{
    if ([self.delegate respondsToSelector:@selector(rAltView:withIndex:WithTitle:)])
    {
        PlatformItem * itm =  [[PlatformItem alloc]init];
        for (int i=0; i<self.platformArr.count; i++)
        {
            PlatformItem *item = self.platformArr[i];
            if (item.isSelected ==YES) {
                itm = item;
            }
        }
        [self.delegate rAltView:self withIndex:itm.platformindex+1 WithTitle:itm.platformtit];
        [self remove];
    }

}
// 阴影点击方法
-(void)instanceClick:(UITapGestureRecognizer*)gesture
{
    if ([gesture.view isKindOfClass:[UIButton class]])
    {
        if ([self.delegate respondsToSelector:@selector(rAltView:withIndex:)]) {
            
            [self.delegate rAltView:self withIndex:gesture.view.tag];
            
        }
    }
        [self remove];

}
// 金额选项
-(void)choseClick:(UITapGestureRecognizer*)gesture
{
    if ([gesture.view isKindOfClass:[UIButton class]])
    {
        if ([self.delegate respondsToSelector:@selector(rAltView:withIndex:)]) {
            
            [self.delegate rAltView:self withIndex:gesture.view.tag-99];
            
        }
        
    }
    [self remove];

}
//移除
-(void)remove
{
    UIView *alt = (UIView*)[KEYWINDOW viewWithTag:1000];
    [alt removeFromSuperview];
    alt = nil;
    [instance removeFromSuperview];
    instance = nil;
}
@end
