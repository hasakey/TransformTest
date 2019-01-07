//
//  ShowLoadingView.h
//  TransformTest
//
//  Created by 喂！ on 2019/1/4.
//  Copyright © 2019年 well. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShowLoadingView : UIView


@property (nonatomic, readonly) NSInteger count;

- (void)push;

- (void)pop;

@end

NS_ASSUME_NONNULL_END
