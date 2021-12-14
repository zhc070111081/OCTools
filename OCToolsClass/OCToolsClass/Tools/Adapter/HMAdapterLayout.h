//
//  HMAdapterLayout.h
//  OCToolsClass
//
//  Created by 心诚 on 2021/8/24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define NAVHEIGHT [HMAdaptiveLayoutHelper navigationBarHeight]

#define iPhoneX_Series [HMAdaptiveLayoutHelper iPhoneX]

NS_ASSUME_NONNULL_BEGIN

@interface HMAdapterLayout : NSObject

#pragma mark - 机型

/// 是否是iPhone X 系列及更新机型手机
/// @return YES or NO
+ (BOOL)iPhoneX;

/// 是否是iPad
/// @return YES or NO
+ (BOOL)iPad;

/// 是否是iPhone
/// @return YES or NO
+ (BOOL)iPhone;

#pragma mark - frame

/// 获取UIScreen 的 宽度
/// @return width
+ (CGFloat)width;

/// 获取UIScreen 的 高度
/// @return height
+ (CGFloat)height;

/// 获取UIScreen 的 bounds
/// @return bounds
+ (CGRect)bounds;

/// 获取导航栏高度
/// @return height
+ (CGFloat)navigationBarHeight;

/// 获取状态栏的高度
/// @return statusBarHeight
+ (CGFloat)statusBarHeight;

#pragma mark - 视图
/// 获取当前的根控制器
/// @return rootViewController
+ (UIViewController * _Nullable)rootViewController;

/// 获取当前顶层的控制器(当前展示的控制器)
/// @return topViewController
+ (UIViewController * _Nullable)topViewController;

/// 获取当前根控制器
/// @return keyWindow
+ (UIWindow * _Nullable)keyWindow;

/// 获取当前Application的 scene 适配iOS13.0 and later
/// @return windowScene
+ (UIWindowScene * _Nullable)windowScene API_AVAILABLE(ios(13.0));

#pragma mark - 设备相关信息

/**!
 设备名称 e.g. "My iPhone"
 */
+ (nullable NSString *)deviceName;

/**!
 系统名称 e.g. @"iOS"
 */
+ (nullable NSString *)systemName;

/**!
 系统版本  e.g. @"4.0"
 */
+ (nullable NSString *)systemVersion;

/**!
 设备模式 e.g. @"iPhone", @"iPod touch"
 */
+ (nullable NSString *)deviceModel;

/**!
 本地设备模式 localized version of model
 */
+ (nullable NSString *)localizedModel;

/// 当前设备模式名称
/// iPhone 2G ~ iPhone 12
+ (nullable NSString *)deviceModelName;

#pragma mark - 方向

/// 获取当前设备的方向
/// @return UIInterfaceOrientation
+ (UIInterfaceOrientation)currentOrientation;

/// 是否是竖屏状态
/// @return YES or NO
+ (BOOL)isPortrait;

/// 是否是横屏状态
/// @return YES or NO
+ (BOOL)isLandscape;

#pragma mark - random color

/// 获取随机颜色
+ (nonnull UIColor *)randomColor;

@end

NS_ASSUME_NONNULL_END
