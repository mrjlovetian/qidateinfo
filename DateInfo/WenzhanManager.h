//
//  WenzhanManager.h
//  DateInfo
//
//  Created by MRJ on 2019/3/29.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WenzhanManager : NSObject

@property (nonatomic, copy)NSArray *dataSource;

+ (instancetype)shareManager;

@end

NS_ASSUME_NONNULL_END
