//
//  DefaultNotificationCenter.h
//  TransformTest
//
//  Created by 喂！ on 2019/1/3.
//  Copyright © 2019年 well. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DefaultNotificationCenter;

NS_ASSUME_NONNULL_BEGIN



@protocol DefaultNotificationCenterDelegate <NSObject>

@required

/**
 *  DefaultNotificationCenter's event.
 *
 *  @param notification DefaultNotificationCenter object.
 *  @param name         Event name.
 *  @param object       Event object, maybe nil.
 */
- (void)defaultNotificationCenter:(DefaultNotificationCenter *)notification name:(NSString *)name object:(id)object;

@end


@interface DefaultNotificationCenter : NSObject


/**
 *  Post event to notification name.
 *
 *  @param name   Notification name.
 *  @param object Data.
 */
+ (void)postEventToNotificationName:(NSString *)name object:(id)object;

/**
 *  DefaultNotificationCenter's delegate.
 */
@property (nonatomic, weak) id <DefaultNotificationCenterDelegate>  delegate;

/**
 *  Add notification name.
 *
 *  @param name Notification name.
 */
- (void)addNotificationName:(NSString *)name;

/**
 *  Delete notification name.
 *
 *  @param name Notification name.
 */
- (void)deleteNotificationName:(NSString *)name;

/**
 *  Get all the notification names.
 *
 *  @return Notification names's array.
 */
- (NSArray <NSString *> *)notificationNames;

/**
 *  Remove all notifications.
 */
- (void)removeAllNotifications;

/**
 DefaultNotificationCenter Constructor.
 
 @param delegate DefaultNotificationCenter's delegate.
 @param addNotificationNamesBlock The block to add NotificationNames.
 @return DefaultNotificationCenter object.
 */
+ (instancetype)defaultNotificationCenterWithDelegate:(id <DefaultNotificationCenterDelegate>)delegate
                                 addNotificationNames:(void (^)(NSMutableArray <NSString *> *names))addNotificationNamesBlock;

@end

NS_ASSUME_NONNULL_END
