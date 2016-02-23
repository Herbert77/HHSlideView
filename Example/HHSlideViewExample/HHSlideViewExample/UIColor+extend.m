//
//  UIColor+extend.h
//  DealExtreme
//
//  Created by zhao.wang on 12-11-23.
//  Copyright 2012 epro. All rights reserved.
//

#import "UIColor+extend.h"


@implementation UIColor(extend)

+ (UIColor *)getColor:(NSString *) hexColor
{
    @synchronized(self)
    {
        if ([hexColor length] < 6) return [UIColor blackColor];
        if ([hexColor hasPrefix:@"#"]) hexColor = [hexColor substringFromIndex:1];
        if ([hexColor length] < 6) return [UIColor blackColor];
        unsigned int redInt_, greenInt_, blueInt_;
        NSRange rangeNSRange_;
        rangeNSRange_.length = 2;  // 范围长度为2
        
        // 取红色的值
        rangeNSRange_.location = 0;
        [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]] scanHexInt:&redInt_];
        
        // 取绿色的值
        rangeNSRange_.location = 2;
        [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]] scanHexInt:&greenInt_];
        
        // 取蓝色的值
        rangeNSRange_.location = 4;
        [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]] scanHexInt:&blueInt_];
        
        return [UIColor colorWithRed:(float)(redInt_/255.0f) green:(float)(greenInt_/255.0f) blue:(float)(blueInt_/255.0f) alpha:1.0f];
    }
	
}

+ (UIColor *)getColor:(NSString *) hexColor alpha:(CGFloat)alpha
{
    //线程锁@synchronized(self){}
    @synchronized(self)
    {
        if ([hexColor length] < 6) return [UIColor blackColor];
        if ([hexColor hasPrefix:@"#"]) hexColor = [hexColor substringFromIndex:1];
        if ([hexColor length] < 6) return [UIColor blackColor];
        unsigned int redInt_, greenInt_, blueInt_;
        NSRange rangeNSRange_;
        rangeNSRange_.length = 2;  // 范围长度为2
        
        // 取红色的值
        rangeNSRange_.location = 0;
        [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]] scanHexInt:&redInt_];
        
        // 取绿色的值
        rangeNSRange_.location = 2;
        [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]] scanHexInt:&greenInt_];
        
        // 取蓝色的值
        rangeNSRange_.location = 4;
        [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]] scanHexInt:&blueInt_];
        
        return [UIColor colorWithRed:(float)(redInt_/255.0f) green:(float)(greenInt_/255.0f) blue:(float)(blueInt_/255.0f) alpha:alpha];
    }
	
}

//创建纯色图片
+(UIImage *)createColorImg:(NSString *)hexColor alpha:(CGFloat)alpha
{
    UIColor *color = [UIColor getColor:hexColor alpha:alpha];
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   [color CGColor]);
    //  [[UIColor colorWithRed:222./255 green:227./255 blue: 229./255 alpha:1] CGColor]) ;
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+(UIImage *)createColorImg:(NSString *)hexColor
{
    UIColor *color = [UIColor getColor:hexColor];
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   [color CGColor]);
    //  [[UIColor colorWithRed:222./255 green:227./255 blue: 229./255 alpha:1] CGColor]) ;
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
