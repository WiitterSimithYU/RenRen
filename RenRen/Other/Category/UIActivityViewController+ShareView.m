//
//  UIActivityViewController+ShareView.m
//  RenRen
//
//  Created by Beyondream on 16/6/23.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "UIActivityViewController+ShareView.h"

@implementation UIActivityViewController (ShareView)
//菊花转动
+ (void)showShare:(UIViewController*)VC WithItemArr:(NSArray*)itemArr WithActivitiesApp:(NSArray*)appArr
{
    //创建
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:itemArr applicationActivities:appArr];
    //关闭系统的一些分享
//    activityVC.excludedActivityTypes = @[UIActivityTypePostToFacebook,UIActivityTypePostToTwitter,UIActivityTypePostToWeibo,UIActivityTypeMessage,UIActivityTypeMail,UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop,UIActivityTypeOpenInIBooks];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
    {
        activityVC.excludedActivityTypes = @[UIActivityTypePostToFacebook,UIActivityTypePostToTwitter,UIActivityTypeMessage,UIActivityTypeMail,UIActivityTypePrint,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeOpenInIBooks];
    }else
    {
        activityVC.excludedActivityTypes = @[UIActivityTypePostToFacebook,UIActivityTypePostToTwitter,UIActivityTypeMessage,UIActivityTypeMail,UIActivityTypePrint,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo];
    }

  
    //模态
    [VC presentViewController:activityVC animated:YES completion:nil];
}
@end
