//
//  Item.h
//  TransformTest
//
//  Created by 喂！ on 2019/1/3.
//  Copyright © 2019年 well. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Item : NSObject


@property (nonatomic, copy)   NSString *name;
@property (nonatomic, strong) id        object;
@property (nonatomic)                   NSInteger index;

+ (instancetype)itemWithObject:(id)object name:(NSString *)name;

@property (nonatomic, copy, readonly) NSMutableAttributedString *nameString;

@end

NS_ASSUME_NONNULL_END
