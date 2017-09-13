//
//  HHSlideView.m
//  HHSlideView
//
//  Created by Herbert Hu on 2017/8/28.
//  Copyright © 2017年 Herbert Hu. All rights reserved.
//

#import "HHSlideView.h"
#import "Masonry.h"
#import "POP.h"

#define Bar_Height      50
#define Slider_Height   5
#define Bar_DefaultColor                [UIColor colorWithRed:0.27 green:0.27 blue:0.27 alpha:1.00]
#define Slider_DefaultColor             [UIColor colorWithRed:0.07 green:1.00 blue:0.58 alpha:1.00]
#define Title_DefaultColor              [UIColor colorWithRed:0.65 green:0.73 blue:0.75 alpha:1]
#define HighlightedTitle_DefaultColor   [UIColor colorWithRed:0.31 green:0.95 blue:0.71 alpha:1]

@interface HHSlideView () <UIScrollViewDelegate> {
    
    struct {
        
        unsigned int DidDefineColorOfBar                : 1;
        unsigned int DidDefineColorOfSlider             : 1;
        unsigned int DidDefineColorOfTitle              : 1;
        unsigned int DidDefineColorOfHighlightedTitle   : 1;
        
    } _delegateFlags;
}

@property (strong, nonatomic) UIView *bar;
@property (strong, nonatomic) UIColor *colorOfBar;

@property (strong, nonatomic) NSArray *itemsArray;
@property (strong, nonatomic) NSMutableArray *buttonsArray;

@property (strong, nonatomic) UIView *slider;
@property (strong, nonatomic) UIColor *colorOfSlider;

@property (assign, nonatomic) CGFloat itemWidth;

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) NSMutableArray *controllerViewsArray;

@property (strong, nonatomic) NSArray *childControllersArray;

@property (assign, nonatomic) NSInteger currentIndex;

@end

@implementation HHSlideView

#pragma mark - setter (Override)
- (void)setDelegate:(id<HHSlideViewDelegate>)delegate {
    
    _delegate = delegate;
    _delegateFlags.DidDefineColorOfBar = [delegate respondsToSelector:@selector(colorOfBar:)];
    _delegateFlags.DidDefineColorOfSlider = [delegate respondsToSelector:@selector(colorOfSlider:)];
    _delegateFlags.DidDefineColorOfTitle = [delegate respondsToSelector:@selector(colorOfTitle:)];
    _delegateFlags.DidDefineColorOfHighlightedTitle = [delegate respondsToSelector:@selector(colorOfHighlightedTitle:)];
}

#pragma mark - life cycle
// Designated Initializer
- (instancetype)initWithItemsArray:(nonnull NSArray *)itemsArray {
    
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        
        [self initializeUserInterfaceWithItemArray:itemsArray];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self initializeUserInterfaceWithItemArray:@[@"1", @"2", @"3", @"4"]];
    }
    
    return self;
}

// Convenient Initializer
- (instancetype)initWithFrame:(CGRect)frame {
    
    return [self initWithItemsArray:@[@"1",@"2",@"3",@"4"]];
}


- (void)initializeUserInterfaceWithItemArray:(NSArray *)itemsArray {
    
    _buttonsArray = [NSMutableArray new];
    _controllerViewsArray = [NSMutableArray new];
    _currentIndex = 0;
    
    [self setBackgroundColor:[UIColor grayColor]];
    
    [self addSubview:self.bar];
    
    [self createButtonsWithItemsArray:itemsArray];
    
    [self.bar addSubview:self.slider];
    
    [self addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.containerView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDeviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self getParamFromDelegate];
    
    [self createControllerViews];
    
    [_bar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(self);
        make.height.mas_equalTo(Bar_Height);
    }];
    
    [self layoutButtonsWithButtonsArray:self.buttonsArray];
    
    [self layoutSliderWithCurrentIndex:_currentIndex];
    
    [self layoutControllerViews];
    [self layoutScrollView];
}

#pragma mark - UI Component Getter
- (UIView *)bar {
    
    if(!_bar) {
        
        _bar = [UIView new];
        [_bar setBackgroundColor:Bar_DefaultColor];
    }
    return _bar;
}

- (UIButton *)button {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor clearColor]];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"" forState:UIControlStateNormal];
//    [button.titleLabel setFont:[UIFont systemFontOfSize:16.f]];
    [button.titleLabel setFont:[UIFont fontWithName:@"Avenir-Book" size:17.0]];
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (UIView *)slider {
    
    if (!_slider) {
        
        _slider = [UIView new];
        [_slider setBackgroundColor:Slider_DefaultColor];
    }
    return _slider;
}

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        
        _scrollView = [UIScrollView new];
        _scrollView.directionalLockEnabled = YES;
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.pagingEnabled = YES;
        //    _scrollView.contentSize = CGSizeMake(_contentScrollView.frame.size.width * _numberOfSlideItems, 0);
        _scrollView.showsHorizontalScrollIndicator = YES;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (UIView *)containerView {
    
    if(!_containerView) {
        
        _containerView = [UIView new];
        [_containerView setBackgroundColor:[UIColor purpleColor]];
    }
    return _containerView;
}

- (void)createButtonsWithItemsArray:(NSArray *)itemsArray {
    for (int i=0; i<[itemsArray count]; i++) {
        
        UIButton *retButton = [self button];
        [retButton setTag:i];
        [retButton setTitleColor:Title_DefaultColor forState:UIControlStateNormal];
        [retButton setTitle:itemsArray[i] forState:UIControlStateNormal];
        [self.bar addSubview:retButton];
        
        [_buttonsArray addObject:retButton];
        
        if (i == 0) {
            
            [retButton setTitleColor:HighlightedTitle_DefaultColor forState:UIControlStateNormal];
        }
    }
}

- (void)createControllerViews {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        self.childControllersArray = [self.dataSource childViewControllersInSlideView:self];
        for (UIViewController *vc in self.childControllersArray) {
            
//            NSUInteger index = [self.childControllersArray indexOfObject:vc];
            
            [self.containerView addSubview:vc.view];
            [_controllerViewsArray addObject:vc.view];
            
//            [_contentScrollView addSubview:vc.view];
        }

        /*
        for (int i=0; i<4; i++) {
            
            UIView *view = [UIView new];
            
            CGFloat red = arc4random() % 255 / 255.0;
            CGFloat green = arc4random() % 255 / 255.0;
            CGFloat blue = arc4random() % 255 / 255.0;
            UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
            
            [view setBackgroundColor:color];
            [view setTag:i];
            [self.scrollView addSubview:view];
            
            [_controllerViewsArray addObject:view];
        }
         */
    });
}

#pragma mark - Layout methods
- (void)layoutButtonsWithButtonsArray:(NSMutableArray *)buttonsArray {
    
    CGFloat singleWidth = self.bounds.size.width/(CGFloat)[buttonsArray count];
    
    for (int j=0; j<[buttonsArray count]; j++) {
        
        UIButton *retButton = buttonsArray[j];
        
        [retButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(self.bar);
            make.width.mas_equalTo(singleWidth);
            make.left.equalTo(self.bar.mas_left).offset(singleWidth*j);
        }];
    }
}

- (void)layoutSliderWithCurrentIndex:(NSInteger)index {
    
    _itemWidth = self.bounds.size.width/(CGFloat)[_buttonsArray count];
    CGFloat sliderWidth = _itemWidth * 0.6;
    
//    UIButton *retButton = [_buttonsArray objectAtIndex:index];
    
    [_slider mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bar.mas_bottom);
//        make.centerX.equalTo(retButton.mas_centerX).priorityLow();
        make.left.mas_equalTo(self.bar).offset(index*_itemWidth+(_itemWidth-sliderWidth)/2.0);
        make.width.mas_equalTo(sliderWidth);
        make.height.mas_equalTo(Slider_Height);
    }];
}

- (void)layoutScrollView {

    [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bar.mas_bottom);
        make.left.and.right.equalTo(self);
        make.bottom.equalTo(self).offset(-64);
    }];
}

- (void)layoutControllerViews {

    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        make.height.equalTo(_scrollView);
        make.width.equalTo(_scrollView).multipliedBy([_buttonsArray count]);
    }];
    
    for (int i=0; i<[_buttonsArray count]; i++) {
        UIView *view = [_controllerViewsArray objectAtIndex:i];
        
        CGFloat left = self.bounds.size.width * i;
        
        [view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_containerView);
            make.left.equalTo(_containerView).offset(left);
            make.width.mas_equalTo(self.bounds.size.width);
            make.height.equalTo(_containerView);
        }];
    }
}

#pragma mark - From Delegate
- (void)getParamFromDelegate {
    
    if (_delegateFlags.DidDefineColorOfBar) {
        
        self.colorOfBar = [self.delegate colorOfBar:self];
        [self.bar setBackgroundColor:self.colorOfBar];
    }
    //
}

#pragma mark - Button Action 
- (void)buttonClicked:(UIButton *)button {
    
    [self layoutIfNeeded];
    
    CGFloat screen_Width = self.bounds.size.width;
    [_scrollView setContentOffset:CGPointMake(button.tag*screen_Width, 0) animated:YES];
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat screen_Width = self.bounds.size.width;
    
    CGFloat offset_x = scrollView.contentOffset.x;
    
    CGFloat result = offset_x/screen_Width;
    
    for (int page=0; page<[_buttonsArray count]; page++) {
        
        if (page == result) {
            
            _currentIndex = page;
            [self performAniamtionForSliderWithTag:page];
        }
    }
}

#pragma mark - POP Animation For Slider
- (void)performAniamtionForSliderWithTag:(NSInteger)tag {
    
    _itemWidth = self.bounds.size.width/(CGFloat)[_buttonsArray count];
    
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    CGPoint point = _slider.center;
    
    springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(_itemWidth*(tag+0.5), point.y)];
    springAnimation.springBounciness = 10.0;
    springAnimation.springSpeed = 20.0;
    
    [_slider pop_addAnimation:springAnimation forKey:@"ChangePosition"];
    
    for (UIButton *tempButton in _buttonsArray) {
        
        if (tempButton.tag == tag) {
            
            [tempButton setTitleColor:HighlightedTitle_DefaultColor forState:UIControlStateNormal];
        }
        else {
            
            [tempButton setTitleColor:Title_DefaultColor forState:UIControlStateNormal];
        }
    }
}

#pragma mark - Adapt Interface Rotation
- (void)handleDeviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation {
    
    CGFloat width = self.bounds.size.width;
    
    NSLog(@"(%f, 0)", _currentIndex*width);
    // revise scrollview's contentOffset
    [_scrollView setContentOffset:CGPointMake(_currentIndex*width, 0) animated:NO];
}


@end
