//
//  MINGPublishVideoViewModel.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/17.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface MINGPublishVideoViewModel : NSObject

@property (nonatomic, strong) RACCommand *publishCommand;

@end

NS_ASSUME_NONNULL_END
