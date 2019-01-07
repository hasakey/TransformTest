//
//  UIView+AnimationProperty.m
//  TransformTest
//
//  Created by 喂！ on 2019/1/2.
//  Copyright © 2019年 well. All rights reserved.
//

#import "UIView+AnimationProperty.h"
#import <objc/runtime.h>

@implementation UIView (AnimationProperty)

#pragma mark - Scale.

NSString * const _recognizerScale = @"_recognizerScale";

-(CGFloat)scale
{
    
    NSNumber *scaleValue = objc_getAssociatedObject(self,(__bridge const void * _Nonnull)(_recognizerScale));
    return scaleValue.floatValue;
//    NSNumber *scaleValue = objc_getAssociatedObject(self, (__bridge const void *)(_recognizerScale));
//    return scaleValue.floatValue;
}

-(void)setScale:(CGFloat)scale
{
    objc_setAssociatedObject(self, (__bridge const void * _Nonnull)(_recognizerScale), @(scale), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.transform = CGAffineTransformMakeScale(scale, scale);
}

#pragma mark - Angle.

NSString * const _recognizerAngle = @"_recognizerAngle";

-(CGFloat)angle
{
    NSNumber *angleValue = objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(_recognizerAngle));
    return angleValue.floatValue;
}

-(void)setAngle:(CGFloat)angle
{
    objc_setAssociatedObject(self, (__bridge const void * _Nonnull)(_recognizerAngle), @(angle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.transform = CGAffineTransformMakeRotation(angle);
}

@end
