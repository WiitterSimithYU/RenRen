//
//  BaseUrlHeader.h
//  RenRen
//
//  Created by Beyondream on 16/6/16.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#ifndef BaseUrlHeader_h
#define BaseUrlHeader_h

#define DATATYPE [[NSUserDefaults standardUserDefaults] objectForKey:@"platform"]
//我界面Baseurl
#define MY_BASE_URL @"http://www.66q.com"

#define BASE_URL @"http://api.66q.com/"
//文章分类
#define GET_ART_SORT @"apple.php?ac=getCat"

//文章列表
#define GET_ART_LIST @"apple.php?ac=getCatList"

//文章分享
#define ART_SHARE @"apple.php?ac=shareurl"

//收入展示界面
#define INCOME_DETAIL @"apple.php?ac=getDetail"

//提现按钮请求
#define INCASH_INTERFACE @"apple.php?ac=txAction"

//收入界面 提现纪录

#define INCOME_RECORD @"apple.php?ac=getTx"


//收入界面  收入纪录
#define INCASH_RECORD @"apple.php?ac=getHistory"

//高收益接口
#define Heigh_Detail @"apple.php?ac=getggy"

//提现
#define txACtion @"apple.php?ac=txAction"

//提现界面  警告框
#define txAlt  @"apple.php?ac=getPaywarn"

//文章详情加载失败
#define LOADFAIL  @"apple.php?ac=doRefresh"


//获取本人邀请的注册人列表
#define  GETYqPersonList  @"apple.php?ac=getYqPersonList"

//邀请展示页面接口
#define  GETYqDate     @"apple.php?ac=getYqDate"

//判断是否可以签到
#define  CanSingUrl   @"signDateApple.php?ac=isShare"

//签到日历接口
#define  CanlenarURL  @"signDateApple.php?ac=signDate"

//签到
#define  SINGURL      @"signDateApple.php?ac=signAc"
//验证码
#define CodeURL         @"apple.php?ac=sendms"

//注册
#define regURL         @"apple.php?ac=signup"

//找回密码 时的验证码
#define findCode       @"apple.php?ac=getForget"

//改变密码
#define changeCode    @"apple.php?ac=changPasswd"

//占位图
#define HoldImg [UIImage imageNamed:@"ic_image_loading_small"]
//占位图默认头像
#define HeadImg [UIImage imageNamed:@"默认头像"]

//我的页面
#define  POST_LOGIN     @"apple.php?ac=dologin"//登录接口
#define  POST_FIXHODEIMG     @"apple.php?ac=uploadAction"//修改头像
#define  POST_FIXNAME     @"apple.php?ac=changeUserName"//修改姓名
#define  POST_FIXSEX     @"apple.php?ac=changeUserSex"//修改性别

//领红包
#define moneyUrl        @"http://811570.top/apkup/html/hb.php?dataType="

//弹出提示
#define  GetNotice     @"http://api.66q.com/apple.php?ac=getNotice&dataType="

#endif /* BaseUrlHeader_h */
