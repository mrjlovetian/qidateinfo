//
//  WallCatageModel.h
//  XWallpaper
//
//  Created by MRJ on 2020/8/1.
//  Copyright © 2020 MRJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WallCatageModel : NSObject

@property (nonatomic, strong) NSString *catagateId;
@property (nonatomic, strong) NSString *headlineEn;
@property (nonatomic, assign) NSInteger pictureCount;
@property (nonatomic, strong) NSArray *dataSources;

@end

@interface ImageModel : NSObject

@property (nonatomic, strong)NSString *url;
@property (nonatomic, strong)NSString *titleEn;

@end

@interface ImageListModel : NSObject

@property (nonatomic, strong) NSString *catagateId;
@property (nonatomic, strong) NSArray *pictureList;

@end

NS_ASSUME_NONNULL_END
