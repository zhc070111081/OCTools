
#define HMSingletonH(name) +(instancetype)share##name;

#define HMSingletonM(name) \
static id _instance; \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
    static dispatch_once_t once; \
    dispatch_once(&once, ^{ \
        _instance = [super allocWithZone:zone]; \
    }); \
    return _instance; \
} \
\
+ (instancetype)share##name { \
    static dispatch_once_t once; \
    dispatch_once(&once, ^{ \
        _instance = [[self alloc] init]; \
    }); \
    return _instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone { \
    return _instance; \
}
