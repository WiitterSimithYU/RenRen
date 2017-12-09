//
//  LWAccount.m
//  MIAOTUI2
//
//  Created by tangxiaowei on 16/5/24.
//  Copyright © 2016年 miaoMiao. All rights reserved.
//

#import "LWAccount.h"







@implementation LWAccount
- (void)encodeWithCoder:(NSCoder *)encode
{
    if (self.dataType) {
       
        [encode encodeObject:self.dataType forKey:@"dataType"];
      }
    
    if (self.headImg)
    {
        [encode encodeObject:self.headImg forKey:@"headImg"];
    }
    if (self.nickName)
    {
        [encode encodeObject:self.nickName forKey:@"nickName"];
    }
    if (self.q_tel)
    {
        [encode encodeObject:self.q_tel forKey:@"q_tel"];
    }


    if (self.sex)
    {
        [encode encodeObject:self.sex forKey:@"sex"];
    }

    if (self.state)
    {
        [encode encodeObject:self.state forKey:@"state"];
        }
    if (self.token)
    {
        [encode encodeObject:self.token forKey:@"token"];
    }
    if (self.uid)
    {
        [encode encodeObject:self.uid forKey:@"uid"];
    }

}
- (id)initWithCoder:(NSCoder *)decoder
{
     if (self = [super init]) {
         
         self.dataType          = [decoder decodeObjectForKey:@"dataType"];

          self.headImg          = [decoder decodeObjectForKey:@"headImg"];
          self.nickName          = [decoder decodeObjectForKey:@"nickName"];
          self.q_tel          = [decoder decodeObjectForKey:@"q_tel"];
          self.sex          = [decoder decodeObjectForKey:@"sex"];
          self.state          = [decoder decodeObjectForKey:@"state"];
          self.token          = [decoder decodeObjectForKey:@"token"];
          self.uid          = [decoder decodeObjectForKey:@"uid"];
         
         
     }
    return self;
}
@end
