//
//  HMAlertViewController.h
//  OCToolsClass
//
//  Created by zhuhc on 2021/8/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HMAlertStyle){
    HMAlertStyleConfirm = 0,
    HMAlertStyleCancel,
    HMAlertStyleOther
};

@interface HMAlertViewController : UIViewController

/*!
 文本弹框
 @param title 标题
 @param message 文本内容
 @param buttons 按钮文字 目前支持最多2个按钮展示
 @param callback 回调
 */
+ (instancetype)alertWithTitle:(nullable NSString *)title
                       message:(nullable NSString *)message
                       buttons:(nullable NSArray<NSString *> *)buttons
                      callback:(void(^)(HMAlertStyle index))callback;

// TODO: - 表格弹框

// TODO: - 输入框弹框

@end

NS_ASSUME_NONNULL_END
