//
//  RTool.m
//  RenRen
//
//  Created by Beyondream on 16/6/15.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "RTool.h"
#import "RTabBarController.h"
#import "LeadVC.h"
@implementation RTool
/**
 *  选择根控制器
 */
+ (void)chooseRootController
{
    NSString *key = @"CFBundleVersion";
    
    // 取出沙盒中存储的上次使用软件的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:key];
    
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if ([currentVersion isEqualToString:lastVersion]) {
        [UIApplication sharedApplication].statusBarHidden = NO;
        UIApplication *al = [UIApplication sharedApplication];
        [NSThread sleepForTimeInterval:2.0];//设置启动页面时间
        al.delegate.window.rootViewController = [[RTabBarController alloc]init];
        [al.delegate.window makeKeyAndVisible];
        
    }
    else  { // 新版本
        
        UIApplication *al = [UIApplication sharedApplication];
        al.delegate.window.rootViewController = [LeadVC new];
        [al.delegate.window makeKeyAndVisible];
        // 存储新版本
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
    }
}
+(UIImageView*)setViewPlaceHoldImage:(CGFloat)maxY WithBgView:(UIView*)bgView
{
     UIImageView *holdimgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, bgView.boundsHeight)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, maxY, SCREEN_WIDTH-100, 30)];
    label.font = Font(17);
    label.tag = 101;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"网络出错，请检查网络设置";
    label.textColor =UIColorFromRGB(0x333333);
    [holdimgView addSubview:label];
    
    UILabel *onceAgainLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, label.maxY+20, 100, 50)];
    onceAgainLab.font = Font(17);
    onceAgainLab.text = @"重新加载";
    onceAgainLab.tag = 100;
    onceAgainLab.layer.borderWidth = 1;
    onceAgainLab.layer.borderColor = COLOR_GRAY_.CGColor;
    onceAgainLab.textColor =UIColorFromRGB(0x333333);
    onceAgainLab.textAlignment = NSTextAlignmentCenter;
    [holdimgView addSubview:onceAgainLab];
   
    [bgView addSubview:holdimgView];
    return holdimgView;
    
}
+(int)intervalSinceNow: (NSString *) theDate
{
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    NSTimeInterval cha=now-late;
    
    if (cha/86400>=1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        return [timeString intValue];
    }
    return -1;
}

+(int)timeFromNow:(NSString *) theDate
{
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
//    NSString *timeString=@"";
    
    NSTimeInterval cha=now-late;
    
    if (cha/60>=1)
    {
        return 1;
    }
    return -1;

}

+(NSString*)dateToString:(NSDate *)date{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* string=[dateFormat stringFromDate:date];
    return string;
}
@end
