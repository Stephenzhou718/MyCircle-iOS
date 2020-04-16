//
//  MINGTweets.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/16.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGTweets.h"

@implementation MINGTweets

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"tweetsId" : @"id",
        @"content" : @"content",
        @"imgs" : @"imgs",
        @"belongCircleId" : @"belongCircleId",
        @"authorId" : @"uploadUsername",
        @"likeCount" : @"likeCount",
        @"commentCount" : @"commentCount",
        @"time" : @"publishTime",
    };
}

@end
