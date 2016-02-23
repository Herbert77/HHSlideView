//
//  HHSlideView.h
//  HHSlideView
//
//  Created by Herbert Hu on 15/10/16.
//  Copyright © 2015年 Herbert Hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HHSlideView;
@protocol HHSlideViewDelegate <NSObject>

@required
- (NSInteger)numberOfSlideItemsInSlideView:(HHSlideView *)slideView;

- (NSArray *)namesOfSlideItemsInSlideView:(HHSlideView *)slideView;

- (NSArray *)childViewControllersInSlideView:(HHSlideView *)slideView; /**< 分段选择视图的子视图控制器 */

- (void)slideView:(HHSlideView *)slideView didSelectItemAtIndex:(NSInteger)index;

@optional
- (UIColor *)colorOfSliderInSlideView:(HHSlideView *)slideView;

- (UIColor *)colorOfSlideView:(HHSlideView *)slideView;

@end

/**
 *  带滑块效果的分段选择视图
 */
@interface HHSlideView : UIView

@property (weak, nonatomic) id<HHSlideViewDelegate> delegate;

@property (assign, nonatomic, readonly) NSInteger numberOfSlideItems; /**< 组成单件数量 */

@property (strong, nonatomic, readonly) NSArray *namesOfSlideItems;   /**< 各个单件的名字 */

@property (strong, nonatomic, readonly) UIColor *colorOfSlider;       /**< 底部滑块的颜色 */

@property (strong, nonatomic, readonly) UIColor *colorOfSlideView;    /**< 视图的整体颜色 */

@end


