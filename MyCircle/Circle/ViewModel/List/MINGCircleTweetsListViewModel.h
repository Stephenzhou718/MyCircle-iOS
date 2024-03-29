//
//  MINGCircleTweetsListViewModel.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/15.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGTweetsItem.h"

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface MINGCircleTweetsListViewModel : NSObject

@property (nonatomic, strong) NSMutableArray<MINGTweetsItem *> *tweetsItems;
@property (nonatomic, strong) RACCommand *refreshCommand;
@property (nonatomic, strong) RACCommand *loadMoreCommand;

- (instancetype)initWithCircleId:(NSString *)circleId;

@end

NS_ASSUME_NONNULL_END
