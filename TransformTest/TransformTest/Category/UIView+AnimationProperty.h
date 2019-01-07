//
//  UIView+AnimationProperty.h
//  TransformTest
//
//  Created by 喂！ on 2019/1/2.
//  Copyright © 2019年 well. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (AnimationProperty)

/**
 *  CGAffineTransformMakeScale
 */
@property (nonatomic) CGFloat  scale;

/**
 *  CGAffineTransformMakeRotation
 */
@property (nonatomic) CGFloat  angle;

@end

NS_ASSUME_NONNULL_END
