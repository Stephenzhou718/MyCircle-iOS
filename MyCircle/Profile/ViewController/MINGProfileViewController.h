//
//  MINGProfileViewController.h
//  MyCircle
//
//  Created by 周汉明 on 2020/3/21.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGProfileViewModel.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MINGProfileViewController : UIViewController

- (instancetype)initWithViewModel:(MINGProfileViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
