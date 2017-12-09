//
//  BanderDealViewController.m
//  YiMiao
//
//  Created by lifei on 14-11-25.
//  Copyright (c) 2014年 hylapp.com. All rights reserved.
//
//    轮播详情

#import "BanderDealViewController.h"

#define kToolbar_H      49
#define kFont           [UIFont systemFontOfSize:17]

@interface BanderDealViewController ()<UIWebViewDelegate,UIAlertViewDelegate>{
     UIActivityIndicatorView *_activityView;
}
/**浏览器*/
@property (nonatomic, strong)UIWebView *webView;

@property(nonatomic,strong)UIButton*loadBtn;

@property(nonatomic,strong)UIView *infoView;

@end

@implementation BanderDealViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 1. 创建webView
    [self setupWebView];
}


- (void)setupWebView
{
    self.webView =[[UIWebView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.webView setUserInteractionEnabled:YES];
    self.webView.dataDetectorTypes = UIDataDetectorTypePhoneNumber;//自动检测网页上的电话号码，单击可以拨打
    
    self.webView.delegate=self;
    self.webView.scalesPageToFit = YES;
    [self.webView setUserInteractionEnabled:YES];
    [self.view addSubview:self.webView];
  
    NSURLRequest *request =[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.htmlString]];
    [self.webView loadRequest:request];
    
    _activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-15, SCREEN_HEIGHT/2-15, 30, 30)];
    _activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    _activityView.hidesWhenStopped = YES;
    [self.view addSubview:_activityView];
    [self.view bringSubviewToFront:_activityView];
}


#pragma mark - UIWebViewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView{
    DLog(@"开始加载webview");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    DLog(@"加载webview完成");
    NSString *theTitle=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//    self.navigationItem.title = theTitle;
    [_activityView stopAnimating];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    DLog(@"加载webview失败%@",error);
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
    infoLabel.text = [NSString stringWithFormat:@"网页暂时无法访问，可能是由于您当地网络原因造成的，请点击“强制刷新”按钮或者更新网络试试"];
    [self.infoView addSubview:infoLabel];

    
}
-(void)requestToLoadAgain
{

    if (![NetHelp isConnectionAvailable]) {
        return;
    }
     [self.infoView removeFromSuperview];
     self.infoView = nil;
     [self.loadBtn removeFromSuperview];
     self.loadBtn = nil;
    NSURLRequest *request =[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.htmlString]];
    [self.webView loadRequest:request];
    
}

//-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    NSString *theTitle=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//    self.navigationItem.title = theTitle;
//    NSLog(@"shouldStartLoadWithRequest:   %@",theTitle);
//    
//    [_activityView startAnimating];
//    return YES;
//}

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
