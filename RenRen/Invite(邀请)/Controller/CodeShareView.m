//
//  CodeShareView.m
//  AlertController
//
//  Created by 余晓辉 on 16/6/17.
//  Copyright © 2016年 CocoaHCX. All rights reserved.
//

#import "CodeShareView.h"
#import <QuartzCore/QuartzCore.h>


#define   KCloseBtn_W  [UIScreen mainScreen].bounds.size.width * 20/320
#define   kdistance    [UIScreen mainScreen].bounds.size.width *25/320
#define   kdichengV_H  [UIScreen mainScreen].bounds.size.width *280/408
#define   kGetDistance [UIScreen mainScreen].bounds.size.height *30/568
#define   kTOUxiang    SCREEN_HEIGHT * 18/568

@interface CodeShareView ()

@property(nonatomic,strong)UIView *showview;

@end


@implementation CodeShareView
{
    UIImageView *CodeIMG;
    UIView *baseView;
    UIWindow * window;
    UIView *IMGpianView;//保存名片图片
    
}
-(instancetype)init{

    self = [super init];
    if (self) {

        window = [UIApplication sharedApplication].keyWindow;
        baseView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        baseView.backgroundColor =[[UIColor blackColor]colorWithAlphaComponent:0.4];
        [window addSubview:baseView];
        
        self.showview =  [[UIView alloc]init];

        self.showview.frame = CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT/2-50, 50, 50);
        
        self.showview.backgroundColor = [UIColor clearColor];
        
        [UIView animateWithDuration:0.3f animations:^{
           [self initCreateUI];
        }];
        
        
    }
    return self;
}

-(void)initCreateUI{
//最底层 view
   
    self.showview.frame = CGRectMake(20, 80, SCREEN_WIDTH-40, SCREEN_HEIGHT-160);
    self.showview.backgroundColor = [UIColor whiteColor];
    self.showview.alpha = 1.0f;
    self.showview.layer.cornerRadius = 5;
    self.showview.layer.masksToBounds = YES;
    [window addSubview:self.showview];
   
//底层view
    UIView *dichengView = [[UIView alloc] initWithFrame:CGRectMake(30, 30, self.showview.frame.size.width - 60, self.showview.frame.size.height-110)];
    dichengView.backgroundColor =[UIColor colorWithRed:255/255 green:230/255.f blue:216/255.f alpha:1.0];
    [self.showview addSubview:dichengView];
    
//退出XX
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(self.showview.frame.size.width-kdistance, 5, KCloseBtn_W, KCloseBtn_W);
    [closeBtn setImage:[UIImage imageNamed:@"ic_qrcode_close"] forState:UIControlStateNormal];
    closeBtn.backgroundColor = [UIColor clearColor];
    [closeBtn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.showview addSubview:closeBtn];
    
//保存图片名片
    IMGpianView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,dichengView.frame.size.width, dichengView.frame.size.height -kGetDistance)];
    IMGpianView.backgroundColor = [UIColor colorWithRed:255/255 green:230/255.f blue:216/255.f alpha:1.0];
    [dichengView addSubview: IMGpianView];
    
    
//顶部IMG
    UIImageView *topIMG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, dichengView.frame.size.width, dichengView.frame.size.width*130/436)];
    topIMG.image = [UIImage imageNamed:@"ic_qrcode_head_bg"];
    topIMG.backgroundColor = [UIColor clearColor];
    [IMGpianView addSubview:topIMG];

    //个人信息
    UIImageView *touxiangIMG;//名片头像
    NSString *headStr = [LWAccountTool account].headImg;
   touxiangIMG = [[UIImageView alloc] initWithFrame:CGRectMake(20, kTOUxiang, 40*5/6, 40*5/6)];
    [touxiangIMG sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",headStr]] placeholderImage:[UIImage imageNamed:@"ic_default_face_ybz"]];
    touxiangIMG.backgroundColor = [UIColor clearColor];
    [IMGpianView addSubview:touxiangIMG];
   
    UILabel *numberLab;//名片号码
    numberLab = [[UILabel alloc] initWithFrame:CGRectMake(60, kTOUxiang, dichengView.frame.size.width-20-40-10, 15)];
    numberLab.text = [LWAccountTool account].q_tel;
    numberLab.backgroundColor = [UIColor clearColor];
    numberLab.textColor = [UIColor whiteColor];
    numberLab.font = [UIFont systemFontOfSize:15];
    [IMGpianView addSubview:numberLab];
    
    UILabel *shuomingLab = [[UILabel alloc] initWithFrame:CGRectMake(60, kTOUxiang + 40 * 5/6 -15, dichengView.frame.size.width-20-40, 15)];
    shuomingLab.backgroundColor = [UIColor clearColor];
    shuomingLab.textColor = [UIColor whiteColor];
    shuomingLab.text = @"邀请你到人人大家庭一起赚钱";
    shuomingLab.font = [UIFont systemFontOfSize:13];
    [IMGpianView addSubview:shuomingLab];
    
    
    UIView *codeView =[[UIView alloc] initWithFrame:CGRectMake(20, 10+topIMG.frame.size.height, dichengView.frame.size.width-40, dichengView.frame.size.width-40)];
    codeView.backgroundColor = [UIColor whiteColor];
    [IMGpianView addSubview:codeView];
 //二维码扫描
    
    CodeIMG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, codeView.frame.size.width, codeView.frame.size.width)];
    CodeIMG.backgroundColor = [UIColor orangeColor];
    [CodeIMG sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.CodeUrl]] placeholderImage:nil];
    [codeView addSubview:CodeIMG];
    
    UILabel *shaoLab = [[UILabel alloc] initWithFrame:CGRectMake(0, dichengView.frame.size.height-kGetDistance, dichengView.frame.size.width, 20)];
    shaoLab.backgroundColor = [UIColor  clearColor];
    shaoLab.text = @"扫描二维码";
    shaoLab.font = Font(15);
    shaoLab.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    shaoLab.textAlignment = NSTextAlignmentCenter;
    [dichengView addSubview:shaoLab];
//
    UIButton *baochengBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    baochengBtn.backgroundColor = [UIColor colorWithRed:0.f green:125/255.f blue:190/255.f alpha:1.0];
    baochengBtn.frame = CGRectMake(30, self.showview.frame.size.height-70, self.showview.frame.size.width-60, 40) ;
    [baochengBtn setTitle:@"保存到手机" forState:UIControlStateNormal];
    [baochengBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    baochengBtn.layer.cornerRadius= 5;
    baochengBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [baochengBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.showview addSubview:baochengBtn];
    
    UILabel *shuoLab = [[UILabel alloc] initWithFrame:CGRectMake(30, self.showview.frame.size.height-20, self.showview.frame.size.width-60, 10)];
    shuoLab.text = @"将图片发送给好友,邀请注册";
    shuoLab.textColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    shuoLab.textAlignment = NSTextAlignmentCenter;
    shuoLab.font = [UIFont systemFontOfSize:17];
    [self.showview addSubview:shuoLab];
    
}
-(void)setCodeUrl:(NSString *)CodeUrl{
    _CodeUrl = CodeUrl;
    [self initCreateUI];
    [self setNeedsDisplay];
}

//保存到手机
-(void)buttonClick{
    //保存当前view到手机相册
    UIGraphicsBeginImageContext(IMGpianView.frame.size);
    [IMGpianView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *ViewIMg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(ViewIMg, nil, nil, nil);
    [self closeClick];//关闭弹出框
    [MBProgressHUD showMessage:@"名片保存成功!"];
}


//关闭弹出框
-(void)closeClick{

    [self.showview removeFromSuperview];
    [baseView removeFromSuperview];
}


@end
