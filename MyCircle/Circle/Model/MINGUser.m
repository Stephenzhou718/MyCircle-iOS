//
//  MINGUser.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/12.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGUser.h"

@implementation MINGUser

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"username" : @"username",
        @"nickname" : @"nickname",
        @"headUrl" : @"headUrl",
        @"signature" : @"signature"
    };
}

@end
