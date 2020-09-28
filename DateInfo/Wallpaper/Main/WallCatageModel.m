//
//  WallCatageModel.m
//  XWallpaper
//
//  Created by MRJ on 2020/8/1.
//  Copyright © 2020 MRJ. All rights reserved.
//

#import "WallCatageModel.h"

@implementation WallCatageModel

+ (NSDictionary *)modelCustomPropertyMapper {
   return @{@"catagateId": @"id"};
}

@end

@implementation ImageListModel

+ (NSDictionary *)modelCustomPropertyMapper {
   return @{@"catagateId": @"id"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"pictureList" : [ImageModel class]};
}

@end

@implementation ImageModel


@end
