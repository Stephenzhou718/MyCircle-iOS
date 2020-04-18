//
//  MINGProfileBaseCellWithArrow.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/18.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MINGProfileBaseCellWithArrow : UIView

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *content;

- (void)setSepLineHidden:(Boolean)hidded;

@end

NS_ASSUME_NONNULL_END
