//
//  XMDataManager.h
//  XScaner
//
//  Created by MRJ on 2020/6/21.
//  Copyright © 2020 MRJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WCDB/WCDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMDataManager : NSObject

+ (instancetype)shareDBManager;

@property (nonatomic, strong) WCTDatabase *database;

@end

NS_ASSUME_NONNULL_END
