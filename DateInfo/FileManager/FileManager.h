//
//  AppDelegate.h
//  DateInfo
//
//  Created by MRJ on 2019/3/3.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface FileManager : NSObject

+ (instancetype)shareManager;

- (void)saveImages:(NSArray<UIImage *> *)images imageName:(NSArray *)imageNames complete:(void(^)(NSArray<NSString *>* imageUrls))completeBlock;

- (void)saveImage:(UIImage *)image imageName:(NSString *)imageName complete:(void(^)(NSString *imageUrl))completeBlock;

- (void)saveFile:(NSString *)file fileName:(NSString *)fileName complete:(void(^)(NSString *fileUrl))completeBlock;

- (NSString *)readFileNameForKey:(NSString *)keyName;

- (void)saveFileName:(NSString *)fileName ForKey:(NSString *)keyName;

- (NSString *)getMianPath;

- (BOOL)deleteImageWithPath:(NSString *)imagePath;

@end
