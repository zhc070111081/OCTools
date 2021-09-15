//
//  HMNetworkManager.m
//  OCToolsClass
//
//  Created by zhuhc on 2021/8/30.
//

#import "HMNetworkManager.h"

//static NSTimeInterval const TIMEOUT = 15.0;

static HMNetworkManager *_network = nil;


@interface HMNetworkManager ()

// @property (strong, nonatomic, nullable) AFHTTPSessionManager *manager;

@end

@implementation HMNetworkManager

+ (instancetype)shareManager {
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _network = [[HMNetworkManager alloc] init];
    });
    
    return _network;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _network = [super allocWithZone:zone];
    });
    
    return _network;
}

- (id)copyWithZone:(NSZone *)zone {
    return _network;
}


#pragma mark - init

- (instancetype)init {
    
    self = [super init];
    if (self) {
       // [self setupManager];
    }
    
    return self;
}
/*
- (void)setupManager {

    self.manager = [AFHTTPSessionManager manager];
    self.manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    // self.manager.requestSerializer  = [AFJSONRequestSerializer serializer];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 设置默认信任证书
    AFSecurityPolicy *policy = [AFSecurityPolicy defaultPolicy];
    policy.validatesDomainName = NO;
    policy.allowInvalidCertificates = YES;
    [self.manager setSecurityPolicy:policy];
    
    // 设置请求超时时间
    self.manager.requestSerializer.timeoutInterval = YJTIMEOUT;
    
    // 设置返回接受格式
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/json",@"application/x-www-form-urlencoded", nil];
    
    [self.manager.requestSerializer setValue:@"com.huawei.gdelink" forHTTPHeaderField:@"X-HW-ID"];
    [self.manager.requestSerializer setValue:@"AXPnun2v+SsV+DrTkJ6tRg==" forHTTPHeaderField:@"X-HW-APPKEY"];
}


#pragma mark - public action

+ (void)setValue:(nullable NSString *)value forHTTPHeaderField:(nonnull NSString *)field {
    YJNetworkManager *network = [YJNetworkManager shareNetwork];
    [network.manager.requestSerializer setValue:value forHTTPHeaderField:field];
}

+ (void)setTimeoutInterval:(NSTimeInterval)timeoutInterval {
    if (timeoutInterval <= 0) return;
    
    YJNetworkManager *network = [YJNetworkManager shareNetwork];
    [network.manager.requestSerializer setTimeoutInterval:timeoutInterval];
}


- (NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(id)parameters headers:(NSDictionary<NSString *,NSString *> *)headers progress:(void (^)(NSProgress * _Nonnull))downloadProgress success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    
    if (!URLString) {
        return nil;
    }
    
    NSURLSessionDataTask *task = [self.manager GET:URLString parameters:parameters headers:headers progress:downloadProgress success:success failure:failure];
    
    return task;
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters headers:(NSDictionary<NSString *,NSString *> *)headers progress:(void (^)(NSProgress * _Nonnull))uploadProgress success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    
    if (!URLString) {
        return nil;
    }
    
    NSURLSessionDataTask *task = [self.manager POST:URLString parameters:parameters headers:headers progress:uploadProgress success:success failure:failure];
    
    return task;
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters headers:(NSDictionary<NSString *,NSString *> *)headers constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> _Nonnull))block progress:(void (^)(NSProgress * _Nonnull))uploadProgress success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    
    if (!URLString) {
        return nil;
    }
    
    NSURLSessionDataTask *task = [self.manager POST:URLString parameters:parameters headers:headers constructingBodyWithBlock:block progress:uploadProgress success:success failure:failure];
    
    return task;
}
 
 - (NSURLSessionDownloadTask *)downloadTaskWithUrl:(NSString *)URLString allHTTPHeaderFields:(NSDictionary<NSString *,NSString *> *)allHTTPHeaderFields progress:(void (^)(NSProgress * _Nonnull))downloadProgress destination:(NSURL * _Nonnull (^)(NSURL * _Nonnull, NSURLResponse * _Nonnull))destination completionHandler:(void (^)(NSURLResponse * _Nonnull, NSURL * _Nullable, NSError * _Nullable))completionHandler {
     if (!URLString) {
         return nil;
     }
     
     NSURL *url = [NSURL URLWithString:URLString];
     NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
     if (allHTTPHeaderFields) {
         [request setAllHTTPHeaderFields:allHTTPHeaderFields];
     }
     return [self.manager downloadTaskWithRequest:request progress:downloadProgress destination:destination completionHandler:completionHandler];
 }
 
*/

@end
