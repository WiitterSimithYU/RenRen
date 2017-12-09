//
//  NSString+BXExtension.m
//  BXInsurenceBroker
//
//  Created by JYJ on 16/2/23.
//  Copyright © 2016年 baobeikeji. All rights reserved.
//

#import "NSString+BXExtension.h"

@implementation NSString (BXExtension)

+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    if (mobileNum.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

/*手机号码验证 MODIFIED BY HELENSONG*/
- (BOOL) isValidateMobile {
    //手机号以13, 15, 17, 18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(17[0-9])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:self];
}


- (BOOL)validateContainsSpace {
    return [self rangeOfString:@" "].location == NSNotFound;
}

- (NSString *)ageFromBirthday {
    if (self.length != 10 ||
        [self characterAtIndex:4] != '.' ||
        [self characterAtIndex:7] != '.') {
        return @"";
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    NSString *today = [formatter stringFromDate:[NSDate date]];
    
    NSString *selfYear = [self substringToIndex:4];
    NSString *nowYear = [today substringToIndex:4];
    NSInteger age = nowYear.integerValue - selfYear.integerValue;
    
    NSString *selfDate = [self substringFromIndex:5];
    NSString *nowDate = [today substringFromIndex:5];
    if ([nowDate compare:selfDate] < 0) {
        age = age - 1;
    }
    
    if (age < 0) {
        return @"";
    }
    
    return [NSString stringWithFormat:@"%zd", age];
}

- (NSString *)ageFromIDCard {
    NSString *birthday = [self birthdayFromIDCard];
    
    return [birthday ageFromBirthday];
}

- (NSString*)birthdayFromIDCard {
    NSString *result = @"未知";
    if (self.length == 15) {
        NSMutableString *birthString = [[self substringWithRange:NSMakeRange(6, 6)] mutableCopy];
        [birthString insertString:@"19" atIndex:0];
        [birthString insertString:@"." atIndex:4];
        [birthString insertString:@"." atIndex:7];
        result = birthString;
    } else if (self.length == 18) {
        NSMutableString *birthString = [[self substringWithRange:NSMakeRange(6, 8)] mutableCopy];
        [birthString insertString:@"." atIndex:4];
        [birthString insertString:@"." atIndex:7];
        result = birthString;
    }
    
    return result;
}

- (NSString*)sexFromIDCard {
    NSString *sexString = @"";
    
    if (self.length == 15) {
        sexString =  [[self substringWithRange:NSMakeRange(14, 1)] mutableCopy];
    } else if (self.length == 18) {
        sexString = [[self substringWithRange:NSMakeRange(16, 1)] mutableCopy];
    }
    
    int x = sexString.intValue;
    if (x < 0 || sexString.length == 0) {
        return @"";
    }
    if (x % 2 == 0) {
        return @"女";
    } else {
        return @"男";
    }
    return sexString;
}


- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

+ (NSString *)stringWithMoneyAmount:(double)amount {
    BOOL minus = amount < 0;
    if (minus) {
        amount = -amount;
    }
    NSMutableString *toString = [NSMutableString string];
    long round = floor(amount);
    int fraction = floor((amount - round + 0.005) * 100.0);
    NSString *fractionString = [NSString stringWithFormat:@".%02d", fraction];
    
    do {
        int thousand = round % 1000;
        if (round < 1000) {
            [toString insertString:[NSString stringWithFormat:@"%d", thousand] atIndex:0];
        } else {
            [toString insertString:[NSString stringWithFormat:@",%03d", thousand] atIndex:0];
        }
        round = round / 1000;
    } while (round);
    [toString appendString:fractionString];
    if (minus) {
        [toString insertString:@"-" atIndex:0];
    }
    return toString;
}

+ (NSString *)stringIntervalFrom:(NSDate *)start to:(NSDate *)end {
    NSInteger interval = end.timeIntervalSince1970 - start.timeIntervalSince1970;
    if (interval <= 0) {
        return @"刚刚";
    }
    
    if (interval < 60) {
        return [NSString stringWithFormat:@"%zd 秒前", interval];
    }
    
    interval = interval / 60;
    if (interval < 60) {
        return [NSString stringWithFormat:@"%zd 分钟前", interval];
    }
    
    interval = interval / 60;
    if (interval < 24) {
        return [NSString stringWithFormat:@"%zd 小时前", interval];
    }
    
    interval = interval / 24;
    if (interval < 7) {
        return [NSString stringWithFormat:@"%zd 天前", interval];
    }
    
    if (interval < 30) {
        return [NSString stringWithFormat:@"%zd 周前", interval / 7];
    }
    
    if (interval < 365) {
        return [NSString stringWithFormat:@"%zd 个月前", interval / 30];
    }
    return [NSString stringWithFormat:@"%zd 年前", interval / 365];
}
//邮箱
+ (BOOL)validateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (BOOL)isEmptyString {
    return self.length == 0 || [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0;
}
- (BOOL)isUrl
{
//    NSString * regex =@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
//    // @"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?";
//    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    
//    return [pred evaluateWithObject:self];
    if ([self rangeOfString:@"http://"].location !=NSNotFound||[self rangeOfString:@"https://"].location!=NSNotFound) {
        return YES;
    }else
    {
        return NO;
    }
}
/**
 *  产生随机订单号
 *
 *  @return 订单号字符串
 */
+ (NSString *)generateFradomCharacter
{
    static int kNumber = 16;
    
    NSString *sourceStr = @"abcdefghijklmnopqrstuvwxyz0123456789";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index =  arc4random() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

// 此方法随机产生num位字符串
+(NSString *)retnumbitStringWithNumber:(int)number
{
    
    char data[number];
    
    for (int x=0;x<number;data[x++] = (char)('A' + (arc4random_uniform(32))));
    
    return [[NSString alloc] initWithBytes:data length:number encoding:NSUTF8StringEncoding];
    
}
@end
