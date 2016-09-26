//
//  SubViewController.m
//  HHSlideViewExample
//
//  Created by Herbert Hu on 16/9/26.
//  Copyright © 2016年 Herbert Hu. All rights reserved.
//

#import "SubViewController.h"

@interface SubViewController ()

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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
    
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.imageView setImage:_image];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
