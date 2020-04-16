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

+ (NSArray<NSURL *> *)spiltStringToUrls:(NSString *)str
{
    if (str == nil || str.length == 0) {
        return [NSArray new];
    } else {
        NSArray<NSString *> *strs = [str componentsSeparatedByString:@","];
        NSMutableArray<NSURL *> *ret = @[].mutableCopy;
        for (NSString *str in strs) {
            [ret addObject:[NSURL URLWithString:str]];
        }
        return ret.copy;
    }
}

@end
