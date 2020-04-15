//
//  MINGCircleItem.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/15.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGCircleItem.h"

@implementation MINGCircleItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"circle" : @"circle",
        @"hasJoined" : @"hasJoined"
    };
}

+(NSValueTransformer *)circleJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[MINGCircle class]];
}


@end
