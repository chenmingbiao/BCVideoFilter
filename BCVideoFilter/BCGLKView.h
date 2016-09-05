//
//  BCGLKView.h
//  BCVideoFilterDemo
//
//  Created by 陈明标 on 8/24/16.
//  Copyright © 2016 陈明标. All rights reserved.
//

#import <GLKit/GLKit.h>

@interface BCGLKView : GLKView

@property (strong, nonatomic) CIImage * image;

@property GLfloat preferredRotation;
@property CGSize presentationRect;

@end
