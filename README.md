# HHSlideView
An custom segment control view with flat style.

HHSlideView is a falt view with segment control function. It's easy to be integrated into your project.

![image](https://github.com/Herbert77/HHSlideView/Example/HHSlideViewDemoGif.gif)  
Installation
-----------
###CocoaPods

Add the following line to the `Podfile`.
	
		pod "HHSlideView"
		
###Manual
Adding `HHSlideView.h` and `HHSlideView.m` to your project will be all right.
How To Use
-----------
**1. Create a super view controller. The slideView will become the subview of it.**
		
		SuperViewController.m
		
		- (void)viewDidLoad {
			
			[self.view addSubview:self.slideView];
		}
		
		- (HHSlideView *) {
			
			if(!_slideView) {
				
				_slideView = [[HHSlideView alloc] initWithFrame:(0 ,64, self.view.frame.size.width, self.view.frame.size.height-64)];
        		_slideView.delegate = self;
			}
			return _slideView;
		}
		
**2. Create several child view controllers. They will be orgnized by the slideView. Implement the method in delegate.**

		
		SuperViewController.m
		
		#pragma mark - HHSlideViewDelegate
		- (NSInteger)numberOfSlideItemsInSlideView:(HHSlideView *)slideView {
		    
		    return 4;
		}
		
		- (NSArray *)namesOfSlideItemsInSlideView:(HHSlideView *)slideView {
		    
		    return @[@"Embody", @"Aeron", @"Mirra", @"SAYL"];
		}
		
		- (NSArray *)childViewControllersInSlideView:(HHSlideView *)slideView {
		   
		    UIViewController *childVC_1 = [UIViewController new];
		    UIViewControlelr *childVC_2 = [UIViewController new];
		    UIViewController *childVC_3 = [UIViewController new];
		    UIViewController *childVC_4 = [UIViewController new];
		    
		    NSArray *childVC = @[childVC_1, childVC_2, childVC_3, childVC_4];
		    return childVC;
		}
		
		- (void)slideView:(HHSlideView *)slideView didSelectItemAtIndex:(NSInteger)index {
		    
		    NSLog(@"SelectAtIndex: %ld", (long)index);
		}
		
		- (UIColor *)colorOfSliderInSlideView:(HHSlideView *)slideView {
		    
		    return [UIColor lightGrayColor];
		}
		
		- (UIColor *)colorOfSlideView:(HHSlideView *)slideView {
		    
		    return [UIColor blackColor];
		}

Creator
-------
**Herbert Hu**

[Blog](http://my.oschina.net/herbert77)  


License
-------

The MIT License (MIT)

Copyright (c) 2016 Herbert Hu

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
