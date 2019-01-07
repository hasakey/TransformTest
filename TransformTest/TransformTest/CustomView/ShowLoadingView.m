//
//  ShowLoadingView.m
//  TransformTest
//
//  Created by 喂！ on 2019/1/4.
//  Copyright © 2019年 well. All rights reserved.
//

#import "ShowLoadingView.h"

@interface ShowLoadingView ()

@property (nonatomic) NSInteger count;

@end

@implementation ShowLoadingView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setup];
    }
    
    return self;
}

- (instancetype)init {
    
    if (self = [super init]) {
        
        [self setup];
    }
    
    return self;
}

- (void)setup {
    
    self.count = 0;
}

- (void)push {
    
    self.count += 1;
}

- (void)pop {
    
    self.count -= 1;
}

@synthesize count = _count;
- (void)setCount:(NSInteger)count {
    
    _count = count;
    if (_count >= 1) {
        
        self.userInteractionEnabled = YES;
        
    } else {
        
        self.userInteractionEnabled = NO;
    }
}

@end
