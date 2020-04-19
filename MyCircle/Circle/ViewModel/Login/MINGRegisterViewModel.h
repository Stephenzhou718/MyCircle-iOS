//
//  MINGRegisterViewModel.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/19.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface MINGRegisterViewModel : NSObject

@property (nonatomic, strong) NSString *errorMsg;
@property (nonatomic, strong) RACCommand *registerCommand;

- (void)loadUsername:(NSString *)username;
- (void)loadPassword:(NSString *)password;

@end

NS_ASSUME_NONNULL_END
