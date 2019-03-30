//
//  RijiManager.m
//  DateInfo
//
//  Created by MRJ on 2019/3/25.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import "RijiManager.h"
#import "RiJiModel.h"
#import "FileManager.h"

static RijiManager *manager = nil;

@implementation RijiManager

+ (instancetype)shareRijiManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [RijiManager new];
    });
    return manager;
}

- (id)init {
    self = [super init];
    if (self) {
        _rijiArr = [NSMutableArray arrayWithCapacity:1];
        [self reloadData];
    }
    return self;
}

- (void)reloadData {
    [_rijiArr removeAllObjects];
    [_rijiArr addObjectsFromArray:[NSArray yy_modelArrayWithClass:RiJiYear.class json:[[FileManager shareManager] readFileNameForKey:@"mrjdata"]]];
}

@end
