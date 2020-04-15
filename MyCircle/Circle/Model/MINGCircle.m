//
//  MINGCircle.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/15.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGCircle.h"

@implementation MINGCircle

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"circleId" : @"id",
        @"name" : @"name",
        @"circleDescription" : @"description",
        @"imgUrl" : @"imgUrl",
        @"belongUsername" : @"belongUsername",
    };
}

@end
