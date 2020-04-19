//
//  MINGTweetsDetailViewModel.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/15.
//  Copyright © 2020 周汉明. All rights reserved.
//


#import "MINGTweetsItem.h"

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface MINGTweetsDetailViewModel : NSObject

@property (nonatomic, strong) MINGUser *author;
@property (nonatomic, strong) MINGTweets *tweets;
@property (nonatomic, assign) NSInteger like;
@property (nonatomic, assign) Boolean followAuthor;

//@property (nonatomic, strong) MINGTweetsItem *tweetsItem;

- (instancetype)initWithTweetsItem:(MINGTweetsItem *)tweetsItem;

@property (nonatomic, strong) RACCommand *likeCommand;
@property (nonatomic, strong) RACCommand *disLikeCommand;
@property (nonatomic, strong) RACCommand<NSString *, id> *commentCommand;
@property (nonatomic, strong) RACCommand<NSString *, id> *followCommand;
@property (nonatomic, strong) RACCommand<NSString *, id> *unFollowCommand;

@end

NS_ASSUME_NONNULL_END
