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

+ (instancetype)alertWithTitle:(nullable NSString *)title
                       message:(nullable NSString *)message
                       buttons:(nullable NSArray<NSString *> *)buttons
                      callback:(void(^)(HMAlertStyle index))callback;

@end

NS_ASSUME_NONNULL_END
