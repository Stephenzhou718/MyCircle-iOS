//
//  MINGCircleTweetsListViewModel.m
//  MyCircle
//
//  Created by 周汉明 on 2020/4/15.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGCircleTweetsListViewModel.h"

@interface MINGCircleTweetsListViewModel ()

@property (nonatomic, copy) NSString *circleId;

@end

@implementation MINGCircleTweetsListViewModel

- (instancetype)initWithCircleId:(NSString *)circleId
{
    self = [super init];
    if (self) {
        self.circleId = circleId;
    }
    return self;
}

@end
