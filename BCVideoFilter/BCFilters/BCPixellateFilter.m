//
//  BCPixellateFilter.m
//  BCVideoFilterDemo
//
//  Created by 陈明标 on 9/5/16.
//  Copyright © 2016 陈明标. All rights reserved.
//

#import "BCPixellateFilter.h"

@implementation BCPixellateFilter

/**
 *  像素滤镜-CIPixellate
 *
 *  @param ciImage 处理前的图片
 *  @param center  中心点
 *  @param scale   比列
 *  @param content 上下文
 *
 *  @return 滤镜处理后的图片
 */
- (CIImage *)pixellateWithImage:(CIImage *)ciImage
                         center:(CGPoint)center
                          scale:(CGFloat)scale
{
    CIFilter *filter = [CIFilter filterWithName:@"CIPixellate"];
    [filter setValue:ciImage forKey:kCIInputImageKey];
    if (scale >= 1 && scale <= 100) {
        [filter setValue:@(scale) forKey:@"inputScale"];
    }
    CIVector *vector = [CIVector vectorWithCGPoint:center];
    [filter setValue:vector forKey:@"inputCenter"];
    CIImage *outPutImg = [filter outputImage];
    return outPutImg;
}

/**
 *  重写函数
 *
 *  @param image 处理前的图片
 *
 *  @return 处理后的图片
 */
- (CIImage *)getFilterHanldeImage:(CIImage *)image
{
    return [self pixellateWithImage:image center:CGPointMake(300, 300) scale:8];
}

@end
