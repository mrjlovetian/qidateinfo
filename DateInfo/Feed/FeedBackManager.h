//
//  FeedBackManager.h
//  StockScreener
//
//  Created by wangxiang on 2020/3/25.
//  Copyright © 2020 10jqka. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FeedBackManager : NSObject

+ (instancetype)oneInstance;
- (void)jumpYiJianVC:(void(^)(UIViewController * _Nullable viewController, NSError * _Nullable  error))block;

@end

NS_ASSUME_NONNULL_END
