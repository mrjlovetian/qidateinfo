//
//  XMDataManager.m
//  XScaner
//
//  Created by MRJ on 2020/6/21.
//  Copyright © 2020 MRJ. All rights reserved.
//

#import "RiJiModel.h"
#import "XMDataManager.h"

static XMDataManager *manager = nil;

@interface XMDataManager ()

//@property (nonatomic, strong) WCTDatabase *database;

@end

@implementation XMDataManager

+ (instancetype)shareDBManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[XMDataManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 文件路径
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"rijModelPath.sqlite"];
    self.database = [[WCTDatabase alloc] initWithPath:filePath];
    BOOL re = [self.database createTableAndIndexesOfName:@"RiJiModel" withClass:RiJiModel.class];
    return self;
}

@end
