//
//  AFEngine.m
//  RenRen
//
//  Created by Beyondream on 16/6/15.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "AFEngine.h"
#import <RealReachability.h>
#import <Reachability.h>
#import "LoadImgView.h"
@interface AFEngine ()
@property (nonatomic, strong) Reachability *reachManager;
@end

@implementation AFEngine

static AFEngine *instance = nil;

static NSString *domain  = @"www.baidu.com";

+ (AFEngine*)share{
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        if (!instance) {
            
            instance = [[[self class]alloc]initWithBaseURL:[NSURL URLWithString:APIURL]];
            
            
            
            AFHTTPRequestSerializer * request = [AFHTTPRequestSerializer serializer];
            
            request.timeoutInterval = 60.0f;
            
            [request setValue:@"iphone" forHTTPHeaderField:@"client"];
            
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            
            instance.requestSerializer = request;
            
            AFJSONResponseSerializer *response_serail = [AFJSONResponseSerializer serializer];
            response_serail.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
            
            instance.responseSerializer = response_serail;
            
            
            AFSecurityPolicy *t_policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
            [t_policy setAllowInvalidCertificates:true];
            [t_policy setValidatesDomainName:false];
            instance.securityPolicy = t_policy;
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            [manager setSecurityPolicy:t_policy];
            manager.responseSerializer =[AFHTTPResponseSerializer serializer];
            
        }
    });
    return instance;

}

+(id)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [super allocWithZone:zone];
        }
    });
    return instance;
}

- (BOOL)netEnable {
    if (!_reachManager) {
        _reachManager = [Reachability reachabilityWithHostName:domain];
    }
    return [_reachManager isReachable];
}

- (void)requestPostMethodURL:(NSString *)url parameters:(NSDictionary *)parameters withVC:(UIViewController*)vc  success:(void(^)(NSURLSessionDataTask * task, id  responseObj))success failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure
{
    //判断是否是多页加载
    if (parameters[@"page"]) {
        if ([parameters[@"page"] intValue]<2) {
            
                [self hudShowLoadingVC:vc];
        }
    }
    if (parameters[@"moneynum"])
    {
        [MBProgressHUD showIndicator];
    }
    if ([url containsString:@"apple.php?ac=getHistory"]||[url containsString:@"apple.php?ac=getggy"])
    {
       [MBProgressHUD showIndicator];
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
     [super POST:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
         [MBProgressHUD hideHUD];
        [self hudHidden];
         
            
        success(task,responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [MBProgressHUD hideHUD];
        if (error) {
            [self hudHidden];
            failure(task,error);
            [[AFEngine share]hudShowError:@"请检查网络设置,数据为空"];
        }
    }];

}
- (void)requestGetMethodURL:(NSString *)url parameters:(NSDictionary *)parameters withVC:(UIViewController*)vc  success:(void(^)(NSURLSessionDataTask * task, id  responseObj))success failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [super GET:url parameters:parameters  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (![responseObject[@"status"] isEqualToString:@"fail"]) {
            success(task,responseObject);
         }
        else
        {
            success(task,responseObject);
           // [[AFEngine share]hudShowError:@"请求失败,请稍后重试"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
           [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            failure(task,error);

            [[AFEngine share]hudShowError:@"请检查网络设置,数据为空"];
        }
    }];

}


#pragma mark------------------NetworkRequestStatus----------------begin-----------------------------

- (void)hudShowLoadingMessage:(NSString *)message {
    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    for(UIView *subViews in  window.subviews ) {
        if (![subViews isKindOfClass:[MBProgressHUD class]]) {
            MBProgressHUD *hud  = [[MBProgressHUD alloc]initWithWindow:window];
            hud.delegate        = self;
            hud.labelText       = message;
            [window addSubview:hud];
            [hud show:YES];
            [hud hide:YES afterDelay:30.0f];
            _hudView            = hud;
        }else {
            DLog(@"转动的菊花已经存在了");
        }
    }
}


- (void)hudShowMessage:(NSString *)message{
    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    for(UIView *subViews in  window.subviews ) {
        if (![subViews isKindOfClass:[MBProgressHUD class]]) {
            MBProgressHUD *hud  = [[MBProgressHUD alloc]initWithWindow:window];
            hud.delegate        = self;
            hud.labelText       = message;
            [window addSubview:hud];
            [hud show:YES];
            [hud hide:YES afterDelay:3.0f];
            _hudView            = hud;
        }else {
            DLog(@"转动的菊花已经存在了");
        }
    }
    
}



- (void)hudShowLoadingVC:(UIViewController*)vc {
    CGRect imgFrame =CGRectMake(SCREEN_WIDTH/2-15, SCREEN_HEIGHT/2-100, 30, 30);
    [[LoadImgView shareInstance]show:imgFrame withVC:vc];

}



- (void)hudShowSuccess:(NSString *)message {
    [_hudView hide:NO];
    UIWindow *window    = [[UIApplication sharedApplication]keyWindow];
    MBProgressHUD *hud  = [[MBProgressHUD alloc]initWithWindow:window];
    [window addSubview:_hudView];
    hud.mode            = MBProgressHUDModeCustomView;
    hud.delegate        = self;
    hud.labelText       = message;
    [hud show:YES];
    [hud hide:YES afterDelay:1.50f];
    _hudView = hud;
    
}

- (void)hudShowError:(NSString *)message {
    
    [_hudView hide:NO];
    UIWindow *window   = [[UIApplication sharedApplication]keyWindow];
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithWindow:window];
    [window addSubview:hud];
    hud.mode           = MBProgressHUDModeCustomView;
    hud.labelText      = message;
    hud.delegate       = self;
    [hud show:YES];
    [hud hide:YES afterDelay:1.0f];
    _hudView           = hud;
}




- (void)hudHidden {
    [[LoadImgView shareInstance]hiden];
    [_hudView hide:YES afterDelay:10.0f];
}

- (void)hudHiddenImmediately {
    
    [_hudView hide:YES afterDelay:0];
}

- (void)hudHidden:(NSTimeInterval)interal {
    
    [_hudView hide:YES afterDelay:interal];
}

- (void)hudRemoveProgressHud {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    for (UIView *subViews in window.subviews ) {
        if ([subViews isKindOfClass:[MBProgressHUD class]]) {
            MBProgressHUD *hud = (MBProgressHUD *)subViews;
            [hud removeFromSuperViewOnHide];
            hud                =nil;
        }
        
    }
}

@end
