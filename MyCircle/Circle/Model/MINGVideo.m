//
//  MINGVideo.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/11.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGVideo.h"

@implementation MINGVideo

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"videoId" : @"id",
        @"title" : @"title",
        @"content" : @"content",
        @"uploadUsername" : @"uploadUsername",
        @"belongCircleId" : @"belongCircleId",
        @"url" : @"url",
        @"coverUrl" : @"coverUrl",
        @"likeCount" : @"likeCount",
        @"commentCount" : @"commentCount",
        @"publishTime" : @"publishTime"
    };
}



@end
