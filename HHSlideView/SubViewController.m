//
//  SubViewController.m
//  HHSlideView
//
//  Created by Herbert Hu on 2017/8/29.
//  Copyright © 2017年 Herbert Hu. All rights reserved.
//

#import "SubViewController.h"
#import "Masonry.h"

@interface SubViewController ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIImage *image;

@end

@implementation SubViewController

- (id)initWithImage:(UIImage *)image {
    
    self = [super init];
    
    if (self) {
        
        _image = image;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00]];
    
    [self.view addSubview:self.imageView];
    [self.imageView setImage:_image];
}

- (UIImageView *)imageView {
    
    if (!_imageView) {
        
        _imageView = [UIImageView new];
    }
    return _imageView;
}

- (void)viewDidLayoutSubviews {
    
        [_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.center.equalTo(self.view);
            make.height.equalTo(self.view).multipliedBy(0.75);
            make.width.equalTo(self.view.mas_height).multipliedBy(8/10.0);
        }];
}

@end
