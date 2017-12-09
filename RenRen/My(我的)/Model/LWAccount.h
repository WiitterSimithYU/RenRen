//
//  LWAccount.h
//  MIAOTUI2
//
//  Created by tangxiaowei on 16/5/24.
//  Copyright © 2016年 miaoMiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWAccount : NSObject<NSCoding>
@property (nonatomic, copy)NSString *dataType;// //联盟平台＊//
@property (nonatomic, strong)NSString *headImg;//用户头像＊//
@property (nonatomic, strong)NSString *nickName; //用户   ＊＊＊//
@property (nonatomic, strong)NSString *q_tel; //用户号码//
@property (nonatomic, strong)NSString *sex ;//用户性别
@property (nonatomic, strong)NSString *state ;//用户状态
@property (nonatomic, strong)NSString *token;//登录标识码
@property (nonatomic, strong)NSString *uid;//用户uid
@property(nonatomic,strong)NSString *codeSting;//密码
@end
