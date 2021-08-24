//
//  NSString+HMCategory.h
//  CommonTools-OC
//
//  Created by 心诚 on 2021/7/8.
//  Copyright © 2021 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HMCategory)

/// 获取系统生成的UUID 设备通用识别码
+ (nullable NSString *)uuid;

/// 随机生成UUID 设备通用识别码
+ (NSString *)random_uuid;


@end

NS_ASSUME_NONNULL_END
