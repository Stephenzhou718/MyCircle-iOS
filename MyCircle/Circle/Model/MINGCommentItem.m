//
//  MINGCommentItem.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/13.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGCommentItem.h"

@implementation MINGCommentItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"hasMore" : @"hasMore",
        @"like" : @"like",
        @"author" : @"author",
        @"comment" : @"comment"
    };
}


+(NSValueTransformer *)authorJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[MINGUser class]];
}

+(NSValueTransformer *)commentJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[MINGComment class]];
}

@end
