//
//  AFEngine.h
//  RenRen
//
//  Created by Beyondream on 16/6/15.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface AFEngine : AFHTTPSessionManager<MBProgressHUDDelegate>
{
    MBProgressHUD *_hudView;
}
@property (nonatomic,assign) BOOL isConnect;

+ (instancetype)share;

-(void)requestPostMethodURL:(NSString *)url parameters:(NSDictionary *)parameters withVC:(UIViewController*)vc  success:(void(^)(NSURLSessionDataTask * task, id  responseObj))success failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;
- (void)requestGetMethodURL:(NSString *)url parameters:(NSDictionary *)parameters withVC:(UIViewController*)vc  success:(void(^)(NSURLSessionDataTask * task, id  responseObj))success failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;


//数据加载
- (void)hudShowLoadingMessage:(NSString *)message;
- (void)hudShowSuccess:(NSString *)message;
- (void)hudShowError:(NSString *)message;
- (void)hudHidden;
- (void)hudHidden:(NSTimeInterval)interal;
- (void)hudHiddenImmediately;
- (void)hudShowMessage:(NSString *)message;

//从父视图中移除
- (void)hudRemoveProgressHud;



@end
