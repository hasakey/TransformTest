//
//  AnimationsListViewNavigationControllerViewController.m
//  TransformTest
//
//  Created by 喂！ on 2019/1/2.
//  Copyright © 2019年 well. All rights reserved.
//

#import "AnimationsListViewNavigationControllerViewController.h"
#import "DefaultNotificationCenter.h"
#import "NotificationEvent.h"

@interface AnimationsListViewNavigationControllerViewController ()

@end

@implementation AnimationsListViewNavigationControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // LaunchImage
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    iconImageView.image        = AppleSystemService.launchImage;
    [self.view addSubview:iconImageView];

    // Do animation
    [UIView animateKeyframesWithDuration:1.f delay:2.f options:0 animations:^{

        iconImageView.scale = 1.2f;
        iconImageView.alpha = 0.f;

    } completion:^(BOOL finished) {

        [DefaultNotificationCenter postEventToNotificationName:NotificationEvent.ShowHomePageTableView object:nil];
        [iconImageView removeFromSuperview];
    }];
}



@end
