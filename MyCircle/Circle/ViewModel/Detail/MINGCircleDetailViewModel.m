//
//  MINGCircleDetailViewModel.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/15.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGCircleDetailViewModel.h"

@interface MINGCircleDetailViewModel ()

@end

@implementation MINGCircleDetailViewModel

- (instancetype)initWithCircleItem:(MINGCircleItem *)circleItem
{
    self = [super init];
    if (self) {
        self.circleItem = circleItem;
    }
    return self;
}

@end
