//
//  UIImage+HMCategory.m
//  CommonTools-OC
//
//  Created by 心诚 on 2021/7/8.
//  Copyright © 2021 Apple Inc. All rights reserved.
//

#import "UIImage+HMCategory.h"

@implementation UIImage (HMCategory)

- (UIImage *)watermarkWithContent:(NSString *)content contentRect:(CGRect)contentRect withAttributes:(NSDictionary<NSAttributedStringKey,id> *)attrs contentImage:(UIImage *)contentImage imageRect:(CGRect)imageRect{
    
    if (content == nil && contentImage == nil) return nil;
    
    // 开启位图上下文
    // size
    // NO - 透明
    // 0 - 不缩放
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    
    // 绘制原生图片
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    // 绘制文字内容
    if (content) {
        [content drawInRect:contentRect withAttributes:attrs];
    }
    
    // 绘制图片内容
    if (contentImage) {
        [contentImage drawInRect:imageRect];
    }
   
    // 获取水印图片
    UIImage *waterImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭位图上下文
    UIGraphicsEndImageContext();
    
    return waterImage;
}

+ (UIImage *)imageWithClipImage:(UIImage *)image border:(CGFloat)border borderColor:(UIColor *)borderColor {
    
    if (!image) return nil;
    
    CGFloat imageW = image.size.width + 2 * border;
    CGFloat imageH = image.size.height + 2 * border;
    
    // 1. 开启位图上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW, imageH), NO, 0);
    
    // 2. 画底部大圆 作为边框显示的颜色
    UIBezierPath *OvalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, imageW, imageH)];
    
    // 2.1 设置底部圆颜色
    if (borderColor) [borderColor set];
    
    // 2.1 填充圆
    [OvalPath fill];
    
    // 3. 添加裁剪区域
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(border, border, image.size.width, image.size.height)];
    
    [path addClip];
    
    // 4. 绘制原图片
    [image drawAtPoint:CGPointZero];
    
    // 5. 生成新的图片
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 6. 关闭上下文
    UIGraphicsEndImageContext();
    
    return clipImage;
}


+ (UIImage *)imageWithCaputure:(UIView *)targetView {
    if (!targetView) return nil;
    
    // 开启位图上下文
    UIGraphicsBeginImageContextWithOptions(targetView.bounds.size, NO, 0);
    
    // 将targetView的layer 渲染到当前上下文中
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    // 将layer 渲染到当前上下文中
    [targetView.layer renderInContext:ref];
    
    // 生成新的图片
    UIImage *caputureImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭位图上下文
    UIGraphicsEndImageContext();
    
    return caputureImage;
}

@end
