//
//  HMUncaughtExceptionHandler.h
//  OCToolsClass
//
//  Created by zhuhc on 2021/8/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HMUncaughtExceptionHandler : NSObject

+ (instancetype)defaultExceptionHandler;

//错误日志路径
@property (nullable, nonatomic,copy) NSString *crashFilePath;

HMUncaughtExceptionHandler * InstanceUncaughtExceptionHandler(void);

@end

NS_ASSUME_NONNULL_END
