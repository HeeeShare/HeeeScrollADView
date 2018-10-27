//
//  HeeeScrollADView.m
//  HeeeScrollADViewDemo
//
//  Created by hgy on 2018/9/26.
//  Copyright © 2018年 hgy. All rights reserved.
//

#import "HeeeScrollADView.h"
#import "UIButton+WebCache.h"
#import "CustomScrollView.h"
#import "HeeePageControl.h"

@interface HeeeScrollADView ()<UIScrollViewDelegate>
@property (nonatomic,strong) CustomScrollView *scrollView;
@property (nonatomic,strong) NSTimer *scrollTimer;
@property (nonatomic,assign) NSUInteger totalBtnCount;
@property (nonatomic,strong) UIPageControl *systemPageControl;
@property (nonatomic,strong) HeeePageControl *customPageControl;
@property (nonatomic,assign) NSUInteger currentPage;

@end

@implementation HeeeScrollADView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _timeInterval = 5;
        _pageControlOffset = 15;
        _pageIndicatorTintColor = [UIColor colorWithWhite:1 alpha:0.5];
        _currentPageIndicatorTintColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    
    if (_scrollTimer) {
        [_scrollTimer invalidate];
        _scrollTimer = nil;
    }
}

- (void)setUrlArr:(NSArray *)urlArr {
    _urlArr = urlArr;
    
    if (_scrollTimer) {
        [_scrollTimer invalidate];
        _scrollTimer = nil;
    }
    
    if (_urlArr.count > 0) {
        if (_scrollView.superview) {
            [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [_scrollView removeFromSuperview];
        }
        
        _scrollView = [[CustomScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _scrollView.delegate = self;
        _scrollView.clipsToBounds = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        [self addSubview:_scrollView];
        
        if (_urlArr.count == 1) {
            _totalBtnCount = 1;
        }else{
            _totalBtnCount = _urlArr.count + 2;
        }
        
        NSString *urlStr = @"";
        if (_totalBtnCount == 1) {
            _currentPage = 0;
            _systemPageControl.hidden = YES;
            _customPageControl.hidden = YES;
            
            urlStr = _urlArr.firstObject;
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            btn.imageView.contentMode = UIViewContentModeScaleAspectFill;
            btn.tag = 100;
            btn.adjustsImageWhenHighlighted = NO;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            [btn sd_setImageWithURL:[NSURL URLWithString:urlStr] forState:(UIControlStateNormal)];
            [_scrollView addSubview:btn];
        }else{
            if (_urlArr.count < _currentPage) {
                _currentPage = 0;
            }
            
            _systemPageControl.hidden = NO;
            _customPageControl.hidden = NO;
            
            for (NSUInteger i = 0; i < _totalBtnCount; i++) {
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width*i, 0, self.frame.size.width, self.frame.size.height)];
                btn.imageView.contentMode = UIViewContentModeScaleAspectFill;
                btn.tag = 100 + i;
                [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
                btn.adjustsImageWhenHighlighted = NO;
                if (i == 0) {
                    urlStr = _urlArr.lastObject;
                }else if (i == _totalBtnCount - 1){
                    urlStr = _urlArr.firstObject;
                }else{
                    urlStr = _urlArr[i - 1];
                }
                
                [btn sd_setImageWithURL:[NSURL URLWithString:urlStr] forState:(UIControlStateNormal)];
                [_scrollView addSubview:btn];
                _scrollView.contentSize = CGSizeMake(_totalBtnCount*self.frame.size.width, 0);
            }
            
            [self setTimeInterval:_timeInterval];
            
            _systemPageControl.numberOfPages = _urlArr.count;
            _customPageControl.numberOfPages = (int)_urlArr.count;
            _systemPageControl.currentPage = _currentPage;
            _customPageControl.currentPage = (int)_currentPage;
            [_scrollView setContentOffset:CGPointMake((_currentPage + 1)*self.frame.size.width, 0) animated:NO];
        }
    }
    
    [self setIsSystemPageControl:_isSystemPageControl];
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    _pageIndicatorTintColor = pageIndicatorTintColor;
    
    _systemPageControl.pageIndicatorTintColor = pageIndicatorTintColor;
    _customPageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    
    _systemPageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    _customPageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}

- (void)setIsSystemPageControl:(BOOL)isSystemPageControl {
    _isSystemPageControl = isSystemPageControl;
    
    if (_urlArr.count > 1) {
        if (_systemPageControl.superview) {
            [_systemPageControl removeFromSuperview];
            _systemPageControl = nil;
        }
        
        if (_customPageControl.superview) {
            [_customPageControl removeFromSuperview];
            _customPageControl = nil;
        }
        
        if (isSystemPageControl) {
            _systemPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 2.5 - _pageControlOffset, self.frame.size.width, 5)];
            _systemPageControl.userInteractionEnabled = NO;
            _systemPageControl.currentPage = _currentPage;
            _systemPageControl.currentPageIndicatorTintColor = _currentPageIndicatorTintColor;
            _systemPageControl.pageIndicatorTintColor = _pageIndicatorTintColor;
            _systemPageControl.hidesForSinglePage = YES;
            _systemPageControl.numberOfPages = (int)self.urlArr.count;
            [self addSubview:_systemPageControl];
        }else{
            _customPageControl = [[HeeePageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 2.5 - _pageControlOffset, self.frame.size.width, 5)];
            _customPageControl.currentPageIndicatorTintColor = _currentPageIndicatorTintColor;
            _customPageControl.currentPage = (int)_currentPage;
            _customPageControl.pageIndicatorTintColor = _pageIndicatorTintColor;
            _customPageControl.numberOfPages = (int)_urlArr.count;
            [self addSubview:_customPageControl];
        }
    }
}

- (void)setPageControlOffset:(CGFloat)pageControlOffset {
    _pageControlOffset = pageControlOffset;
    
    if (_urlArr.count > 1) {
        if (_systemPageControl.superview) {
            _systemPageControl.frame = CGRectMake(0, self.frame.size.height - 2.5 - _pageControlOffset, self.frame.size.width, 5);
        }
        
        if (_customPageControl.superview) {
            _customPageControl.frame = CGRectMake(0, self.frame.size.height - 2.5 - _pageControlOffset, self.frame.size.width, 5);
        }
    }
}

#pragma mark - action
- (void)setTimeInterval:(CGFloat)timeInterval {
    _timeInterval = timeInterval;
    
    if (_scrollTimer) {
        [_scrollTimer invalidate];
        _scrollTimer = nil;
    }
    
    if (_urlArr.count > 1) {
        _scrollTimer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_scrollTimer forMode:NSRunLoopCommonModes];
    }
}

//自动翻页
- (void)autoScroll {
    CGFloat offsetX = _scrollView.contentOffset.x;
    int page = (int)(offsetX/self.frame.size.width);
    
    [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x + self.frame.size.width - (offsetX - page*self.frame.size.width), 0) animated:YES];
}

//处理滚到到哪一页
- (void)handleScrollToWhichPage:(CGFloat)offsetX {
    NSUInteger index = offsetX/self.frame.size.width;
    if (offsetX == index*self.frame.size.width) {
        if (index == 0) {
            index = _totalBtnCount - 3;
        }else if (index == _totalBtnCount - 1) {
            index = 0;
        }else{
            index = index - 1;
        }
        
        _currentPage = index;
        
        if (_delegate && [_delegate respondsToSelector:@selector(scrollADView:didScrollToIndex:)]) {
            [_delegate scrollADView:self didScrollToIndex:index];
        }
    }
}

//处理pageControl
- (void)handleSelectWhichPage:(CGFloat)offsetX {
    NSUInteger index = (offsetX + 0.5*self.frame.size.width)/self.frame.size.width;
    if (index == 0) {
        index = _totalBtnCount - 3;
    }else if (index == _totalBtnCount - 1) {
        index = 0;
    }else{
        index = index - 1;
    }
    
    _systemPageControl.currentPage = index;
}

- (void)btnClick:(UIButton *)sender {
    NSUInteger index = 0;
    if (_totalBtnCount > 1) {
        if (sender.tag - 100 == 0) {
            index = _totalBtnCount - 3;
        }else if (sender.tag - 100 == _totalBtnCount - 1) {
            index = 0;
        }else{
            index = sender.tag - 101;
        }
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(scrollADView:didSelectIndex:)]) {
        [_delegate scrollADView:self didSelectIndex:index];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    BOOL flag = YES;
    
    CGFloat offsetX = scrollView.contentOffset.x;
    
    _customPageControl.offset = offsetX;
    
    if (offsetX >= (_totalBtnCount - 1)*self.frame.size.width) {
        flag = NO;
        [_scrollView setContentOffset:CGPointMake(self.frame.size.width + (offsetX - (_totalBtnCount - 1)*self.frame.size.width), 0)];
    }
    
    if (offsetX <= 0) {
        flag = NO;
        [_scrollView setContentOffset:CGPointMake((_totalBtnCount - 2)*self.frame.size.width + offsetX, 0)];
    }
    
    if (flag) {
        [self handleScrollToWhichPage:offsetX];
    }
    
    if (_isSystemPageControl) {
        [self handleSelectWhichPage:offsetX];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_scrollTimer) {
        [_scrollTimer invalidate];
        _scrollTimer = nil;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    self.scrollTimer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_scrollTimer forMode:NSRunLoopCommonModes];
}

@end
