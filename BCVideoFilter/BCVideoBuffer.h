//
//  BCVideoBuffer.h
//  BCVideoFilterDemo
//
//  Created by 陈明标 on 8/19/16.
//  Copyright © 2016 陈明标. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCVideoBuffer : NSObject

typedef void(^BCVideoBufferStatus)(CVPixelBufferRef buffer, BOOL isFinish, NSError *error);

/**
 *  初始化并开始视频
 *
 *  @param URL           视频URL
 *  @param callbackBlock 回调
 *
 *  @return self
 */
- (instancetype)initWithUrl:(NSURL *)url
          completionHandler:(BCVideoBufferStatus)status;

/**
 *  开始获取视频帧数
 */
- (void)start;

/**
 *  停止获取视频帧数
 */
- (void)stop;

/**
 *  暂停获取视频帧数
 */
- (void)pause;

/**
 *  恢复获取视频帧数
 */
- (void)resume;

@end
