//
//  CustomScrollView.m
//  HeeeScrollADViewDemo
//
//  Created by hgy on 2018/9/30.
//  Copyright © 2018年 hgy. All rights reserved.
//

#import "CustomScrollView.h"

@implementation CustomScrollView
- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    if ([view isKindOfClass:[UIButton class]]) {
        return YES;
    }
    return [super touchesShouldCancelInContentView:view];
}
@end
