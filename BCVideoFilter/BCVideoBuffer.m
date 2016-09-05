//
//  BCVideoBuffer.m
//  BCVideoFilterDemo
//
//  Created by 陈明标 on 8/19/16.
//  Copyright © 2016 陈明标. All rights reserved.
//

#import "BCVideoBuffer.h"

#import <AVFoundation/AVFoundation.h>
#import <GLKit/GLKit.h>
#import <Accelerate/Accelerate.h>

@interface BCVideoBuffer () {
    AVPlayer *player;
    CADisplayLink *displayLink;
    AVPlayerItemVideoOutput *videoOutput;
    NSDictionary *pixelBufferDict;
    BCVideoBufferStatus consumerStatus;
}

@end

@implementation BCVideoBuffer

/**
 *  初始化
 *
 *  @return self
 */
- (instancetype)init {
    self = [super init];
    
    if (self) {
        displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkDidRefreshWithLink:)];
        pixelBufferDict = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarFullRange] forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    }
    
    return self;
}

/**
 *  初始化并开始视频
 *
 *  @param URL           视频URL
 *  @param callbackBlock 回调
 *
 *  @return self
 */
- (instancetype)initWithUrl:(NSURL *)url
          completionHandler:(BCVideoBufferStatus)status
{
    self = [self init];
    
    if (self) {
        player = [AVPlayer playerWithURL:url];
        videoOutput = [[AVPlayerItemVideoOutput alloc] initWithPixelBufferAttributes:pixelBufferDict];
        [player.currentItem addOutput:videoOutput];
        [self start];
        consumerStatus = status;
    }
    
    // 添加播放完成的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:player.currentItem];
    [player play];
    return self;
}

/**
 *  视频播放完毕回调
 */
- (void)playerItemDidReachEnd{
    consumerStatus(nil, YES, nil);
    [player seekToTime:CMTimeMake(0, 1)];
    [player play];
}

/**
 *  开始获取视频帧数
 */
- (void)start {
    NSLog(@"start");
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [player play];
}

/**
 *  停止获取视频帧数
 */
- (void)stop {
    NSLog(@"stop");
    [displayLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [displayLink invalidate];
    displayLink = nil;
    [player pause];
}

/**
 *  暂停获取视频帧数
 */
- (void)pause {
    NSLog(@"pause");
    [displayLink setPaused:YES];
    [player pause];
}

/**
 *  恢复获取视频帧数
 */
- (void)resume {
    NSLog(@"resume");
    [displayLink setPaused:NO];
    [player play];
}

/**
 *  displayLink触发处理函数
 *
 *  @param link
 */
- (void)displayLinkDidRefreshWithLink: (CADisplayLink *)sender {
    
    CMTime outputItemTime = kCMTimeInvalid;
    
    // Calculate the nextVsync time which is when the screen will be refreshed next.
    CFTimeInterval nextVSync = ([sender timestamp] + [sender duration]);
    
    outputItemTime = [videoOutput itemTimeForHostTime:nextVSync];
    
    //CMTime itemTime = [videoOutput itemTimeForHostTime:CACurrentMediaTime()];
    if ([videoOutput hasNewPixelBufferForItemTime:outputItemTime]) {
        
        // CMTime presentationItemTime = kCMTimeZero;
        CVPixelBufferRef pixelBuffer = NULL;
        
        pixelBuffer = [videoOutput copyPixelBufferForItemTime:outputItemTime itemTimeForDisplay:NULL];
        
        consumerStatus(pixelBuffer, NO, nil);
        
        // 释放buffer
        if (pixelBuffer != NULL) {
            CFRelease(pixelBuffer);
        }
    }
}


@end


