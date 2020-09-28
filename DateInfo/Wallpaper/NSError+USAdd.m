//
//  NSError+USAdd.m
//  NorthAmerican
//
//  Created by chenxingchen on 2019/6/25.
//  Copyright © 2019 10jqka. All rights reserved.
//

#import "NSError+USAdd.h"
NSString *const kErrorMsg = @"message";

@implementation NSError (USAdd)
- (NSString *)message {
    if (!self.userInfo) {
        return nil;
    }
    
    return self.userInfo[kErrorMsg];
}

+ (instancetype)errorWithMessage:(NSString *)message {
    if (!message) {
        message = @"";
    }
    return [NSError errorWithDomain:@"" code:-1 userInfo:@{kErrorMsg:message}];
}
@end
