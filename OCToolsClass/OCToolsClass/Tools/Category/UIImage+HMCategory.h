//
//  UIImage+HMCategory.h
//  CommonTools-OC
//
//  Created by 心诚 on 2021/7/8.
//  Copyright © 2021 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (HMCategory)

/// 图片水印
/// @param content 水印内容
/// @param contentRect 内容位置
/// @param attrs 内容属性
/// @param contentImage 水印图片
/// @param imageRect 图片位置
- (nullable UIImage *)watermarkWithContent:(nullable NSString *)content
                      contentRect:(CGRect)contentRect
                   withAttributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs
                     contentImage:(nullable UIImage *)contentImage
                        imageRect:(CGRect)imageRect;

/// 图片裁剪(圆形)
/// @param image 待裁剪的图片
/// @param border 边框
/// @param borderColor 边框颜色
+ (nullable UIImage *)imageWithClipImage:(nullable UIImage *)image border:(CGFloat)border borderColor:(nullable UIColor *)borderColor;

/// 控件截屏
/// @param targetView 待截屏的控件
+ (nullable UIImage *)imageWithCaputure:(nullable UIView *)targetView;

@end

NS_ASSUME_NONNULL_END
