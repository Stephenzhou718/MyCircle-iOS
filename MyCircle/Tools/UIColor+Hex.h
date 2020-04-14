//
//  UIColor+Hex.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/12.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LMColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

@interface UIColor (Hex)
// 默认alpha位1
+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
