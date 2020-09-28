//
//  WallpaperCell.h
//  XWallpaper
//
//  Created by MRJ on 2020/8/1.
//  Copyright © 2020 MRJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WallCatageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WallpaperCell : UICollectionViewCell

@property (nonatomic, strong)ImageModel *imageModel;
@property (nonatomic, strong) UIImageView *iconImageView;

@end

NS_ASSUME_NONNULL_END
