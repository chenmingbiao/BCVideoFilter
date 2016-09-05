//
//  BCVideoFilter.m
//  BCVideoFilterDemo
//
//  Created by 陈明标 on 9/2/16.
//  Copyright © 2016 陈明标. All rights reserved.
//

#import "BCVideoFilter.h"
#import "BCFilter.h"
#import "BCVideoBuffer.h"

#import <ImageIO/ImageIO.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/CoreAnimation.h>

@interface BCVideoFilter()
{
    BCVideoBuffer *videoBufferObject;
}



// 视频输入地址
@property (nonatomic, strong) NSURL *videoInputUrl;
// 水印输入地址
@property (nonatomic, strong) NSURL *watermarkInputUrl;
// 滤镜
@property (nonatomic, strong) BCFilter *filter;
// 视频帧数
@property (nonatomic, assign) int frameCount;
// 视频帧索引
@property (nonatomic, assign) int frameIndex;

@end

@implementation BCVideoFilter

/**
 *  初始化
 *
 *  @param frame          框架
 *  @param videoInputPath 视频输入地址
 */
- (instancetype)initWithFrame:(CGRect)frame
                videoInputUrl:(NSURL *)videoInputUrl
{
    return [self initWithFrame:frame videoInputUrl:videoInputUrl filter:nil watermarkInputUrl:nil];
}

/**
 *  初始化
 *
 *  @param frame          框架
 *  @param videoInputPath 视频输入地址
 *  @param filter         滤镜
 */
- (instancetype)initWithFrame:(CGRect)frame
                videoInputUrl:(NSURL *)videoInputUrl
                       filter:(BCFilter *)filter
{
   return [self initWithFrame:frame videoInputUrl:videoInputUrl filter:filter watermarkInputUrl:nil];
}

/**
 *  初始化
 *
 *  @param frame              框架
 *  @param videoInputPath     视频输入地址
 *  @param watermarkInputPath 水印输入地址
 */
- (instancetype)initWithFrame:(CGRect)frame
                videoInputUrl:(NSURL *)videoInputUrl
            watermarkInputUrl:(NSURL *)watermarkInputUrl
{
    return [self initWithFrame:frame videoInputUrl:videoInputUrl filter:nil watermarkInputUrl:watermarkInputUrl];
}

/**
 *  初始化
 *
 *  @param frame              框架
 *  @param videoInputPath     视频输入地址
 *  @param filter             滤镜
 *  @param watermarkInputPath 水印输入地址
 */
- (instancetype)initWithFrame:(CGRect)frame
                videoInputUrl:(NSURL *)videoInputUrl
                       filter:(BCFilter *)filter
            watermarkInputUrl:(NSURL *)watermarkInputUrl
{
    self = [super init];
    if (self) {
        // 判断参数
        if ( videoInputUrl == nil )
        {
            NSLog(@"videoInputUrl is empty");
            return nil;
        }
        // 添加滤镜
        if (filter )
        {
            [self addFilter:filter];
            self.filter = filter;
        }
        
        // 初始化参数
        _frameIndex = 0;
        _videoInputUrl = videoInputUrl;
        _watermarkInputUrl = watermarkInputUrl;
        _view = [[BCGLKView alloc] initWithFrame:frame];
    }
    return self;
}

/**
 *  添加滤镜
 *
 *  @param filter 滤镜
 */
- (void)addFilter:(BCFilter *)filter
{
    [self addFilter:filter parameter:nil];
}

/**
 *  添加滤镜
 *
 *  @param filter     滤镜
 *  @param parameters 参数
 */
- (void)addFilter:(BCFilter *)filter parameter:(NSArray *)parameters
{
    self.filter = filter;
    if ( parameters )
    {
        self.filter.parameters = parameters;
    }
}

/**
 *  更换滤镜
 *
 *  @param filter 滤镜
 */
- (void)changeFilter:(BCFilter *)filter
{
    [self changeFilter:filter parameter:nil];
}

/**
 *  更换滤镜
 *
 *  @param filter     滤镜
 *  @param parameters 参数
 */
- (void)changeFilter:(BCFilter *)filter parameter:(NSArray *)parameters
{
    self.filter = filter;
    if ( parameters )
    {
        self.filter.parameters = parameters;
    }
}

/**
 *  设置滤镜
 *
 *  @param filter 滤镜
 */
- (void)setFilter:(BCFilter *)filter
{
    _filter = filter;
    _currentFilter = [_filter currentFilter];
}

/**
 *  开始加载视频
 */
- (void)processVideoWithBlockCompletionHandler:(BCVideoFilterStatus)status
{
    // 获取原本形变
    AVAsset *videoAsset = [AVAsset assetWithURL:_videoInputUrl];
    NSArray *tracks = [videoAsset tracksWithMediaType:AVMediaTypeVideo];
    AVAssetTrack *videoTrack = [tracks objectAtIndex:0];
    CGAffineTransform orginialTransForm = videoTrack.preferredTransform;
    // 根据CoreImage的坐标轴进行转换回正确的角度
    CGFloat middle = orginialTransForm.b;
    orginialTransForm.b = orginialTransForm.c;
    orginialTransForm.c = middle;
    
    __weak BCVideoFilter *weakSelf = self;
    
    videoBufferObject = [[BCVideoBuffer alloc]
                          initWithUrl:_videoInputUrl
                          completionHandler:^(CVPixelBufferRef buffer, BOOL isFinish, NSError *error)
    {
        
        if(isFinish == NO)
        {
            
            _frameIndex++;
            
            // buffer转成ciImage
            CIImage *ciImage = [CIImage imageWithCVPixelBuffer:buffer];
            
            // 添加滤镜
            ciImage = [weakSelf.filter getFilterHanldeImage:ciImage];
            
            // 应用形变
            ciImage = [ciImage imageByApplyingTransform:orginialTransForm];
            
            // 应用到界面上
            weakSelf.view.image = ciImage;
            [weakSelf.view display];
            
        }
        else
        {
            _frameIndex = 0;
        }
        
        status(_frameIndex, isFinish, nil);
        
    }];
}

@end
