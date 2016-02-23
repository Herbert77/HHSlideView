//
//  ViewController.m
//  HHSlideViewExample
//
//  Created by Herbert Hu on 16/2/23.
//  Copyright © 2016年 Herbert Hu. All rights reserved.
//

#import "ViewController.h"
#import "HHSlideView.h"
#import "UIColor+extend.h"

//#define Pink_Color                    [UIColor colorWithRed:247 / 255.0 green:172 / 255.0 blue:188 / 255.0 alpha:1.0]
//#define Cyan_Color                    [UIColor colorWithRed:175 / 255.0 green:223 / 255.0 blue:228 / 255.0 alpha:1.0]
//#define Purple_Color                  [UIColor colorWithRed:199 / 255.0 green:126 / 255.0 blue:181 / 255.0 alpha:1.0]
//#define Green_Color                   [UIColor colorWithRed:115 / 255.0 green:185 / 255.0 blue:162 / 255.0 alpha:1.0]


@interface ViewController () <HHSlideViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [navigationView setBackgroundColor:[UIColor getColor:@"#78cdd1"]];
    [self.view addSubview:navigationView];
    
    HHSlideView *slideView = [[HHSlideView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    slideView.delegate = self;
    [self.view addSubview:slideView];
    
}

#pragma mark - HHSlideViewDelegate

- (NSInteger)numberOfSlideItemsInSlideView:(HHSlideView *)slideView {
    
    return 4;
}

- (NSArray *)namesOfSlideItemsInSlideView:(HHSlideView *)slideView {
    
    NSArray *dataArray = [[NSArray alloc] initWithObjects:@"Embody", @"Aeron", @"Mirra", @"SAYL", nil];
    return dataArray;
}

- (void)slideView:(HHSlideView *)slideView didSelectItemAtIndex:(NSInteger)index {
    
    
    NSLog(@" index %li", index);
}

- (NSArray *)childViewControllersInSlideView:(HHSlideView *)slideView {
    
    UIViewController *vc_1 = [UIViewController new];
    [vc_1.view setBackgroundColor:[UIColor getColor:@"#228fbd"]];
    UITableViewController *vc_2 = [UITableViewController new];
    [vc_2.view setBackgroundColor:[UIColor getColor:@"#2585a6"]];
    UIViewController *vc_3 = [UIViewController new];
    [vc_3.view setBackgroundColor:[UIColor getColor:@"#228fbd"]];
    UITableViewController *vc_4 = [UITableViewController new];
    [vc_4.view setBackgroundColor:[UIColor getColor:@"#2468a2"]];
    
    NSArray *childViewControllersArray = @[vc_1, vc_2, vc_3, vc_4];
    
    return childViewControllersArray;
}

- (UIColor *)colorOfSlideView:(HHSlideView *)slideView {
    
    return [UIColor getColor:@"#464547"];
}

- (UIColor *)colorOfSliderInSlideView:(HHSlideView *)slideView {
    
    return [UIColor getColor:@"#90d7ec"];
}

@end
