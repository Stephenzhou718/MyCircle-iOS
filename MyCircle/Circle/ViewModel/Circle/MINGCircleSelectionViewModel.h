//
//  MINGCircleSelectionViewModel.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/15.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGCircleItem.h"

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

typedef NS_ENUM(NSInteger, MINGCircleSelectionType) {
    MINGCircleSelectionTypeAll,     // 所有圈子
    MINGCircleSelectionTypeMine     // 我的圈子
};


NS_ASSUME_NONNULL_BEGIN

@interface MINGCircleSelectionViewModel : NSObject

@property (nonatomic,strong) RACCommand *refreshCommand;
@property (nonatomic, strong) NSMutableArray<MINGCircleItem *> *circleItems;

- (instancetype)initWithSelectionType:(MINGCircleSelectionType)type;

@end

NS_ASSUME_NONNULL_END
