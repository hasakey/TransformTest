//
//  AnimationsListController.m
//  TransformTest
//
//  Created by 喂！ on 2019/1/3.
//  Copyright © 2019年 well. All rights reserved.
//

#import "AnimationsListController.h"
#import "Item.h"
#import "ControllersHeader.h"
#import "TestCell.h"
#import "IndexRange.h"
#import "GCDQueue.h"
#import "DefaultNotificationCenter.h"
#import "NotificationEvent.h"
#import "DeviceInfo.h"
#import "UIView+SetRect.h"
#import "BackgroundLineView.h"
#import "UIView+AnimationsListViewController.h"
#import "UIView+GlowView.h"

@interface AnimationsListController ()<UITableViewDelegate,UITableViewDataSource,DefaultNotificationCenterDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic)BOOL  tableViewLoadData;

@property (nonatomic, strong) DefaultNotificationCenter *notificationCenter;

@end

@implementation AnimationsListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNotificationCenter];
    [self configureTitleView];
    
}


#pragma mark - configNotificationCenter

- (void)configNotificationCenter {
    
    self.notificationCenter = [DefaultNotificationCenter defaultNotificationCenterWithDelegate:self addNotificationNames:^(NSMutableArray<NSString *> *names) {
        
        [names addObject:NotificationEvent.ShowHomePageTableView];
    }];
}

#pragma mark - DefaultNotificationCenterDelegate

- (void)defaultNotificationCenter:(DefaultNotificationCenter *)notification name:(NSString *)name object:(id)object {
    
    if ([name isEqualToString:NotificationEvent.ShowHomePageTableView]) {
        
        [GCDQueue executeInMainQueue:^{
            
            // Load data.
            self.tableViewLoadData = YES;
           
            [self.tableView insertRowsAtIndexPaths:MakeIndexRanges(@[MakeIndexRange(0, self.dataArray.count, 0)]) withRowAnimation:UITableViewRowAnimationFade];
        }];
    }
}

#pragma mark - Overwrite super class method.

- (void)makeViewsConfig:(NSMutableDictionary<NSString *,ControllerBaseViewConfig *> *)viewsConfig {
    
    if (DeviceInfo.isFringeScreen == YES) {
        
        CGFloat iPhoneXHeight = StatusBarAndNavigationBarHeight + DeviceInfo.fringeScreenTopSafeHeight;
        
        ControllerBaseViewConfig *titleViewConfig   = viewsConfig[titleViewId];
        ControllerBaseViewConfig *contentViewConfig = viewsConfig[contentViewId];
        
        titleViewConfig.frame   = CGRectMake(0, 0, Width, iPhoneXHeight);
        contentViewConfig.frame = CGRectMake(0, iPhoneXHeight, Width, Height - iPhoneXHeight);
    }
}

- (void)setupSubViews {
    [self.contentView addSubview:self.tableView];
}


#pragma mark - Config TitleView.

- (void)configureTitleView {
    
    //头部背景
    BackgroundLineView *lineView = [BackgroundLineView backgroundLineViewWithFrame:CGRectMake(0, 0, Width, 64 + (DeviceInfo.isFringeScreen == YES ? DeviceInfo.fringeScreenTopSafeHeight : 0))
                                                                         lineWidth:4 lineGap:4
                                                                         lineColor:[[UIColor blackColor] colorWithAlphaComponent:0.015]
                                                                            rotate:M_PI_4];
    [self.titleView addSubview:lineView];
    
    // Title label.
    UILabel *headlinelabel          = [UIView animationsListViewControllerNormalHeadLabel];
    UILabel *animationHeadLineLabel = [UIView animationsListViewControllerHeadLabel];
    
    // Title view.
    UIView *titleView             = [[UIView alloc] initWithFrame:CGRectMake(0, DeviceInfo.isFringeScreen == YES ? DeviceInfo.fringeScreenTopSafeHeight : 0, Width, 64)];
    headlinelabel.center          = titleView.middlePoint;
    animationHeadLineLabel.center = titleView.middlePoint;
    [titleView addSubview:headlinelabel];
    [titleView addSubview:animationHeadLineLabel];
    [self.titleView addSubview:titleView];
    
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, titleView.height - 0.5, Width, 0.5f)];
    line.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.25f];
    [titleView addSubview:line];
    
    // Start glow.
    animationHeadLineLabel.glowRadius            = @(2.f);
    animationHeadLineLabel.glowOpacity           = @(1.f);
    animationHeadLineLabel.glowColor             = [[UIColor colorWithRed:0.203 green:0.598 blue:0.859 alpha:1] colorWithAlphaComponent:0.95f];
    
    animationHeadLineLabel.glowDuration          = @(1.f);
    animationHeadLineLabel.hideDuration          = @(3.f);
    animationHeadLineLabel.glowAnimationDuration = @(2.f);
    
    [animationHeadLineLabel createGlowLayer];
    [animationHeadLineLabel insertGlowLayer];
    
    [GCDQueue executeInMainQueue:^{
        
        [animationHeadLineLabel startGlowLoop];
        
    } afterDelaySecs:2.f];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableViewLoadData ? self.dataArray.count : 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"TestCell";
    TestCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[TestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setUpDetai:self.dataArray[indexPath.row]];

    
    return cell;
}



#pragma mark - Config DataSource.

//- (void)configureDataSource {
//
//    NSArray *array = @[[Item itemWithObject:[ButtonPressViewController         class]  name:@"POP-按钮动画"],
//                       [Item itemWithObject:[PopStrokeController               class]  name:@"POP-Stroke动画"],
//                       [Item itemWithObject:[CAShapeLayerPathController        class]  name:@"CAShapeLayer的path动画"],
//                       [Item itemWithObject:[TransformFadeViewController       class]  name:@"图片碎片化mask动画"],
//                       [Item itemWithObject:[CAGradientViewController          class]  name:@"CAGradientLayer动画"],
//                       [Item itemWithObject:[PopNumberController               class]  name:@"POP-数值动画"],
//                       [Item itemWithObject:[CircleAnimationViewController     class]  name:@"Easing-圆环动画"],
//                       [Item itemWithObject:[ScrollImageViewController         class]  name:@"UIScrollView视差效果动画"],
//                       [Item itemWithObject:[ScrollBlurImageViewController     class]  name:@"UIScrollView视差模糊效果"],
//                       [Item itemWithObject:[TableViewTapAnimationController   class]  name:@"UITableView状态切换效果"],
//                       [Item itemWithObject:[POPSpringParameterController      class]  name:@"POP-Spring动画参数详解"],
//                       [Item itemWithObject:[HeaderViewTapAnimationController  class]  name:@"UITableView展开缩放动画"],
//                       [Item itemWithObject:[CountDownTimerController          class]  name:@"UITableView显示倒计时"],
//                       [Item itemWithObject:[ClockViewController               class]  name:@"时钟动画效果"],
//                       [Item itemWithObject:[DrawWaveViewController            class]  name:@"绘制波形图动画"],
//                       [Item itemWithObject:[LabelScaleViewController          class]  name:@"UILabel缩放动画"],
//                       [Item itemWithObject:[ShimmerController                 class]  name:@"Facebook辉光动画"],
//                       [Item itemWithObject:[EmitterSnowController             class]  name:@"粒子动画-雪花"],
//                       [Item itemWithObject:[ScratchImageViewController        class]  name:@"刮奖效果"],
//                       [Item itemWithObject:[LiveImageViewController           class]  name:@"图片切换效果"],
//                       [Item itemWithObject:[AlertViewController               class]  name:@"抽象的AlertView"],
//                       [Item itemWithObject:[WaterfallLayoutController         class]  name:@"瀑布流效果"],
//                       [Item itemWithObject:[MixedColorProgressViewController  class]  name:@"UILabel混色显示"],
//                       [Item itemWithObject:[PageFlipEffectController          class]  name:@"翻页效果"],
//                       [Item itemWithObject:[CATransform3DM34Controller        class]  name:@"CATransform3D m34"],
//                       [Item itemWithObject:[PressAnimationButtonController    class]  name:@"按钮特效"],
//                       [Item itemWithObject:[BezierPathViewController          class]  name:@"心电图动画效果"],
//                       [Item itemWithObject:[MusicBarAnimationController       class]  name:@"音乐波形图动画"],
//                       [Item itemWithObject:[ColorProgressViewController       class]  name:@"彩色进度条"],
//                       [Item itemWithObject:[SpringEffectController            class]  name:@"果冻效果"],
//                       [Item itemWithObject:[CASpringAnimationController       class]  name:@"CASpringAnimation"],
//                       [Item itemWithObject:[AdditiveAnimationController       class]  name:@"Additive属性动画"],
//                       [Item itemWithObject:[MotionEffectViewController        class]  name:@"MotionEffect效果"],
//                       [Item itemWithObject:[GifPictureController              class]  name:@"加载GIF图片"],
//                       [Item itemWithObject:[SCViewShakerController            class]  name:@"震动效果"],
//                       [Item itemWithObject:[ScrollViewAnimationController     class]  name:@"ScrollView动画"],
//                       [Item itemWithObject:[TapCellAnimationController        class]  name:@"Cell点击动画"],
//                       [Item itemWithObject:[ReplicatorLineViewController      class]  name:@"线性重复动画"],
//                       [Item itemWithObject:[DrawMarqueeViewController         class]  name:@"跑马灯效果"],
//                       [Item itemWithObject:[LazyFadeInViewController          class]  name:@"文本渐变动画效果"],
//                       [Item itemWithObject:[OffsetCellViewController          class]  name:@"Cell图片视差动画"],
//                       [Item itemWithObject:[SystemFontInfoController          class]  name:@"系统字体列表"],
//                       [Item itemWithObject:[iCarouselViewController           class]  name:@"旋转木马效果"],
//                       [Item itemWithObject:[GridFlowLayoutViewController      class]  name:@"水平方向瀑布流"],
//                       [Item itemWithObject:[InfiniteLoopViewController        class]  name:@"无限轮播图"],
//                       [Item itemWithObject:[BaseControlViewController         class]  name:@"BaseControl按钮合集"],
//                       [Item itemWithObject:[SpringScaleViewController         class]  name:@"POP-缩放"],
//                       [Item itemWithObject:[TapPathDrawViewController         class]  name:@"点击区域的绘制"],
//                       [Item itemWithObject:[QRCodeViewController              class]  name:@"QR-Code"],
//                       [Item itemWithObject:[MaskShapeViewController           class]  name:@"不规则形状的Mask"],
//                       [Item itemWithObject:[WaterWaveViewController           class]  name:@"水波纹效果"],
//                       [Item itemWithObject:[IrregularGridViewController       class]  name:@"不规则GridCell"],
//                       [Item itemWithObject:[MixCellsViewController            class]  name:@"混合cell"],
//                       [Item itemWithObject:[ScrollCarouselViewController      class]  name:@"线性旋转木马"],
//                       [Item itemWithObject:[LoadCSSViewController             class]  name:@"Load CSS"],
//                       [Item itemWithObject:[CountDownButtonController         class]  name:@"倒计时按钮"],
//                       [Item itemWithObject:[CustomCollectionViewController    class]  name:@"定制的CollectionView"],
//                       [Item itemWithObject:[TreeStructureTableViewController  class]  name:@"树形结构cell"],
//                       [Item itemWithObject:[DrawRectViewController            class]  name:@"DrawRect"],
//                       [Item itemWithObject:[TwoLevelLinkageViewController     class]  name:@"级联菜单"],
//                       [Item itemWithObject:[CustomPickerViewController        class]  name:@"自定义PickerView"],
//                       [Item itemWithObject:[CustomCityPickerViewController    class]  name:@"城市选择器"],
//                       [Item itemWithObject:[SKEmitterNodeController           class]  name:@"SKEmitterNode的使用"],
//                       [Item itemWithObject:[LineLayoutViewController          class]  name:@"LineLayout"],
//                       [Item itemWithObject:[DynamicSwitchingLayoutController  class]  name:@"动态切换Layout"],
//                       [Item itemWithObject:[InfoInputViewController           class]  name:@"输入检测逻辑动画"]];
//
//    self.items = [NSMutableArray array];
//    [array enumerateObjectsUsingBlock:^(Item *item, NSUInteger idx, BOOL *stop) {
//
//        item.index = idx + 1;
//        [self.items addObject:[ListItemCell dataAdapterWithData:item]];
//    }];
//}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView                = [[UITableView alloc] initWithFrame:self.contentView.bounds style:UITableViewStylePlain];
        _tableView.delegate       = self;
        _tableView.dataSource     = self;
        _tableView.rowHeight      = 50.f;

//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}

-(NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[
                                               @{@"Name":@"第一行"},
                                               @{@"Name":@"哈哈哈"},
                                               @{@"Name":@"第三行"},
                                               @{@"Name":@"嘻嘻嘻"},
                                               @{@"Name":@"第五行"},
                                               @{@"Name":@"啦啦啦"},
                                               @{@"Name":@"第七行"},
                                               @{@"Name":@"哈哈哈"},
                                               @{@"Name":@"第九行"},
                                               @{@"Name":@"嘻嘻嘻"},
                                               @{@"Name":@"第十一行"},
                                               @{@"Name":@"啦啦啦"},
                                               @{@"Name":@"第十三行"},
                                               @{@"Name":@"嘻嘻嘻"},
                                               @{@"Name":@"第十五行"},
                                               @{@"Name":@"啦啦啦"},
                                               @{@"Name":@"第十七行"},
                      ];
    }
        return _dataArray;
}

@end
