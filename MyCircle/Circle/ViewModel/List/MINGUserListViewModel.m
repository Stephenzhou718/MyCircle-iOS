//
//  MINGUserListViewModel.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/16.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGUserListViewModel.h"

@interface MINGUserListViewModel ()

@end

@implementation MINGUserListViewModel

- (instancetype)initWithMINGUserItems:(NSArray<MINGUserItem *> *)userItems
{
    self = [super init];
    if (self) {
        self.userItems = userItems;
    }
    return self;
}

@end
