//
//  HMToastView.h
//  OCToolsClass
//
//  Created by zhuhc on 2021/8/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HMToastView : UIView

+ (void)showString:(nullable NSString *)content;

+ (void)showString:(nullable NSString *)content inView:(nullable UIView *)view;

+ (void)showString:(nullable NSString *)content duration:(CGFloat)duration;

+ (void)showString:(nullable NSString *)content duration:(CGFloat)duration inView:(nullable UIView *)view;

@end

NS_ASSUME_NONNULL_END
