//
//  HMAdapterLayout.m
//  OCToolsClass
//
//  Created by 心诚 on 2021/8/24.
//

#import "HMAdapterLayout.h"
#import <sys/utsname.h>

@implementation HMAdapterLayout

#pragma mark - 机型
+ (BOOL)iPhoneX {
    
    // iPadb
    BOOL is_iPad = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
    
    // iPhone X || iPhone XS || iPhone 11 Pro || iPhone 12 mini
    BOOL is_iPhoneX = [UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2436), [UIScreen mainScreen].currentMode.size) && !is_iPad) : NO;
    
    // iPhone XR || iPhone 11
    BOOL is_iPhone11 = [UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(828, 1792), [UIScreen mainScreen].currentMode.size) && !is_iPad) : NO;
    
    // iPhone XS Max || iPhone 11 Pro Max
    BOOL is_iPhone11_ProMax = [UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1242, 2688), [UIScreen mainScreen].currentMode.size) && !is_iPad) : NO;
    
    // iPhone 12 mini
    // 代码打印的分辨率为iPhone X的分辨率 和 apple 给出的不符
    BOOL is_iPhone12_mini = [UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1080, 2340), [UIScreen mainScreen].currentMode.size) && !is_iPad) : NO;
    
    // iPhone 12 || iPhone 12 Pro
    BOOL is_iPhone12 = [UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1170, 2532), [UIScreen mainScreen].currentMode.size) && !is_iPad) : NO;
    
    // iPhone 12 Pro Max
    BOOL is_iPhone12_ProMax = [UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1284, 2778), [UIScreen mainScreen].currentMode.size) && !is_iPad) : NO;
    
    BOOL reslut = (is_iPhoneX || is_iPhone11 || is_iPhone11_ProMax || is_iPhone12 || is_iPhone12_ProMax || is_iPhone12_mini);
    
    return reslut;
}

+ (BOOL)iPad {
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
}

+ (BOOL)iPhone {
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone;
}

#pragma mark - frame
+ (CGFloat)width {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)height {
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGRect)bounds {
    return [UIScreen mainScreen].bounds;
}

+ (CGFloat)navigationBarHeight {
    
    CGFloat height = 44.0f;
    CGFloat statusH = [self statusBarHeight];
    
    return (height + statusH);
}

+ (CGFloat)statusBarHeight {
    CGFloat statusH = 20.0f;
    if (@available(iOS 13.0, *)) {
        UIWindowScene *windowScene = [self windowScene];
        statusH = windowScene.statusBarManager.statusBarFrame.size.height;
        if (!windowScene) {
            statusH = [UIApplication sharedApplication].statusBarFrame.size.height;
        }
    }
    else {
        statusH = [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    
    return statusH;
}

#pragma mark - 视图

+ (UIViewController *)rootViewController {
    UIWindow *window = [self keyWindow];
    UIViewController *rootVC = window.rootViewController;
    return rootVC;
}

+ (UIViewController *)topViewController {
    
    UIViewController *topVC = [self rootViewController];
    
    UIViewController *tempVC = topVC;
    
    while (1) {
        
        if ([topVC isKindOfClass:[UITabBarController class]]) {
            topVC = [((UITabBarController *)topVC) selectedViewController];
        }
        
        if ([topVC isKindOfClass:[UINavigationController class]]) {
            topVC = [((UINavigationController *)topVC) visibleViewController];
        }
        
        // 针对iPad适配
//        if ([topVC isKindOfClass:[UISplitViewController class]]) {
//            topVC = [((UISplitViewController *)topVC) presentedViewController];
//        }
        
        if (topVC.presentedViewController) {
            topVC = topVC.presentedViewController;
        }
        
        if ([tempVC isEqual:topVC]) {
            break;
        }
        else {
            tempVC = topVC;
        }
    }
    
    return topVC;
}

+ (UIWindow *)keyWindow {
    
    UIWindow *keyWindow = nil;
    
    if (@available(iOS 13.0, *)) {
        
        UIWindowScene *scene = [self windowScene];
        for (UIWindow *tWindow in scene.windows) {
            if (tWindow.isKeyWindow) {
                keyWindow = tWindow;
                break;
            }
        }
        
        if (!keyWindow) {
            keyWindow = [UIApplication sharedApplication].keyWindow;
        }
        
    } else {
        keyWindow = [UIApplication sharedApplication].keyWindow;
    }
    
    return keyWindow;
}

+ (UIWindowScene *)windowScene {
    
    UIWindowScene *windowScene = nil;
    
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene *scene in [UIApplication sharedApplication].connectedScenes) {
            if (scene.activationState == UISceneActivationStateForegroundActive) {
                windowScene = scene;
                break;
            }
        }
    }
    
    return windowScene;
}

#pragma mark - device info

+ (NSString *)deviceName {
    return [[UIDevice currentDevice] name];
}

+ (NSString *)systemName {
    return [[UIDevice currentDevice] systemName];
}

+ (NSString *)systemVersion {
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)deviceModel {
    return [[UIDevice currentDevice] model];
}

+ (NSString *)localizedModel {
    return [[UIDevice currentDevice] localizedModel];
}

+ (NSString *)deviceModelName {
    // 需要#import <sys/utsname.h>
    struct utsname systemInfo;
    uname(&systemInfo);
    // 获取设备标识Identifier
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,6"]) return @"iPhone XS MAX";
    if ([platform isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    if ([platform isEqualToString:@"iPhone12,1"]) return @"iPhone 11";
    if ([platform isEqualToString:@"iPhone12,3"]) return @"iPhone 11 Pro";
    if ([platform isEqualToString:@"iPhone12,5"]) return @"iPhone 11 Pro Max";
    if ([platform isEqualToString:@"iPhone12,8"]) return @"iPhone SE (2nd generation)";
    if ([platform isEqualToString:@"iPhone13,1"]) return @"iPhone 12 mini";
    if ([platform isEqualToString:@"iPhone13,2"]) return @"iPhone 12";
    if ([platform isEqualToString:@"iPhone13,3"]) return @"iPhone 12 Pro";
    if ([platform isEqualToString:@"iPhone13,4"]) return @"iPhone 12 Pro Max";
    
    // iPod
    if ([platform isEqualToString:@"iPod1,1"])  return @"iPod Touch 1";
    if ([platform isEqualToString:@"iPod2,1"])  return @"iPod Touch 2";
    if ([platform isEqualToString:@"iPod3,1"])  return @"iPod Touch 3";
    if ([platform isEqualToString:@"iPod4,1"])  return @"iPod Touch 4";
    if ([platform isEqualToString:@"iPod5,1"])  return @"iPod Touch 5";
    if ([platform isEqualToString:@"iPod7,1"])  return @"iPod Touch 6";
    if ([platform isEqualToString:@"iPod9,1"])  return @"iPod Touch 7";
    
    // iPad
    if ([platform isEqualToString:@"iPad1,1"])  return @"iPad 1";
    if ([platform isEqualToString:@"iPad2,1"])  return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])  return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"])  return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])  return @"iPad Mini 1";
    if ([platform isEqualToString:@"iPad2,6"])  return @"iPad Mini 1";
    if ([platform isEqualToString:@"iPad2,7"])  return @"iPad Mini 1";
    if ([platform isEqualToString:@"iPad3,1"])  return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,2"])  return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,3"])  return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"])  return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,5"])  return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])  return @"iPad 4";
    if ([platform isEqualToString:@"iPad4,1"])  return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"])  return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"])  return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"])  return @"iPad Mini 2";
    if ([platform isEqualToString:@"iPad4,5"])  return @"iPad Mini 2";
    if ([platform isEqualToString:@"iPad4,6"])  return @"iPad Mini 2";
    if ([platform isEqualToString:@"iPad4,7"])  return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,8"])  return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,9"])  return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad5,1"])  return @"iPad mini 4";
    if ([platform isEqualToString:@"iPad5,2"])  return @"iPad mini 4";
    if ([platform isEqualToString:@"iPad5,3"])  return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad5,4"])  return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad6,3"])  return @"iPad Pro (9.7-inch)";
    if ([platform isEqualToString:@"iPad6,4"])  return @"iPad Pro (9.7-inch)";
    if ([platform isEqualToString:@"iPad6,7"])  return @"iPad Pro (12.9-inch)";
    if ([platform isEqualToString:@"iPad6,8"])  return @"iPad Pro (12.9-inch)";
    if ([platform isEqualToString:@"iPad6,11"])  return @"iPad 5";
    if ([platform isEqualToString:@"iPad6,12"])  return @"iPad 5";
    if ([platform isEqualToString:@"iPad7,1"])  return @"iPad Pro 2(12.9-inch)";
    if ([platform isEqualToString:@"iPad7,2"])  return @"iPad Pro 2(12.9-inch)";
    if ([platform isEqualToString:@"iPad7,3"])  return @"iPad Pro (10.5-inch)";
    if ([platform isEqualToString:@"iPad7,4"])  return @"iPad Pro (10.5-inch)";
    if ([platform isEqualToString:@"iPad7,5"])  return @"iPad 6";
    if ([platform isEqualToString:@"iPad7,6"])  return @"iPad 6";
    if ([platform isEqualToString:@"iPad7,11"])  return @"iPad 7";
    if ([platform isEqualToString:@"iPad7,12"])  return @"iPad 7";
    if ([platform isEqualToString:@"iPad8,1"])  return @"iPad Pro (11-inch) ";
    if ([platform isEqualToString:@"iPad8,2"])  return @"iPad Pro (11-inch) ";
    if ([platform isEqualToString:@"iPad8,3"])  return @"iPad Pro (11-inch) ";
    if ([platform isEqualToString:@"iPad8,4"])  return @"iPad Pro (11-inch) ";
    if ([platform isEqualToString:@"iPad8,5"])  return @"iPad Pro 3 (12.9-inch) ";
    if ([platform isEqualToString:@"iPad8,6"])  return @"iPad Pro 3 (12.9-inch) ";
    if ([platform isEqualToString:@"iPad8,7"])  return @"iPad Pro 3 (12.9-inch) ";
    if ([platform isEqualToString:@"iPad8,8"])  return @"iPad Pro 3 (12.9-inch) ";
    if ([platform isEqualToString:@"iPad11,1"])  return @"iPad mini 5";
    if ([platform isEqualToString:@"iPad11,2"])  return @"iPad mini 5";
    if ([platform isEqualToString:@"iPad11,3"])  return @"iPad Air 3";
    if ([platform isEqualToString:@"iPad11,4"])  return @"iPad Air 3";
    
    // Other
    if ([platform isEqualToString:@"i386"])   return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])  return @"iPhone Simulator";
    
    return platform;
}

#pragma mark - 方向
+ (UIInterfaceOrientation)currentOrientation {
    
    UIInterfaceOrientation orientation = UIInterfaceOrientationUnknown;
    
    if (@available(iOS 13.0, *)) {
        UIWindowScene *windowScene = [self windowScene];
        if (!windowScene) {
            orientation = windowScene.interfaceOrientation;
        }
        else {
            orientation = [UIApplication sharedApplication].statusBarOrientation;
        }
        
    } else {
        orientation = [UIApplication sharedApplication].statusBarOrientation;
    }
    
    return orientation;
}


+ (BOOL)isPortrait {
    UIInterfaceOrientation orientation = [self currentOrientation];
    if (orientation == UIInterfaceOrientationPortrait) {
        return YES;
    }
    return NO;
}

+ (BOOL)isLandscape {
    UIInterfaceOrientation orientation = [self currentOrientation];
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        return YES;
    }
    return NO;
}

#pragma mark - random color
+ (UIColor *)randomColor {
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}



@end
