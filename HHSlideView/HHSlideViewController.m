//
//  HHSlideViewController.m
//  HHSlideView
//
//  Created by Herbert Hu on 2017/8/28.
//  Copyright © 2017年 Herbert Hu. All rights reserved.
//

#import "HHSlideViewController.h"
#import "HHSlideView.h"
#import "Masonry.h"
#import "SubViewController.h"

#define SlideBar_Height 50

@interface HHSlideViewController () <HHSlideViewDelegate, HHSlideViewDataSource>

@property (strong, nonatomic) HHSlideView *slideView;

@end

@implementation HHSlideViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.slideView];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [_slideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(@64);
        make.height.equalTo(self.view.mas_height);
    }];
}

#pragma mark - Getter
- (HHSlideView *)slideView {
    
    if (!_slideView) {
        
        NSArray *itemsArray = [[NSArray alloc] initWithObjects:@"Embody", @"Aeron", @"Mirra", @"Sayl",nil];
        _slideView = [[HHSlideView alloc] initWithItemsArray:itemsArray];
        _slideView.delegate = self;
        _slideView.dataSource = self;
    }
    return _slideView;
}

#pragma mark - HHSlideView Delegate
//- (UIColor *)colorOfBar:(HHSlideView *)slideView {
//    
//    return [UIColor greenColor];
//}

#pragma mark - HHSlideView DataSource
- (NSArray *)childViewControllersInSlideView:(HHSlideView *)slideView {
    
    SubViewController *subVC_1 = [[SubViewController alloc] initWithImage:[UIImage imageNamed:@"embody_chair"]];
    SubViewController *subVC_2 = [[SubViewController alloc] initWithImage:[UIImage imageNamed:@"aeron_chair"]];
    SubViewController *subVC_3 = [[SubViewController alloc] initWithImage:[UIImage imageNamed:@"mirra2_chair"]];
    SubViewController *subVC_4 = [[SubViewController alloc] initWithImage:[UIImage imageNamed:@"sayl_chair"]];

    NSArray *childViewControllersArray = @[subVC_1, subVC_2, subVC_3, subVC_4];
    
    return childViewControllersArray;
}

@end
