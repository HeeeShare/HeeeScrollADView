//
//  ViewController.m
//  HeeeScrollADView-demo
//
//  Created by hgy on 2018/10/19.
//  Copyright © 2018年 hgy. All rights reserved.
//

#define url0 @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1538915493893&di=a9e8867b153c3c8a780895a026c2dea5&imgtype=jpg&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D3564877025%2C796183547%26fm%3D214%26gp%3D0.jpg"
#define url1 @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1538915748810&di=6f16eba52b8407344355244c1c4aba30&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201509%2F14%2F20150914222839_S3XtN.jpeg"
#define url2 @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1539522776&di=531be0ebdfaa0a56bf4d6e2866c04335&imgtype=jpg&er=1&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F17%2F31%2F28%2F71B58PIC9Ia_1024.jpg"
#define url3 @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1538927908658&di=fb634aa182626d95bc5cd0d4f34f2669&imgtype=0&src=http%3A%2F%2Fimg006.hc360.cn%2Fy5%2FM01%2FE3%2F47%2FwKhQUVXVmjaEIe9kAAAAAGL6brU089.jpg"

#import "ViewController.h"
#import "HeeeScrollADView.h"

@interface ViewController ()
@property (nonatomic,strong) HeeeScrollADView *scrollADView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollADView = [[HeeeScrollADView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width*9/16.0)];
    _scrollADView.urlArr = @[url0,url1,url2,url3];
    [self.view addSubview:_scrollADView];
}

@end
