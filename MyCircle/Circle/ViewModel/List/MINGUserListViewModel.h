//
//  MINGUserListViewModel.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/16.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGUserItem.h"

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MINGUserListViewModel : NSObject

@property (nonatomic, strong) NSArray<MINGUserItem *> *userItems;

- (instancetype)initWithMINGUserItems:(NSArray<MINGUserItem *> *)userItems;

@end

NS_ASSUME_NONNULL_END
