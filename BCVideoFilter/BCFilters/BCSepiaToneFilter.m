//
//  BCSepiaToneFilter.m
//  BCVideoFilterDemo
//
//  Created by 陈明标 on 9/5/16.
//  Copyright © 2016 陈明标. All rights reserved.
//

#import "BCSepiaToneFilter.h"

@implementation BCSepiaToneFilter

/**
 *  棕色滤镜-CISepiaTone
 *
 *  @param image      处理前的图片
 *  @param intentsity 强度
 *
 *  @return 滤镜处理后的图片
 */
- (CIImage *)sepiaToneWithImage:(CIImage *)ciImage
                     intentsity:(CGFloat)intentsity
{
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"];
    [filter setValue:ciImage forKey:kCIInputImageKey];
    if (intentsity >= 0 && intentsity <= 1) {
        [filter setValue:@(intentsity) forKey:@"inputIntensity"];
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
    return [self sepiaToneWithImage:image intentsity:0.8];
}

@end
