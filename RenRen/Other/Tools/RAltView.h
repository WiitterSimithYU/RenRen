//
//  RAltView.h
//  RenRen
//
//  Created by Beyondream on 16/6/17.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RAltViewStyle)
{
    RAltViewStyleSheet,
    RAltViewStyleAlert,
    RAltViewStyleTab,
    RAltViewStylePlatForm,
    RAltViewStyleNormal,
    RAltViewStyleNotice
};

@class RAltView;
/**
 *   弹出框协议
 */
@protocol RAltViewDelegate <NSObject>

@optional

-(void)rAltView:(RAltView*)altView withIndex:(NSInteger)index;

-(void)rAltView:(RAltView*)altView withIndex:(NSInteger)index WithTitle:(NSString*)title;
-(void)rAltView:(RAltView*)altView withDate:(NSString *)dateTime;
@end

@interface RAltView : UIView

@property(nonatomic,assign)id<RAltViewDelegate>delegate;

+(RAltView*)shareInstance;

-(void)showAlt:(NSString*)title style:(RAltViewStyle)style WithArr:(NSArray*)arr;

-(void)showTitleWithContent:(NSString *)ContentStr style:(RAltViewStyle)style;
-(void)remove;

@end
