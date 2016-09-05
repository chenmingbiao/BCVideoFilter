//
//  BCGaussianBlurFilter.m
//  BCVideoFilterDemo
//
//  Created by 陈明标 on 9/5/16.
//  Copyright © 2016 陈明标. All rights reserved.
//

#import "BCGaussianBlurFilter.h"

@implementation BCGaussianBlurFilter

/**
 *  高斯模糊滤镜-CIGaussianBlur
 *
 *  @param ciImage 处理前的图片
 *  @param radius  半径
 *  @param content 上下文
 *
 *  @return 滤镜处理后的图片
 */
- (CIImage *)gaussianBlurWithImage:(CIImage *)ciImage
                            radius:(CGFloat)radius
{
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:ciImage forKey:kCIInputImageKey];
    if (radius >= 0 && radius <= 100) {
        [filter setValue:@(radius) forKey:@"inputRadius"];
    }
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
    return [self gaussianBlurWithImage:image radius:2.0];
}

@end
