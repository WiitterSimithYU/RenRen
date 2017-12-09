//
//  ShareActView.m
//  RenRen
//
//  Created by Beyondream on 16/6/23.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "ShareActView.h"


@implementation ShareActView

//创建实例
+(ShareActView*)shareInstance
{
 
    ShareActView*  shareAct = [[ShareActView alloc]init];

    return shareAct;
}

//实现copy协议需要实现NSCopying协议
- (id)copyWithZone:(NSZone *)zone
{
    return self;
}
-(ShareActView*)showWithImage:(UIImage *)shareImage atURL:(NSString *)URL atTitle:(NSString *)title atShareContentArray:(NSArray *)shareContentArray
{
    _shareImage = shareImage;
    _URL = URL;
    _title = title;
    _getShareArray = [[NSArray alloc]initWithArray:shareContentArray];
    return self;
}
+(UIActivityCategory)activityCategory
{
    return UIActivityCategoryShare;
}

-(NSString *)activityType
{
    return _title;
}

-(NSString *)activityTitle
{
    return _title;
}

-(UIImage *)activityImage
{
    return _shareImage;
}

-(BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    return YES;
}

- (UIViewController *)activityViewController
{
    return nil;
}

-(void)performActivity
{
    if(nil == _title) {
        return;
    }
    if([_title isEqualToString:@"微信朋友圈"])
    {
     //调用sdk
        
    }else if([_title isEqualToString:@"微信朋友"])
    {
        //调用sdk
    }
}
@end
