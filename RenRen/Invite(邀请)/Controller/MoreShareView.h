//
//  ShareView.h
//  RenRenShare
//
//  Created by 余晓辉 on 16/6/16.
//  Copyright © 2016年 yuxiaohui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreShareView : UIView
@property (strong,nonatomic)void (^getTouch)(int ButTag);


@property (weak, nonatomic) IBOutlet UIView *shareView;



+(instancetype)creatXib;
-(void)show;
-(void)close;


@end
