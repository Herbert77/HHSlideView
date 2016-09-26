//
//  SubViewController.h
//  HHSlideViewExample
//
//  Created by Herbert Hu on 16/9/26.
//  Copyright © 2016年 Herbert Hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

// Designate Initilizer
- (id)initWithImage:(UIImage *)image;

@end
