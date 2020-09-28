//
//  NSArray+Monad.h
//  NorthAmerican
//
//  Created by jinxiaolong on 2019/627.
//  Copyright © 2019 10jqka. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<ObjectType> (Monad)


/**
 map

 @param block 如果返回 nil 则忽略
 @return mapped array
 */
- (NSArray *)map:(id _Nullable (^)(ObjectType obj, NSUInteger idx))block;

- (nullable id)reduce:(nullable id)initialValue next:(id _Nullable (^)(id _Nullable result, ObjectType obj))block;

@end

NS_ASSUME_NONNULL_END
