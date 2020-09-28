//
//  NSArray+Monad.m
//  NorthAmerican
//
//  Created by jinxiaolong on 2019/627.
//  Copyright © 2019 10jqka. All rights reserved.
//

#import "NSArray+Monad.h"

@implementation NSArray (Monad)

- (NSArray *)map:(id  _Nullable (^)(id _Nonnull, NSUInteger))block {
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:self.count];

    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id ret = block(obj, idx);
        if (ret) {
            [results addObject:ret];
        }
    }];
    return [results copy];
}

- (id)reduce:(id)initialValue next:(id  _Nullable (^)(id _Nullable, id _Nonnull))block {
    id result = initialValue;    
    for (id obj in self) {
        result = block(result, obj);
    }
    return result;
}

@end
