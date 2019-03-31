//
//  RijiSectionView.m
//  DateInfo
//
//  Created by MRJ on 2019/3/31.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import "RijiSectionView.h"

@interface RijiSectionView ()

@property (nonatomic, strong)UIImageView *leftView;
@property (nonatomic, strong)UILabel *titleLab;

@end

@implementation RijiSectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.lee_theme.LeeAddBackgroundColor(@"main", MAINCOLOR);
        self.userInteractionEnabled = YES;
        [self addSubview:self.leftView];
        [self addSubview:self.titleLab];
        self.btnState = 0;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabView)]];
//        [_leftBtn addTarget:self action:@selector(clickLeft) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark method

- (void)tabView {
    if (self.lefyCallback) {
        self.lefyCallback(self.btnState);
    }
}

#pragma mark set
- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    _titleLab.text = titleStr;
}

- (void)setBtnState:(NSInteger)btnState {
    _btnState = btnState;
    if (self.btnState) {
        CGAffineTransform transform= CGAffineTransformMakeRotation(M_PI*0.5);
        self.leftView.transform = transform;//旋转
    } else {
        CGAffineTransform transform= CGAffineTransformMakeRotation(-M_PI*0);
        self.leftView.transform = transform;//旋转
    }
}

#pragma mark get

- (UIImageView *)leftView {
    if (!_leftView) {
        _leftView = [UIImageView new];
        _leftView.frame = CGRectMake(10, 0, self.height, self.height);
        _leftView.image = [UIImage imageNamed:@"leftArrow"];
        _leftView.contentMode = UIViewContentModeCenter;
    }
    return _leftView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(_leftView.right, _leftView.top, ScreenWidth - _leftView.right, _leftView.height)];
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.font = [UIFont systemFontOfSize:17.0];
    }
    return _titleLab;
}

@end
