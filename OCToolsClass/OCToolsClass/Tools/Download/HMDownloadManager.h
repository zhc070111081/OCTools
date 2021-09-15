//
//  HMDownloadManager.h
//  OCToolsClass
//
//  Created by 心诚 on 2021/8/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class HMDownloadSource;

typedef NS_ENUM(NSInteger, HMDownloadState){
    HMDownloadStateDown = 0, // 正在下载
    HMDownloadStateSuspend = 1, // 暂停下载
    HMDownloadStateStop = 2,  // 停止下载
    HMDownloadStateFinished = 3, // 下载完成
    HMDownloadStateFail = 4 // 下载失败
};

@interface HMDownloadSource : NSObject

/// 下载地址
@property (copy, nonatomic, nullable) NSString *url;

/// 文件保存本地地址
@property (copy, nonatomic, nullable) NSString *filePath;

/// 文件名称
@property (copy, nonatomic, nullable) NSString *fileName;

/// 下载状态
@property (assign, nonatomic) HMDownloadState state;

/// 已下载文件字节数
@property (assign, nonatomic) int64_t totalBytesWritten;

/// 文件总字节数
@property (assign, nonatomic) int64_t totalBytesExpectedToWrite;

/// 请求任务
@property (strong, nonatomic, nullable) NSURLSessionDataTask *task;

/// 下载进度回调
@property (nullable, nonatomic, copy) void(^progress)(HMDownloadSource * _Nullable source);

/// 下载完成失败回调
@property (nullable, nonatomic, copy) void(^complete)(HMDownloadSource * _Nullable source, NSError * _Nullable error);

@end

@interface HMDownloadManager : NSObject

+ (instancetype)defaultManager;

- (HMDownloadSource *)downloadWithUrl:(nullable NSString *)url allHTTPHeaderFields:(nullable NSDictionary<NSString *, NSString *> *)allHTTPHeaderFields;

- (HMDownloadSource *)downloadWithUrl:(nonnull NSString *)url
                  allHTTPHeaderFields:(nullable NSDictionary<NSString *, NSString *> *)allHTTPHeaderFields
                             progress:(void(^)(HMDownloadSource * _Nullable source))downloadProgress
                             complete:(void(^)(HMDownloadSource * _Nullable source, NSError * _Nullable error))complete;

@end

NS_ASSUME_NONNULL_END
