//
//  RijiManager.h
//  DateInfo
//
//  Created by MRJ on 2019/3/25.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RijiManager : NSObject

+ (instancetype)shareRijiManager;

- (void)reloadData;

@property (nonatomic, strong)NSMutableArray *rijiArr;

@end

NS_ASSUME_NONNULL_END
