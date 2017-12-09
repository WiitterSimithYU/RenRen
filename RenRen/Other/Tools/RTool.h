//
//  RTool.h
//  RenRen
//
//  Created by Beyondream on 16/6/15.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTool : NSObject
/**
 *  选择根控制器
 */
+ (void)chooseRootController;
/**
 *  无网
 */
+(UIImageView*)setViewPlaceHoldImage:(CGFloat)maxY WithBgView:(UIView*)bgView;

/**
 *  时间差
 */
+(int)intervalSinceNow: (NSString *) theDate;

/**
    时间差 6.15增加
 */
+(int)timeFromNow:(NSString *) theDate;

/**
 *  时间转字符串
 */
+(NSString*)dateToString:(NSDate *)date;
@end
