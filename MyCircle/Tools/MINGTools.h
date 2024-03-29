//
//  MINGTools.h
//  MyCircle
//
//  Created by 周汉明 on 2020/4/14.
//  Copyright © 2020 周汉明. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MINGTools : NSObject

+ (NSString *)converTimeStampToString:(long)timeStamp;
+ (NSArray<NSURL *> *)spiltStringToUrls:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
