//
//  BaseCustomNavigationController.h
//  TransformTest
//
//  Created by 喂！ on 2019/1/2.
//  Copyright © 2019年 well. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCustomViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseCustomNavigationController : UINavigationController


/**
 Get the BaseCustomNavigationController with the root BaseCustomViewController.
 
 @param rootViewController The root BaseCustomViewController.
 @param hidden Hidden or not.
 @return BaseCustomNavigationController object.
 */
- (instancetype)initWithRootViewController:(BaseCustomViewController *)rootViewController
                    setNavigationBarHidden:(BOOL)hidden;

@end

NS_ASSUME_NONNULL_END
