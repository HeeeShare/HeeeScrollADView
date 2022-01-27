//
//  ViewController.m
//  HeeeScrollADView-demo
//
//  Created by hgy on 2018/10/19.
//  Copyright © 2018年 hgy. All rights reserved.
//

#define url0 @"https://t7.baidu.com/it/u=2529476510,3041785782&fm=193&f=GIF"
#define url1 @"https://t7.baidu.com/it/u=727460147,2222092211&fm=193&f=GIF"
#define url2 @"https://t7.baidu.com/it/u=2511982910,2454873241&fm=193&f=GIF"
#define url3 @"https://t7.baidu.com/it/u=3779234486,1094031034&fm=193&f=GIF"

#import "ViewController.h"
#import "HeeeScrollADView.h"

@interface ViewController ()
@property (nonatomic,strong) HeeeScrollADView *scrollADView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollADView = [[HeeeScrollADView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.width*9/16.0)];
    _scrollADView.urlArr = @[url0,url1,url2,url3];
    [self.view addSubview:_scrollADView];
}

@end
