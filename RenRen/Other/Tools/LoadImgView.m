//
//  LoadImgView.m
//  RenRen
//
//  Created by Beyondream on 16/6/20.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "LoadImgView.h"

@interface  LoadImgView()

@property(nonatomic,strong)UIImageView *animationImgView;
@property(nonatomic,strong)UILabel *loadLabel;

@end

LoadImgView *loadView = nil;

@implementation LoadImgView
//创建实例
+(LoadImgView*)shareInstance
{
    if (!loadView) {
        
        loadView = [[LoadImgView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        loadView.backgroundColor =kClearColor;
        
    }
    return loadView;
}
//增加锁
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    @synchronized (self) {
        if (!loadView) {
            loadView = [super allocWithZone:zone];
        }
    }
    return loadView;
}
//实现copy协议需要实现NSCopying协议
- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

-(void)show:(CGRect)frame withVC:(UIViewController*)vc
{
    [vc.view addSubview:loadView];
    UIImageView * animView= [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x-20, frame.origin.y, frame.size.width, frame.size.height)];
    NSMutableArray *imgArr = [NSMutableArray array];
    for (int i=0; i<7; i++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"loading_%d",i]];
        [imgArr addObject:img];
    }
    animView.animationImages =imgArr;
    
    // all frames will execute in 1.75 seconds
    animView.animationDuration = 0.5;
    // repeat the annimation forever
    animView.animationRepeatCount = 0;
    // start animating
    [animView startAnimating];
    // add the animation view to the main window
    [loadView addSubview:animView];
    _animationImgView = animView;
    
    self.loadLabel = [[UILabel alloc]initWithFrame:CGRectMake(animView.maxX+10, animView.minY, 80 , 40)];
    self.loadLabel.text = @"加载中...";
    [loadView addSubview:self.loadLabel];
    
    
}

-(void)hiden
{
    [loadView removeFromSuperview];
    loadView = nil;
    [self.animationImgView removeFromSuperview];
    self.animationImgView = nil;
    [self.loadLabel removeFromSuperview];
    self.loadLabel = nil;
}

@end
