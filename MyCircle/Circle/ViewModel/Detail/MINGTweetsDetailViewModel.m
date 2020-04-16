//
//  MINGTweetsDetailViewModel.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/15.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGTweetsDetailViewModel.h"

@interface MINGTweetsDetailViewModel ()

@end

@implementation MINGTweetsDetailViewModel

- (instancetype)initWithTweetsItem:(MINGTweetsItem *)tweetsItem
{
    self = [super init];
    if (self) {
        self.tweetsItem = tweetsItem;
    }
    return self;
}

@end
