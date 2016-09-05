//
//  BCCoreImageView.m
//  BCVideoFilterDemo
//
//  Created by 陈明标 on 8/19/16.
//  Copyright © 2016 陈明标. All rights reserved.
//

#import "BCGLKView.h"

#import <GLKit/GLKit.h>

@interface BCGLKView () {
    CIContext *coreImageContext;
}

@end

@implementation BCGLKView

- (instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
        self = [self initWithFrame:frame context:context];
    }
    
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame context:(EAGLContext *)context {
    self = [super initWithFrame:frame context:context];
    
    if (self) {
        coreImageContext = [CIContext contextWithEAGLContext:context];
        [self setEnableSetNeedsDisplay:false];
    }
    
    return self;
}

- (void) drawRect:(CGRect)rect {
    
    // 构造解码比例
    CGRect origninalRect = CGRectMake(0, 260, 760, 520);
    
    // 获取比例屏幕相对比例
//    CGFloat widthScale  = (rect.size.width / origninalRect.size.width) * 2;
//    CGFloat heightScale = (rect.size.height / origninalRect.size.height) * 2;
    
//    CGRect destRect = CGRectApplyAffineTransform(origninalRect, CGAffineTransformMakeScale(widthScale, heightScale));
    [coreImageContext drawImage:self.image inRect:origninalRect fromRect:self.image.extent];
    
}

@end

