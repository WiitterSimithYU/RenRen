//
//  UIImage+MJ.h
//  预习-01-UIPopoverController
//
//  Created by MJ Lee on 14-5-25.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  保存图片到相册的结果
 *
 *  @param isSuccessed 返回是否成功
 */
typedef void(^SaveToAlumbResult)(BOOL isSuccessed);

@interface UIImage (GR)
/**
 *  获得某个像素的颜色
 *
 *  @param point 像素点的位置
 */
- (UIColor *)pixelColorAtLocation:(CGPoint)point;

/**
 *  加载图片
 *
 *  @param name 图片名
 */
+ (UIImage *)imageWithName:(NSString *)name;

/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

/**
 *  打水印
 *
 *  @param bg   背景图片
 *  @param logo 右下角的水印图片
 */
+ (instancetype)waterImageWithBg:(NSString *)bg logo:(NSString *)logo;

/**
 圆形图片
 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 截图
 */
+ (instancetype)captureWithView:(UIView *)view;


/**
 *  将image保存到相册
 */
- (void)saveToAlumbWithResultBlock:(SaveToAlumbResult)result;
@end
