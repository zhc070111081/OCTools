//
//  HMNetworkManager.h
//  OCToolsClass
//
//  Created by zhuhc on 2021/8/30.
//

#import <Foundation/Foundation.h>
//#import <AFNetworking/AFNetworking.h>
NS_ASSUME_NONNULL_BEGIN
/*
 网络请求基于AFNetworking封装
 */
@interface HMNetworkManager : NSObject


/// single class
+ (instancetype)shareManager;
/*
/// 设置请求头
/// @param value value
/// @param field key
+ (void)setValue:(nullable NSString *)value forHTTPHeaderField:(nonnull NSString *)field;

/// 设置请求超时时间
/// @param timeoutInterval 超时时间
+ (void)setTimeoutInterval:(NSTimeInterval)timeoutInterval;

/// GET request
/// @param URLString URL
/// @param parameters request body
/// @param headers request header
/// @param downloadProgress downloadProgress
/// @param success success description
/// @param failure failure description
- (nullable NSURLSessionDataTask *)GET:(nonnull NSString *)URLString
                            parameters:(nullable id)parameters
                               headers:(nullable NSDictionary <NSString *, NSString *> *)headers
                              progress:(nullable void (^)(NSProgress *downloadProgress))downloadProgress
                               success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

/// POST request
/// @param URLString URL
/// @param parameters request body
/// @param headers request header
/// @param uploadProgress uploadProgress
/// @param success success description
/// @param failure failure description
- (nullable NSURLSessionDataTask *)POST:(nonnull NSString *)URLString
                             parameters:(nullable id)parameters
                                headers:(nullable NSDictionary <NSString *, NSString *> *)headers
                               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

/// POST request
/// @param URLString URL
/// @param parameters request body
/// @param headers request header
/// @param block block description
/// @param uploadProgress uploadProgress description
/// @param success success description
/// @param failure failure description
- (nullable NSURLSessionDataTask *)POST:(nonnull NSString *)URLString
                             parameters:(nullable id)parameters
                                headers:(nullable NSDictionary <NSString *, NSString *> *)headers
              constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
                               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

 
 
 - (nullable NSURLSessionDownloadTask *)downloadTaskWithUrl:(nonnull NSString *)URLString
                                        allHTTPHeaderFields:(nullable NSDictionary<NSString *, NSString *> *)allHTTPHeaderFields
                                                   progress:(nullable void (^)(NSProgress *downloadProgress))downloadProgress
                                                destination:(nullable NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                                          completionHandler:(nullable void (^)(NSURLResponse *response, NSURL * _Nullable filePath, NSError * _Nullable error))completionHandler;
 */
@end

NS_ASSUME_NONNULL_END
