//
//  ImageCell.m
//  LoveQi
//
//  Created by Mr on 2018/1/8.
//  Copyright © 2018年 李琦. All rights reserved.
//

#import "ImageCell.h"

@interface ImageCell()

@property (nonatomic, strong) UIButton *colseBtn;

@end

@implementation ImageCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.imageView];
    [self addSubview:self.colseBtn];
    self.backgroundColor = [UIColor clearColor];
}

- (void)deleteImage:(UIButton *)btn {
    if (self.imageCellColseBlock) {
        self.imageCellColseBlock();
    }
}

- (void)tapImage {
    if (self.imageCellTapBlock) {
        self.imageCellTapBlock(self.indexPath);
    }
}

#pragma mark SET

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    _imageView.image = image;
}

- (void)setIsHideCloseBtn:(BOOL)isHideCloseBtn {
    _isHideCloseBtn = isHideCloseBtn;
    _colseBtn.hidden = isHideCloseBtn;
}

#pragma mark UI

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.userInteractionEnabled = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage)]];
    }
    return _imageView;
}

- (UIButton *)colseBtn {
    if (!_colseBtn) {
        _colseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_colseBtn setImage:[[UIImage imageNamed:@"delete"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:UIControlStateNormal];
        [_colseBtn addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
        _colseBtn.frame = CGRectMake(self.imageView.right - 30, 0, 30, 30);
    }
    return _colseBtn;
}

@end
