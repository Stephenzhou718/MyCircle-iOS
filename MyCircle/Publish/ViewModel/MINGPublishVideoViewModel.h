//
//  MINGPublishVideoViewModel.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/17.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <ASProgressPopUpView/ASProgressPopUpView.h>

NS_ASSUME_NONNULL_BEGIN

@interface MINGPublishVideoViewModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) NSURL *fileUrl;
@property (nonatomic, strong) NSURL *videoUrl;

//@property (nonatomic, assign) float progress;

//@property (nonatomic, weak) UIProgressView *progressView;

@property (nonatomic, strong) RACCommand *uploadVideoCommand;
@property (nonatomic, strong) RACCommand *publishCommand;

@end

NS_ASSUME_NONNULL_END
