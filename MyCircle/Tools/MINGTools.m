//
//  MINGTools.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/14.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGTools.h"

@implementation MINGTools

+ (NSString *)converTimeStampToString:(long)timeStamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp / 1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

@end
