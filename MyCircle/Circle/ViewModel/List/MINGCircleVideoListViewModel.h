//
//  MINGCircleVideoListViewModel.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/11.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGVideoItem.h"

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface MINGCircleVideoListViewModel : NSObject

@property (nonatomic, strong) NSMutableArray<MINGVideoItem *> *videoItems;
@property (nonatomic, strong) RACCommand *refreshCommand;
@property (nonatomic, strong) RACCommand *loadMoreCommand;

- (instancetype)initWithCircleId:(NSString *)circleId;

@end

NS_ASSUME_NONNULL_END
