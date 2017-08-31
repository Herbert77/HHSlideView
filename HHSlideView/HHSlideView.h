//
//  HHSlideView.h
//  HHSlideView
//
//  Created by Herbert Hu on 2017/8/28.
//  Copyright © 2017年 Herbert Hu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HHSlideView;
@protocol HHSlideViewDelegate <NSObject>

@optional
- (UIColor *)colorOfBar:(HHSlideView *)slideView;
- (UIColor *)colorOfSlider:(HHSlideView *)slideView;
- (UIColor *)colorOfTitle:(HHSlideView *)slideView;
- (UIColor *)colorOfHighlightedTitle:(HHSlideView *)slideView;
@end

@protocol HHSlideViewDataSource <NSObject>

@required
- (NSArray *)childViewControllersInSlideView:(HHSlideView *)slideView;

@end

@interface HHSlideView : UIView

- (instancetype)initWithItemsArray:(nonnull NSArray *)itemsArray;

@property (weak, nonatomic) id<HHSlideViewDelegate> delegate;
@property (weak, nonatomic) id<HHSlideViewDataSource> dataSource;

@end

NS_ASSUME_NONNULL_END
