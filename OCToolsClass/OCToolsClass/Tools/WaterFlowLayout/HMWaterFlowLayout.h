//
//  HMWaterFlowLayout.h
//  CommonTools-OC
//
//  Created by 心诚 on 2021/7/5.
//  Copyright © 2021 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@class HMWaterFlowLayout;

@protocol HMWaterFlowLayoutDelegate <NSObject>

@required

/// 每个item的高度
/// @param waterFlowLayout FlowLayout
/// @param indexPath indexPath
/// @param itemWidth item width
- (CGFloat)waterFlowLayout:(HMWaterFlowLayout *)waterFlowLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth;

@optional

/// 列数
/// @param waterFlowLayout FlowLayout
- (NSInteger)columnCountInWaterFlowLayout:(HMWaterFlowLayout *)waterFlowLayout;

/// 列间距
/// @param waterFlowLayout FlowLayout
- (CGFloat)columnMarginInWaterFlowLayout:(HMWaterFlowLayout *)waterFlowLayout;

/// 行间距
/// @param waterFlowLayout FlowLayout
- (CGFloat)rowMarginInWaterFlowLayout:(HMWaterFlowLayout *)waterFlowLayout;

/// 边缘间距
/// @param waterFlowLayout FlowLayout
- (UIEdgeInsets)edgeInsetsInWaterFlowLayout:(HMWaterFlowLayout *)waterFlowLayout;

@end


@interface HMWaterFlowLayout : UICollectionViewLayout

/// 代理
@property (nonatomic, weak, nullable) id<HMWaterFlowLayoutDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
