//
//  BCColorInvertFilter.m
//  BCVideoFilterDemo
//
//  Created by 陈明标 on 9/5/16.
//  Copyright © 2016 陈明标. All rights reserved.
//

#import "BCColorInvertFilter.h"

@implementation BCColorInvertFilter

/**
 *  反转颜色滤镜-CIColorInvert
 *
 *  @param image   处理前的图片
 *  @param content 上下文
 *
 *  @return 滤镜处理后的图片
 */
- (CIImage *)colorInvertWithImage:(CIImage *)ciImage
{
    if (!ciImage) {
        return nil;
    }
    
    CIFilter *filter = [CIFilter filterWithName:@"CIColorInvert"];
    [filter setValue:ciImage forKey:kCIInputImageKey];
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
    return [self colorInvertWithImage:image];
}

@end
