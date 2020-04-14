//
//  MINGVideoItem.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/12.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGVideoItem.h"

@implementation MINGVideoItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"author":@"author",
        @"video":@"circleVideo",
        @"like":@"like",
        @"hasMore":@"hasMore",
        @"followAuthor":@"followAuthor",
    };
}

+(NSValueTransformer *)videoJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[MINGVideo class]];
}

+(NSValueTransformer *)authorJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[MINGUser class]];
}



@end
