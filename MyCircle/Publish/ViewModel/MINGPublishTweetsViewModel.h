//
//  MINGPublishTweetsViewModel.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/17.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface MINGPublishTweetsViewModel : NSObject

@property (nonatomic, assign) NSInteger uploadIndex;
@property (nonatomic, strong) UIImage *imageOne;
@property (nonatomic, strong) UIImage *imageTwo;
@property (nonatomic, strong) UIImage *imageThree;

@property (nonatomic, strong) NSString *content;

@property (nonatomic, copy) NSString *imageOneUrl;
@property (nonatomic, copy) NSString *imageTwoUrl;
@property (nonatomic, copy) NSString *imageThreeUrl;

@property (nonatomic, strong) RACCommand *uploadImageOneCommand;
@property (nonatomic, strong) RACCommand *uploadImageTwoCommand;
@property (nonatomic, strong) RACCommand *uploadImageThreeCommand;
@property (nonatomic, strong) RACCommand *publishCommand;

@end

NS_ASSUME_NONNULL_END
