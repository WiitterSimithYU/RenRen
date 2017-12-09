//
//  AFEngine.m
//  RenRen
//
//  Created by Beyondream on 16/6/15.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "AFEngine.h"
#import <RealReachability.h>
@implementation AFEngine

+ (instancetype)shareInstance {
    static AFEngine *_manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[AFEngine alloc]init];
    });
    return _manager;
}

+ (void)requestGetMethodURL:(NSString *)url parameters:(NSDictionary *)parameters uploadPreogerss:(void (^)(NSProgress *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/html",@"text/javascript", nil];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager POST:url parameters:parameters progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            if (dic) {
                success(dic);
            }
        }else {
            [[AFEngine shareInstance]hudShowError:@"请检查网络设置,数据为空"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failure(error);
            DLog(@"error:%@",error);
        }
    }];
}




+ (void)requestPostMethodURL:(NSString *)url parameters:(NSDictionary *)parameters uploadPreogerss:(void (^)(NSProgress *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/html",@"text/javascript", nil];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager POST:url parameters:parameters progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            if (dic) {
                success(dic);
            }
        }else {
            [[AFEngine shareInstance]hudShowError:@"请检查网络设置,数据为空"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            success(error);
            [[AFEngine shareInstance]hudShowError:@"请求失败,请稍后重试"];
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



- (void)hudShowLoadingWithFrame:(CGRect)frame {
    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    [window addSubview:view];
    for(UIView *subViews in window.subviews){
        if (![subViews isKindOfClass:[MBProgressHUD class]]) {
            MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:view];
            hud.delegate        = self;
            [view addSubview:hud];
            [hud show:YES];
            [hud hide:YES afterDelay:30.0f];
            _hudView            = hud;
            
        }
    }
}



- (void)hudShowSuccess:(NSString *)message {
    [_hudView hide:NO];
    UIWindow *window    = [[UIApplication sharedApplication]keyWindow];
    MBProgressHUD *hud  = [[MBProgressHUD alloc]initWithWindow:window];
    [window addSubview:_hudView];
    //hud.customView      = [[UIImageView alloc]initWithImage:[ZFPublic bundleImageName:@"success"]];
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
    //hud.customView     = [[UIImageView alloc]initWithImage:[ZFPublic bundleImageName:@"error"]];
    hud.mode           = MBProgressHUDModeCustomView;
    hud.labelText      = message;
    hud.delegate       = self;
    [hud show:YES];
    [hud hide:YES afterDelay:1.0f];
    _hudView           = hud;
}




- (void)hudHidden {
    [_hudView hide:YES afterDelay:0.50f];
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
