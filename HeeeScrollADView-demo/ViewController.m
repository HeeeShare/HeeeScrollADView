//
//  ViewController.m
//  HeeeScrollADView-demo
//
//  Created by hgy on 2018/10/19.
//  Copyright © 2018年 hgy. All rights reserved.
//

#define url0 @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1538915493893&di=a9e8867b153c3c8a780895a026c2dea5&imgtype=jpg&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D3564877025%2C796183547%26fm%3D214%26gp%3D0.jpg"
#define url1 @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1538915748810&di=6f16eba52b8407344355244c1c4aba30&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201509%2F14%2F20150914222839_S3XtN.jpeg"
#define url2 @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1599128300464&di=b1f4852b5fadeea00f38007d92b779dc&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fsoftbbs%2F1102%2F19%2Fc0%2F6778140_1298084431382_1024x1024soft.jpg"
#define url3 @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1538927908658&di=fb634aa182626d95bc5cd0d4f34f2669&imgtype=0&src=http%3A%2F%2Fimg006.hc360.cn%2Fy5%2FM01%2FE3%2F47%2FwKhQUVXVmjaEIe9kAAAAAGL6brU089.jpg"

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
