//
//  WallPaperHeaderView.m
//  XWallpaper
//
//  Created by MRJ on 2020/8/1.
//  Copyright © 2020 MRJ. All rights reserved.
//

#import "WallPaperHeaderView.h"

@interface WallPaperHeaderView ()


@property (nonatomic, strong) UIButton *subBtn;

@end

@implementation WallPaperHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.titleLab];
    [self addSubview:self.subBtn];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.width.lessThanOrEqualTo(self).offset(-75);
        make.height.equalTo(self);
        make.centerY.equalTo(self);
    }];
    
    [self.subBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@60);
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self);
    }];
}

- (void)clickMore {
    if (self.wallMoreBlock) {
        self.wallMoreBlock(self.indexPath);
    }
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.font = [UIFont systemFontOfSize:17];
    }
    return _titleLab;
}

- (UIButton *)subBtn {
    if (!_subBtn) {
        _subBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_subBtn setTitle:@"More" forState:UIControlStateNormal];
        [_subBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_subBtn addTarget:self action:@selector(clickMore) forControlEvents:UIControlEventTouchUpInside];
        _subBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _subBtn;
}

@end
