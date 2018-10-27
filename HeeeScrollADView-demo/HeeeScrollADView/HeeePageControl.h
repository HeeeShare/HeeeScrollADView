//
//  HeeePageControl.h
//  HeeeScrollADViewDemo
//
//  Created by hgy on 2018/9/30.
//  Copyright © 2018年 hgy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeeePageControl : UIView
@property (nonatomic,strong) UIColor *pageIndicatorTintColor;
@property (nonatomic,strong) UIColor *currentPageIndicatorTintColor;
@property (nonatomic,assign) int numberOfPages;
@property (nonatomic,assign) int currentPage;
@property (nonatomic,assign) CGFloat offset;

@end

NS_ASSUME_NONNULL_END
