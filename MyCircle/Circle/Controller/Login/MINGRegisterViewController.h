//
//  MINGRegisterViewController.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/16.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGLoginViewModel.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MINGRegisterViewController : UIViewController

- (instancetype)initWithViewModel:(MINGLoginViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
