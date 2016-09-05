//
//  BCVideoFilter.h
//  BCVideoFilterDemo
//
//  Created by 陈明标 on 9/2/16.
//  Copyright © 2016 陈明标. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BCGLKView.h"

@class BCFilter;

@interface BCVideoFilter : NSObject

// OpenGL ES2 视图
@property (nonatomic, strong) BCGLKView *view;

// 当前的滤镜
@property (nonatomic, copy, readonly) NSString *currentFilter;

typedef void(^BCVideoFilterStatus)(float progress, BOOL isFinish, NSError *error);

/**
 *  初始化
 *
 *  @param frame          框架
 *  @param videoInputPath 视频输入地址
 */
- (instancetype)initWithFrame:(CGRect)frame
                videoInputUrl:(NSURL *)videoInputUrl;

/**
 *  初始化
 *
 *  @param frame          框架
 *  @param videoInputPath 视频输入地址
 *  @param filter         滤镜
 */
- (instancetype)initWithFrame:(CGRect)frame
                videoInputUrl:(NSURL *)videoInputUrl
                       filter:(BCFilter *)filter;

/**
 *  初始化
 *
 *  @param frame              框架
 *  @param videoInputPath     视频输入地址
 *  @param watermarkInputPath 水印输入地址
 */
- (instancetype)initWithFrame:(CGRect)frame
                videoInputUrl:(NSURL *)videoInputUrl
            watermarkInputUrl:(NSURL *)watermarkInputUrl;

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
            watermarkInputUrl:(NSURL *)watermarkInputUrl;

/**
 *  添加滤镜
 *
 *  @param filter 滤镜
 */
- (void)addFilter:(BCFilter *)filter;

/**
 *  添加滤镜
 *
 *  @param filter     滤镜
 *  @param parameters 参数
 */
- (void)addFilter:(BCFilter *)filter parameter:(NSArray *)parameters;

/**
 *  更换滤镜
 *
 *  @param filter 滤镜
 */
- (void)changeFilter:(BCFilter *)filter;

/**
 *  更换滤镜
 *
 *  @param filter     滤镜
 *  @param parameters 参数
 */
- (void)changeFilter:(BCFilter *)filter parameter:(NSArray *)parameters;

/**
 *  开始加载视频
 */
- (void)processVideoWithBlockCompletionHandler:(BCVideoFilterStatus)status;

/**
 *  导出视频
 */
- (void)exportVideoWithVideoOuputPath:(NSString *)videooutputPath;

@end
