//
//  BaseCustomViewController.h
//  TransformTest
//
//  Created by 喂！ on 2019/1/3.
//  Copyright © 2019年 well. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControllerBaseViewConfig.h"
#import "ShowLoadingView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseCustomViewController : UIViewController


extern NSString * const windowAreaViewId;
extern NSString * const loadingAreaViewId;
extern NSString * const titleViewId;
extern NSString * const contentViewId;
extern NSString * const backgroundViewId;


@property (nonatomic, strong) ShowLoadingView  *windowAreaView;
@property (nonatomic, strong) ShowLoadingView  *loadingAreaView;
@property (nonatomic, strong) UIView           *titleView;
@property (nonatomic, strong) UIView           *contentView;
@property (nonatomic, strong) UIView           *backgroundView;


#pragma mark - Overwrite by subClass.

/**
 *  Overwrite to config subViews.
 *
 *  @param viewsConfig Configs.
 */
- (void)makeViewsConfig:(NSMutableDictionary <NSString *, ControllerBaseViewConfig *> *)viewsConfig;

/**
 *  Setup data source.
 */
- (void)setupDataSource;

/**
 *  Overwrite to setup titleView, contentView etc.
 */
- (void)setupSubViews;

@end

NS_ASSUME_NONNULL_END
