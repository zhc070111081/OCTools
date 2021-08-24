//
//  HMLockView.h
//  CommonTools-OC
//
//  Created by 心诚 on 2021/7/14.
//  Copyright © 2021 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class HMLockView;
typedef void(^HMLockCallback)(NSString * _Nullable password);

@protocol UILockViewDelegate <NSObject>

@optional
- (void)hm_lockView:(HMLockView *)lockView password:(nullable NSString *)password;

@end

@interface HMLockView : UIView

@property (nonatomic, weak, nullable) id <UILockViewDelegate> delegate;

/// call back
@property (copy, nonatomic, nullable) HMLockCallback callback;

/// line color defaut white
@property (strong, nonatomic, nullable) UIColor *lineColor;

/// line width default 3
@property (assign, nonatomic) CGFloat lineWidth;

@end

NS_ASSUME_NONNULL_END
