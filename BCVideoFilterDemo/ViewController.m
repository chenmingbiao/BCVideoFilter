
//  ViewController.m
//  BCVideoFilterDemo
//
//  Created by 陈明标 on 9/2/16.
//  Copyright © 2016 陈明标. All rights reserved.
//

#import "ViewController.h"
#import "BCVideoFilter.h"
#import "BCSepiaToneFilter.h"
#import "BCGaussianBlurFilter.h"
#import "BCPixellateFilter.h"
#import "BCColorInvertFilter.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *displayView;
@property (strong, nonatomic) BCVideoFilter *videoFilter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}



- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"mp4"];
    
    // 初始化，传入边框，视频地址
    _videoFilter = [[BCVideoFilter alloc] initWithFrame:self.displayView.bounds videoInputUrl:url];
    // 设置显示层
    [self.displayView addSubview:_videoFilter.view];
    // 设置滤镜
    BCFilter *filter = [[BCFilter alloc] init];
    [_videoFilter addFilter:filter];
    // 开始滤镜过滤
    [_videoFilter processVideoWithBlockCompletionHandler:^(float progress, BOOL isFinish, NSError *error) {
        if (isFinish) {
            NSLog(@"finish");
        } else {
            NSLog(@"%f", progress);
        }
    }];
}

// 原图按钮响应
- (IBAction)normalButtonAction:(id)sender {
    BCFilter *filter = [[BCFilter alloc] init];
    [_videoFilter changeFilter:filter];
}

// 棕色滤镜按钮响应
- (IBAction)sepiaToneButtonAction:(id)sender {
    BCSepiaToneFilter *filter = [[BCSepiaToneFilter alloc] init];
    [_videoFilter changeFilter:filter];
}

// 高斯模糊滤镜按钮响应
- (IBAction)gaussianBlurButtonAction:(id)sender {
    BCGaussianBlurFilter *filter = [[BCGaussianBlurFilter alloc] init];
    [_videoFilter changeFilter:filter];
}

// 像素滤镜按钮响应
- (IBAction)pixellateButtonAction:(id)sender {
    BCPixellateFilter *filter = [[BCPixellateFilter alloc] init];
    [_videoFilter changeFilter:filter];
}

// 反色滤镜按钮响应
- (IBAction)colorInvertButtonAction:(id)sender {
    BCColorInvertFilter *filter = [[BCColorInvertFilter alloc] init];
    [_videoFilter changeFilter:filter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
