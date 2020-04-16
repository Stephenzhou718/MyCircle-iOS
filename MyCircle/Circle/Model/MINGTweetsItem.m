//
//  MINGTweetsItem.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/16.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGTweetsItem.h"

@implementation MINGTweetsItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"tweets" : @"circleTweet",
        @"author" : @"author",
        @"like" : @"like",
        @"hasMore" : @"hasMore",
        @"followAuthor" : @"followAuthor"
    };
}

+(NSValueTransformer *)circleTweetJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[MINGTweets class]];
}

+(NSValueTransformer *)authorJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[MINGUser class]];
}


@end
