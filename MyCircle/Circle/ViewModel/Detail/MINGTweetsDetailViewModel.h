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

@property (nonatomic, strong) MINGTweetsItem *tweetsItem;

- (instancetype)initWithTweetsItem:(MINGTweetsItem *)tweetsItem;

@end

NS_ASSUME_NONNULL_END
