//
//  MINGCommentViewModel.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/14.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGCommentItem.h"

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MINGContentType) {
    MINGContentTypeVideo,
    MINGContentTypeTweets
};

@interface MINGCommentViewModel : NSObject

@property (nonatomic, strong) NSMutableArray<MINGCommentItem *> *commentItems;
@property (nonatomic, strong) RACCommand *refreshCommand;
@property (nonatomic, strong) RACCommand *loadMoreCommand;

- (instancetype)initWithContentType:(MINGContentType) type eventId:(NSString *)eventId;

@end

NS_ASSUME_NONNULL_END
