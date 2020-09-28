//
//  WallPaperHeaderView.h
//  XWallpaper
//
//  Created by MRJ on 2020/8/1.
//  Copyright © 2020 MRJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^WallMoreBlock)(NSIndexPath *);

@interface WallPaperHeaderView : UICollectionReusableView

@property (nonatomic, copy) WallMoreBlock wallMoreBlock;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) UILabel *titleLab;


@end

NS_ASSUME_NONNULL_END
