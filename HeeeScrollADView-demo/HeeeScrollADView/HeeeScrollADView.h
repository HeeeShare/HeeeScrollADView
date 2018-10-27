//
//  HeeeScrollADView.h
//  HeeeScrollADViewDemo
//
//  Created by hgy on 2018/9/26.
//  Copyright © 2018年 hgy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HeeeScrollADView;

@protocol HeeeScrollADViewDelegate <NSObject>
@optional
- (void)scrollADView:(HeeeScrollADView *)scrollADView didScrollToIndex:(NSUInteger)index;
- (void)scrollADView:(HeeeScrollADView *)scrollADView didSelectIndex:(NSUInteger)index;

@end

@interface HeeeScrollADView : UIView
@property (nonatomic,strong) NSArray *urlArr;//需要展示的图片url数组，如果个数只有一个，不显示pageControl。支持动态设置
@property (nonatomic,assign) CGFloat timeInterval;//翻页间隔时间，默认5s
@property (nonatomic,assign) BOOL isSystemPageControl;//是否使用系统的pageControl，默认NO。
@property (nonatomic,strong) UIColor *pageIndicatorTintColor;//pageControl非当前小圆点颜色，默认白色0.3透明度
@property (nonatomic,strong) UIColor *currentPageIndicatorTintColor;//pageControl当前小圆点颜色，默认白色
@property (nonatomic,assign) CGFloat pageControlOffset;//pageControl距离底部的偏移，默认15
@property (nonatomic,  weak) id <HeeeScrollADViewDelegate> delegate;

@end
