//
//  HMLogManager.m
//  CommonTools-OC
//
//  Created by 心诚 on 2021/7/5.
//  Copyright © 2021 Apple Inc. All rights reserved.
//

#import "HMLogManager.h"

/// max save log days
static NSInteger const HMMAXSaveDay = 7;

/// log file folder name
static NSString *const HMFolderName = @"HM_APP_LOG";

static HMLogManager *_manager = nil;

NSString *const HMLevelDrsc[] = {
    [HMLogLevelDebug]   = @"DEBUG",
    [HMLogLevelInfo]    = @"INFO",
    [HMLogLevelWarning] = @"WARNING",
    [HMLogLevelError]   = @"ERROR"
};

@interface HMLogManager ()<NSCopying>

/// date formatter
@property (strong, nonatomic, nullable) NSDateFormatter *dateFormatter;

/// time dateformatter
@property (strong, nonatomic, nullable) NSDateFormatter *timeFormatter;

/// file manager
@property (strong, nonatomic, nullable) NSFileManager *fileManager;

@end

@implementation HMLogManager

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[HMLogManager alloc] init];
    });
    
    return _manager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [super allocWithZone:zone];
    });
    
    return _manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupConfig];
    }
    return self;
}

- (void)setupConfig {
    self.level = HMLogLevelError;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    self.dateFormatter = dateFormatter;
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"HH:mm:sss"];
    self.timeFormatter = timeFormatter;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    self.fileManager = fileManager;
    
    [self checkLogSaveDay];
}

- (id)copyWithZone:(NSZone *)zone {
    return _manager;
}

#pragma mark - public method

- (void)hm_logWithLevel:(HMLogLevel)level File:(const char *)file line:(int)line format:(NSString *)format, ... {

    NSString *fileNameStr = [NSString stringWithUTF8String:file].lastPathComponent;
    NSString *log_level = HMLevelDrsc[level];
    
    
    va_list paramList;
    va_start(paramList, format);
    
    NSString *content = [[NSString alloc] initWithFormat:format arguments:paramList];
    
    // 写入日志
    dispatch_async(dispatch_queue_create("HM_WRITE_LOG", nil), ^{
       
        // 获取当前日期作为文件名称
        NSString *fileName = [self.dateFormatter stringFromDate:[NSDate date]];
        NSString *filePath = [[[self absoluteFolderPath] stringByAppendingPathComponent:fileName] stringByAppendingPathExtension:@"log"];
        
        NSString *dateString = [self.dateFormatter stringFromDate:[self getCurrentDate]];
        NSString *timeString = [self.timeFormatter stringFromDate:[self getCurrentDate]];
        NSString *writeStr = [NSString stringWithFormat:@"\n[%@]-[%@ %@]-[%@ Line:%d] %@",log_level,dateString,timeString,fileNameStr,line,content];
        
        fprintf(stdout,"%s\n",writeStr.UTF8String);
        
        if (level >= self.level) {
            [self writeFile:filePath WithStringData:writeStr];
        }
    });
    
    va_end(paramList);
}

- (void)hm_clearAllLog {
    if (![self.fileManager fileExistsAtPath:[self absoluteFolderPath]]) return;
    
    [self.fileManager removeItemAtPath:[self absoluteFolderPath] error:nil];
}

#pragma mark - private method

- (void)checkLogSaveDay {
    if (![self.fileManager fileExistsAtPath:[self absoluteFolderPath]]) return;
    
    // 检查日志日期 大于7天的日志 自动清除
    NSArray *files = [self.fileManager contentsOfDirectoryAtPath:[self absoluteFolderPath] error:nil];
    if (files.count == 0) return;
    
    // 遍历文件夹内容数组，删除过期的日志
    for (NSString *fileName in files) {
        
        // 获取日志文件的日期
        NSArray *fileDates = [fileName componentsSeparatedByString:@"."];
        NSString *fileDateStr = [fileDates firstObject];
        NSDate *fileDate = [self.dateFormatter dateFromString:fileDateStr];
        NSDate *currentDate = [self getCurrentDate];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSCalendarUnit unit = NSCalendarUnitDay;
        NSDateComponents *components = [calendar components:unit fromDate:fileDate toDate:currentDate options:0];
        if (components.day > HMMAXSaveDay) {
            // 删除大于7天的日志
            NSString *filePath = [[self absoluteFolderPath] stringByAppendingPathComponent:fileName];
            [self.fileManager removeItemAtPath:filePath error:nil];
        }
    }
}

///APP_LOG file folder
- (NSString *)absoluteFolderPath {
    return [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@",HMFolderName]];
}

- (NSDate *)getCurrentDate{
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localeDate = [date dateByAddingTimeInterval:interval];
    return localeDate;
}

- (void)writeFile:(NSString *)filePath WithStringData:(NSString *)writeStr{
    
    NSData *writeData = [writeStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *folderPath = [self absoluteFolderPath];
    // 若文件夹不存在,则创建该文件夹
    if (![self.fileManager fileExistsAtPath:folderPath]) {
           [self.fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
       
    // 若文件不存在,则创建该文件
    if (![self.fileManager fileExistsAtPath:filePath]) {
        [writeData writeToFile:filePath atomically:NO];
    }
    else{
        // NSFileHandle 用于处理文件内容
        // 读取文件到上下文，并且是更新模式
        NSFileHandle* fileHandler = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
        
        // 跳到文件末尾
        [fileHandler seekToEndOfFile];
        
        // 追加数据
        [fileHandler writeData:writeData];
        
        // 关闭文件
        [fileHandler closeFile];
    }
}

#pragma mark - setter
- (void)setLevel:(HMLogLevel)level {
    _level = level;
}

@end
