//
//  HeeePageControl.m
//  HeeeScrollADViewDemo
//
//  Created by hgy on 2018/9/30.
//  Copyright © 2018年 hgy. All rights reserved.
//

#define disSelectWidth 10
#define selectWidth 20
#define indicatorHeight 5
#define gap 8

#import "HeeePageControl.h"
#import "UIView+HeeeQuickFrame.h"

@interface HeeePageControl()
@property (nonatomic,strong) NSMutableArray *indicatorArr;
@property (nonatomic,strong) UIView *clearBackView;

@end

@implementation HeeePageControl
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        _clearBackView = [[UIView alloc] initWithFrame:self.bounds];
        _clearBackView.backgroundColor = [UIColor clearColor];
        [self addSubview:_clearBackView];
        _indicatorArr = [NSMutableArray array];
        _pageIndicatorTintColor = [UIColor colorWithWhite:0 alpha:0.3];
        _currentPageIndicatorTintColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)setOffset:(CGFloat)offset {
    _offset = offset;
    
    int firstPage = (int)(offset/self.frame.size.width) - 1;
    
    if (firstPage < 0) {
        firstPage = _numberOfPages - 1;
    }
    
    if (firstPage == _numberOfPages) {
        firstPage = 0;
    }
    
    int nextPage = firstPage + 1;
    
    if (firstPage == _numberOfPages - 1) {
        nextPage = 0;
    }
    
    CGFloat rate = (offset - (int)(offset/self.frame.size.width)*self.frame.size.width)/self.frame.size.width;
    
    UIView *firstView = _indicatorArr[firstPage];
    UIView *nextView = _indicatorArr[nextPage];
    
    for (UIView *view in _indicatorArr) {
        if (view != firstView && view != nextView) {
            if (view.width != disSelectWidth) {
                view.width = disSelectWidth;
            }
            
            if (view.backgroundColor != _pageIndicatorTintColor) {
                view.backgroundColor = _pageIndicatorTintColor;
            }
        }
    }
    
    firstView.width = selectWidth - (selectWidth - disSelectWidth)*rate;
    nextView.width = disSelectWidth + (selectWidth - disSelectWidth)*rate;
    
    [self changeColorWithFirstView:firstView nextView:nextView andRate:rate];
    
    for (NSUInteger i = 0; i < _indicatorArr.count; i++) {
        UIView *view0 = _indicatorArr[i];
        if (i == 0) {
            view0.left = 0;
        }else{
            UIView *view1 = _indicatorArr[i-1];
            view0.left = view1.right + gap;
        }
    }
}

/**
 颜色渐变
 
 @param firstView 第一个view
 @param nextView 第二个view
 @param rate 渐变程度
 */
- (void)changeColorWithFirstView:(UIView *)firstView nextView:(UIView *)nextView andRate:(CGFloat)rate {
    CGFloat r0,g0,b0,a0 = 0.0;
    [_currentPageIndicatorTintColor getRed:&r0 green:&g0 blue:&b0 alpha:&a0];
    
    CGFloat r1,g1,b1,a1 = 0.0;
    [_pageIndicatorTintColor getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
    
    firstView.backgroundColor = [UIColor colorWithRed:(r0 + (r1 - r0)*rate) green:(g0 + (g1 - g0)*rate) blue:(b0 + (b1 - b0)*rate) alpha:(a0 + (a1 - a0)*rate)];
    nextView.backgroundColor = [UIColor colorWithRed:(r1 + (r0 - r1)*rate) green:(g1 + (g0 - g1)*rate) blue:(b1 + (b0 - b1)*rate) alpha:(a1 + (a0 - a1)*rate)];
}

- (void)setNumberOfPages:(int)numberOfPages {
    _numberOfPages = numberOfPages;
    [_indicatorArr removeAllObjects];
    [_clearBackView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (numberOfPages > 1) {
        CGFloat x = 0;
        
        for (NSUInteger i = 0; i < numberOfPages; i++) {
            UIView *indicatorView = [[UIView alloc] initWithFrame:CGRectMake(x, 0, disSelectWidth, indicatorHeight)];
            indicatorView.backgroundColor = _pageIndicatorTintColor;
            indicatorView.centerY = _clearBackView.height/2;
            if (_currentPage == i) {
                indicatorView.backgroundColor = _currentPageIndicatorTintColor;
                indicatorView.width = selectWidth;
            }
            
            x = indicatorView.right + gap;
            indicatorView.layer.cornerRadius = indicatorHeight/2.0;
            indicatorView.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.1].CGColor;
            indicatorView.layer.borderWidth = 0.5;
            [_indicatorArr addObject:indicatorView];
            [_clearBackView addSubview:indicatorView];
            _clearBackView.width = indicatorView.right;
        }
        
        _clearBackView.centerX = self.width/2;
    }
}

- (void)setCurrentPage:(int)currentPage {
    _currentPage = currentPage;
    [self setNumberOfPages:_numberOfPages];
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    _pageIndicatorTintColor = pageIndicatorTintColor;
    [self setNumberOfPages:_numberOfPages];
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    [self setNumberOfPages:_numberOfPages];
}

@end
