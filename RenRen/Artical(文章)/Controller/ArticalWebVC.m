//
//  ArticalWebVC.m
//  RenRen
//
//  Created by Beyondream on 16/6/16.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "ArticalWebVC.h"
#import "NJKWebViewProgressView.h"
#import "CodeShareView.h"
#import "ShareActView.h"

@interface ArticalWebVC ()<UIWebViewDelegate, NJKWebViewProgressDelegate>
{
    NJKWebViewProgressView *_progressView;
}
@property(nonatomic,strong)UIWebView *web;

@property(nonatomic,strong)UIButton*loadBtn;

@property(nonatomic,strong)UIView *infoView;

@property(nonatomic,strong)NJKWebViewProgress *progressProxy;

@end

@implementation ArticalWebVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar addSubview:_progressView];
    
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"文章详情";
    _web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-30)];
    _web.backgroundColor = [UIColor whiteColor];
    _web.scalesPageToFit = NO;
    _web.scrollView.scrollEnabled = NO;
    _web.delegate = self;
    [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.linkUrl]]];
    [self.view addSubview:_web];
    //进度
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _web.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    //进度条
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, 5.0)];
    
    //分享
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50);
    [shareBtn setTitle:@"分享赚钱" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shareBtn setBackgroundColor:UIColorFromRGB(0x1E6DA7)];
    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
}
#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_progressView removeFromSuperview];
    
    [self.loadBtn reloadInputViews];
    
    [self.infoView reloadInputViews];
    
    
}
-(void)shareClick:(UIButton*)sender
{
    //要分享的内容，加要一个数组里边，初始化UIActivityViewController
    
    UIImageView *imgView = [[UIImageView alloc]init];
    [imgView sd_setImageWithURL:[NSURL URLWithString:self.imgUrl]];
    
    NSMutableArray *activityItems  = [NSMutableArray array];
    
    NSString *titleStr = [NSString stringWithFormat:@"%@",self.titString];
    
    NSData *imgData = [self findImgInDish:self.imgUrl];
    
    imgView.image = [UIImage imageWithData:imgData];
    
    if (imgView.image&&[NSURL URLWithString:self.linkUrl]) {
        [activityItems addObjectsFromArray:@[titleStr,imgView.image,[NSURL URLWithString:self.linkUrl]]];
    }else
    {
        [activityItems addObjectsFromArray:@[titleStr,[NSURL URLWithString:self.linkUrl]]];
    }
    
    //Activity加到一个数组里边
    //    NSArray *apps = @[[[ShareActView shareInstance] showWithImage:[UIImage imageNamed:@"ic_wechat"] atURL:@"http://www.iashes.com/" atTitle:@"微信朋友" atShareContentArray:activityItems],    [[ShareActView shareInstance] showWithImage:[UIImage imageNamed:@"ic_wxcircle"] atURL:@"http://www.iashes.com/admin.html" atTitle:@"微信朋友圈" atShareContentArray:activityItems],[[ShareActView shareInstance] showWithImage:[UIImage imageNamed:@"ic_copy_link"] atURL:@"http://www.iashes.com/admin.html" atTitle:@"复制链接" atShareContentArray:activityItems]];
    
    //展示
    [UIActivityViewController showShare:self WithItemArr:activityItems WithActivitiesApp:nil];
}
-(void)getTag:(int)tag{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"第%d个图标",tag] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alert show];
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    DLog(@"-----开始加载");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    _web.scrollView.scrollEnabled = YES;
    DLog(@"-----结束加载");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:( NSError *)error
{
    DLog(@"-----加载失败");
    [_progressView removeFromSuperview];
    
    self.loadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loadBtn.frame = CGRectMake(SCREEN_WIDTH/2-75, 130*SCREEN_POINT, 150, 40);
    [self.loadBtn setBackgroundColor:UIColorFromRGB(0x3E9FF7)];
    [self.loadBtn setTitle:@"强制刷新" forState:UIControlStateNormal];
    self.loadBtn.cornerRadius = 5;
    self.loadBtn.clipsToBounds = YES;
    [self.loadBtn addTarget:self action:@selector(requestToLoadAgain) forControlEvents:UIControlEventTouchUpInside];
    [self.loadBtn setTintColor:[UIColor whiteColor]];
    [self.view addSubview:self.loadBtn];
    
    self.infoView = [[UIView alloc]initWithFrame:CGRectMake(50, self.loadBtn.maxY+50, SCREEN_WIDTH-100, 170)];
    self.infoView.layer.borderWidth = 2.0f;
    self.infoView.layer.borderColor =UIColorFromRGB(0x3E9FF7).CGColor;
    [self.view addSubview:self.infoView];
    
    
    UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-120, 150)];
    infoLabel.numberOfLines = 0;
    infoLabel.font = Font(18);
    infoLabel.text = [NSString stringWithFormat:@"网页%@暂时无法访问，可能是由于您当地网络原因造成的，请点击“强制刷新”按钮或者更新网络试试",self.linkUrl];
    [self.infoView addSubview:infoLabel];
    
    
}
-(void)requestToLoadAgain
{
    NSMutableDictionary *dic  =[NSMutableDictionary dictionary];
    [dic setObject:[LWAccountTool account].uid forKey:@"uid"];
    [[AFEngine share] requestGetMethodURL:[NSString stringWithFormat:@"%@%@&dataType=%@",BASE_URL,LOADFAIL,DATATYPE] parameters:nil withVC:self success:^(NSURLSessionDataTask *task, id responseObj)
     {
         
         if ([responseObj[@"status"] isEqualToString:@"ok"])
         {
             [self.infoView removeFromSuperview];
             self.infoView = nil;
             [self.loadBtn removeFromSuperview];
             self.loadBtn = nil;
             [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.linkUrl]]];
             
         }else
         {
             [MBProgressHUD showMessage:responseObj[@"detail"]];
             
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         
     }];
    
}
-(NSData*)findImgInDish:(NSString*)imageURL
{
    NSData *imageData = nil;
    BOOL isExit = [[SDWebImageManager sharedManager] diskImageExistsForURL:[NSURL URLWithString:imageURL]];
    if (isExit) {
        NSString *cacheImageKey = [[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:imageURL]];
        if (cacheImageKey.length) {
            NSString *cacheImagePath = [[SDImageCache sharedImageCache] defaultCachePathForKey:cacheImageKey];
            if (cacheImagePath.length) {
                imageData = [NSData dataWithContentsOfFile:cacheImagePath];
            }
        }
    }
    if (!imageData) {
        imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    }
    return imageData;
}
-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
