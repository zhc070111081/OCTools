//
//  HMDownloadManager.m
//  OCToolsClass
//
//  Created by 心诚 on 2021/8/24.
//

#import "HMDownloadManager.h"
#import <CommonCrypto/CommonCrypto.h>

#define CACHES [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define FILECACHE @"downloadCaches"
#define FILEPATH [CACHES stringByAppendingPathComponent:FILECACHE]
@interface HMDownloadSource ()

/// 输出流
@property (strong, nonatomic, nullable) NSOutputStream *stream;

@end

@implementation HMDownloadSource

- (NSOutputStream *)stream {
    
    if (_stream == nil) {
        _stream = [[NSOutputStream alloc] initToFileAtPath:self.filePath append:YES];
    }
    return _stream;
}

- (void)setUrl:(NSString *)url {
    _url = url;
}

- (void)setFilePath:(NSString *)filePath {
    _filePath = filePath;
}

- (void)setFileName:(NSString *)fileName {
    _fileName = fileName;
}

- (void)setTask:(NSURLSessionDataTask *)task {
    _task = task;
}

- (void)setState:(HMDownloadState)state {
    _state = state;
}

- (void)setTotalBytesWritten:(int64_t)totalBytesWritten {
    _totalBytesWritten = totalBytesWritten;
}

- (void)setTotalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    _totalBytesExpectedToWrite = totalBytesExpectedToWrite;
}

@end

static HMDownloadManager *_manager = nil;

@interface HMDownloadManager ()<NSURLSessionDataDelegate>

@property (strong, nonatomic, nullable) NSURLSession *session;

@property (strong, nonatomic, nullable) NSMutableArray *dataSources;

@end

@implementation HMDownloadManager

+ (instancetype)defaultManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[HMDownloadManager alloc] init];
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

- (id)copyWithZone:(nullable NSZone *)zone {
    return _manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupConfig];
    }
    return self;
}

- (NSURLSession *)session {
    
    if (_session == nil) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:queue];
    }
    
    return _session;
}

- (NSMutableArray *)dataSources {
    
    if (_dataSources == nil) {
        _dataSources = [NSMutableArray array];
    }
    
    return _dataSources;
}


- (HMDownloadSource *)downloadWithUrl:(NSString *)url allHTTPHeaderFields:(nullable NSDictionary<NSString *,NSString *> *)allHTTPHeaderFields{
    
    HMDownloadSource *source = [[HMDownloadSource alloc] init];
    [source setUrl:[url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    [source setFileName:[self getFileName:source.url]];
    [source setFilePath:[self filePath:source.fileName]];
    [source setTask:[self dataTaskWithUrl:url allHTTPHeaderFields:allHTTPHeaderFields]];
    source.state = HMDownloadStateDown;
    // 开启任务
    [source.task resume];
    [self.dataSources addObject:source];
    return source;
}

- (HMDownloadSource *)downloadWithUrl:(NSString *)url allHTTPHeaderFields:(NSDictionary<NSString *,NSString *> *)allHTTPHeaderFields progress:(void (^)(HMDownloadSource * _Nullable))downloadProgress complete:(void (^)(HMDownloadSource * _Nullable, NSError * _Nullable))complete {
    
    HMDownloadSource *source = [self downloadWithUrl:url allHTTPHeaderFields:allHTTPHeaderFields];
    
    source.progress = downloadProgress;
    source.complete = complete;
    
    return source;
}


- (NSURLSessionDataTask *)dataTaskWithUrl:(NSString *)urlString allHTTPHeaderFields:(nullable NSDictionary<NSString *,NSString *> *)allHTTPHeaderFields{
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    if (allHTTPHeaderFields) {
        [request setAllHTTPHeaderFields:allHTTPHeaderFields];
    }
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request];
    return task;
}

- (void)setupConfig {
    [self createFileCachesDir];
}

- (void)createFileCachesDir {
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:FILEPATH]) {
        [manager createDirectoryAtPath:FILEPATH withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

- (NSString *)filePath:(NSString *)fileName {
    NSLog(@"filePath: %@",FILEPATH);
    return [FILEPATH stringByAppendingPathComponent:fileName];
}

- (NSString *)getFileName:(NSString *)url {
    NSArray *prefix_Suffix = [url componentsSeparatedByString:@"."];
    NSString *fileName = [[self sha256String:url] stringByAppendingFormat:@".%@",[prefix_Suffix lastObject]];
    return fileName;
}

#pragma mark - NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
    NSLog(@"%@",res.allHeaderFields);
    dispatch_async(dispatch_get_main_queue(), ^{
        for (HMDownloadSource *source in self.dataSources) {
            if (source.task == dataTask) {
                [source.stream open];
                source.totalBytesExpectedToWrite = source.totalBytesWritten + response.expectedContentLength;
            }
        }
    });
    
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        for (HMDownloadSource *source in self.dataSources) {
            if (source.task == dataTask) {
                
                source.totalBytesWritten += data.length;
                [source.stream write:data.bytes maxLength:data.length];
                
                if (source.progress) source.progress(source);
            }
        }
    });
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    
    if (error) {
        NSLog(@"error: %@ --- info: %@",error,error.userInfo);
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        HMDownloadSource *currentSource = nil;
        for (HMDownloadSource *source in self.dataSources) {
            if (source.task == task) {
                [source.stream close];
                source.stream = nil;
                
                currentSource = source;
                if (error) {
                    source.state = HMDownloadStateFail;
                }
                else {
                    currentSource.state = HMDownloadStateFinished;
                }
            }
        }
        
        if (currentSource) {
            [self.dataSources removeObject:currentSource];
            if (currentSource.complete) currentSource.complete(currentSource, error);
        }
    });
}

#pragma mark - md5 or sha256
- (NSString *)sha256String:(NSString *)string {
    
    const char *data = [string UTF8String];
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data, (CC_LONG)strlen(data), result);
    
    // 转乘OC字符串
    NSMutableString *str = [NSMutableString string];
    for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [str appendFormat:@"%02X",result[i]];
    }
    // 可以转成大写
    return str;
}


@end
