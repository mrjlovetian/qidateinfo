//
//  WenzhanManager.m
//  DateInfo
//
//  Created by MRJ on 2019/3/29.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import "WenzhanManager.h"

static WenzhanManager *manager;

@implementation WenzhanManager

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [WenzhanManager new];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"book" ofType:@"json"];
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        if ([array isKindOfClass:NSArray.class]) {
            _dataSource = array;
        };
    }
    return self;
}

@end
