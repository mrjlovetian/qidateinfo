//
//  WallpaperCell.m
//  XWallpaper
//
//  Created by MRJ on 2020/8/1.
//  Copyright © 2020 MRJ. All rights reserved.
//

#import "WallpaperCell.h"
#import <SDWebImage/SDWebImage.h>

@interface WallpaperCell ()

@property (nonatomic, strong) UIImageView *backImageView;

@end

@implementation WallpaperCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.backImageView];
    [self addSubview:self.iconImageView];
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImageView.clipsToBounds = YES;
    }
    return _iconImageView;;
}

- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [UIImageView new];
        _backImageView.contentMode = UIViewContentModeScaleAspectFill;
        _backImageView.clipsToBounds = YES;
        _backImageView.image = [UIImage imageNamed:@"wlSplashStartIpad"];
    }
    return _backImageView;;
}


- (void)setImageModel:(ImageModel *)imageModel {
    if (_imageModel != imageModel) {
        NSString *url = [NSString stringWithFormat:@"http://wallpapers.claritywallpaper.com/%@?imageMogr2/auto-orient/thumbnail/750x/blur/1x0/quality/100", imageModel.url];
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"wlSplashStartIpad"]];
//        
    }
}

@end
