//
//  NSError+USAdd.h
//  NorthAmerican
//
//  Created by chenxingchen on 2019/6/25.
//  Copyright © 2019 10jqka. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const kErrorMsg;

@interface NSError (USAdd)
@property (nonatomic, readonly) NSString *message;
+ (instancetype)errorWithMessage:(NSString *)message;
@end

NS_ASSUME_NONNULL_END
