//
//  MINGUserItem.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/16.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGUserItem.h"

@implementation MINGUserItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"user" : @"member",
        @"follow" : @"follow"
    };
}

+(NSValueTransformer *)userTweetJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[MINGUser class]];
}





@end
