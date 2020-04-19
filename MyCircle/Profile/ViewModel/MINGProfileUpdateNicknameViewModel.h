//
//  MINGProfileUpdateNicknameViewModel.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/18.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface MINGProfileUpdateNicknameViewModel : NSObject

@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, strong) RACCommand *updateNicknameCommand;

@end

NS_ASSUME_NONNULL_END
