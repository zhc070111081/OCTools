//
//  HMLogManager.h
//  CommonTools-OC
//
//  Created by 心诚 on 2021/7/5.
//  Copyright © 2021 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define HMLOG(_level_,_fmt_,...) [[HMLogManager shareInstance] hm_logWithLevel:_level_ File:__FILE__ line:__LINE__ format:_fmt_,##__VA_ARGS__];

#define HM_DEBUG(fmt,...)   HMLOG(HMLogLevelDebug,fmt,##__VA_ARGS__)
#define HM_INFO(fmt,...)    HMLOG(HMLogLevelInfo,fmt,##__VA_ARGS__)
#define HM_WARNING(fmt,...) HMLOG(HMLogLevelWarning,fmt,##__VA_ARGS__)
#define HM_ERROR(fmt,...)   HMLOG(HMLogLevelError,fmt,##__VA_ARGS__)
#define HM_CLEARLOG         [[HMLogManager shareInstance] clearAllLog];

typedef NS_ENUM(NSUInteger, HMLogLevel){
    HMLogLevelDebug = 0, // DEBUG
    HMLogLevelInfo,      // INFO
    HMLogLevelWarning,   // WARNING
    HMLogLevelError      // ERROR
};

@interface HMLogManager : NSObject

/// level  defaut error
@property (assign, nonatomic) HMLogLevel level;

+ (instancetype)shareInstance;

/// write log with document
/// @param level log level
/// @param file file name
/// @param line line number
/// @param format log content
- (void)hm_logWithLevel:(HMLogLevel)level File:(const char *)file line:(int)line format:(NSString *)format,...NS_FORMAT_FUNCTION(4, 5);

/// clear all log
- (void)hm_clearAllLog;

@end

NS_ASSUME_NONNULL_END
