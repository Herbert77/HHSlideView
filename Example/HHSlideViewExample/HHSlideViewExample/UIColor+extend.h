//
//  UIColor+extend.h
//  DealExtreme
//
//  Created by zhao.wang on 12-11-23.
//  Copyright 2012 epro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 扩展UIColor类
@interface UIColor(extend)

// 将十六进制的颜色值转为objective-c的颜色

+ (UIColor *)getColor:(NSString *) hexColor;
//外部直接调用此方法，传十六进制的颜色值,很好用的，嘿嘿 by wangzhao
//创建纯色图片
+(UIImage *)createColorImg:(NSString *)hexColor alpha:(CGFloat)alpha;
+(UIImage *)createColorImg:(NSString *)hexColor;
@end
