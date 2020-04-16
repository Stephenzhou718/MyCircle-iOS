//
//  MINGUserListViewController.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/16.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import "MINGUserListViewModel.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MINGUserListViewController : UIViewController

- (instancetype)initWithViewModel:(MINGUserListViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
