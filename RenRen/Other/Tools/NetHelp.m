//
//  NetHelp.m
//  PromotionApp
//
//  Created by app03 on 16/5/11.
//  Copyright © 2016年 app03. All rights reserved.
//

#import "NetHelp.h"
#import <Reachability.h>
@implementation NetHelp
/**
 *  网络是否可用
 */
+(BOOL)isConnectionAvailable
{

    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
           NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
           NSLog(@"3G");
            break;
    }
    return isExistenceNetwork;
}
@end
