//
//  HMKeychainService.h
//  CommonTools-OC
//
//  Created by 心诚 on 2021/7/8.
//  Copyright © 2021 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HMKeychainService : NSObject

/*!
 保存数据
 @param data 要保存的数据
 @param identifier 存储数据的标识
 */
+ (BOOL)saveData:(nullable id)data withIdentifier:(nullable NSString *)identifier;

/*!
 读取数据
 @param identifier 存储数据的标识
 @param cls 返回结果的数据类型 默认NSString iOS12.0 必须使用
 */
+ (nullable id)readData:(nullable NSString *)identifier resultClass:(nullable Class)cls;

/*!
 更新数据
 @param data 要更新的数据
 @param identifier 存储数据的标识
 */
+ (BOOL)updateData:(nullable id)data withIdentifier:(nullable NSString *)identifier;

/*!
 删除数据
 @param identifier 存储数据的标识
 */
+ (void)deleteData:(nullable NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
