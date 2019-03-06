//
//  AppDelegate.h
//  DateInfo
//
//  Created by MRJ on 2019/3/3.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileManager : NSObject

+ (instancetype)shareManager

- (void)saveImage:(UIImage *)image imageName:(NSString *)imageName complete(void(^)(NSString *imageUrl))completeBlock;

- (void)saveFile:(NSString *)file fileName:(NSString *)fileName complete(void(^)(NSString *fileUrl))completeBlock;

- (NSString *)readFile;

@end