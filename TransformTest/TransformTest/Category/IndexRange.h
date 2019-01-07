//
//  IndexRange.h
//  TransformTest
//
//  Created by 喂！ on 2019/1/3.
//  Copyright © 2019年 well. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IndexRange : NSObject

@property (nonatomic) NSUInteger section;
@property (nonatomic) NSUInteger location;
@property (nonatomic) NSUInteger length;


+ (NSMutableArray <NSIndexPath *> *)indexPathsFromIndexRanges:(NSArray <IndexRange *> *)indexRanges;

@end


NS_INLINE IndexRange *MakeIndexRange(NSUInteger loc, NSUInteger len, NSUInteger section)
{
    IndexRange *r = [IndexRange new];
    r.location    = loc;
    r.length      = len;
    r.section     = section;
    
    return r;
}

NS_INLINE NSMutableArray <NSIndexPath *> * MakeIndexRanges(NSArray <IndexRange *> *indexRanges) {
    
    return [IndexRange indexPathsFromIndexRanges:indexRanges];
}


NS_ASSUME_NONNULL_END
