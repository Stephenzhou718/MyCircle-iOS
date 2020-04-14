//
//  MINGComment.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/14.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGComment.h"

@implementation MINGComment


+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"commentId" : @"id",
        @"evnetType" : @"eventType",
        @"eventId" : @"eventId",
        @"content" : @"content",
        @"likeCount" : @"likeCount",
        @"time" : @"time",
    };
}

@end
