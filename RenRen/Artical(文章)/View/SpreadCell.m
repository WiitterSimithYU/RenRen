//
//  SpreadCell.m
//  MIAOTUI2
//
//  Created by Beyondream on 16/5/18.
//  Copyright © 2016年 miaoMiao. All rights reserved.
//

#import "SpreadCell.h"
#import "ArticalDetailVC.h"
@implementation SpreadCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //		NSLog(@"%s", __func__);
    }
    return self;
}
- (void)setUrlString:(NSString *)urlString WithTitle:(NSString*)title
{
    _newsVC = [[ArticalDetailVC alloc]init];
    _newsVC.urlString = urlString;
    _newsVC.titSting = title;
    [self addSubview:_newsVC.view];
}
@end
