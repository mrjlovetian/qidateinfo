//
//  JumpDateView.m
//  LoveQi
//
//  Created by Mr on 2017/2/23.
//  Copyright © 2017年 李琦. All rights reserved.
//

#import "JumpDateView.h"
#import "BtnColumnView.h"

#define PICK_HEIGHT 230

@interface JumpDateView()
@property (nonatomic, strong)UIDatePicker *picker;
@property (nonatomic, strong)NSDate *maxDate;
@property (nonatomic, strong)NSDate *minDate;
@property (nonatomic, strong)UIView *backView;
@property (nonatomic, strong)BtnColumnView *btnColimnView;
@property (nonatomic, strong)UIButton *hiddenBtn;
@end

@implementation JumpDateView
- (id)initWithFrame:(CGRect)frame maxDate:(NSDate *)maxDate minDate:(NSDate *)minDate {
    self = [super initWithFrame:frame];
    if (maxDate) {
        self.maxDate = maxDate;
    }
    
    if (minDate) {
        self.minDate = minDate;
    }
    
    if (self) {
        [self initUI];
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    }
    return self;
}


#pragma mark privte
- (void)cancelClick {
    [self removeFromSuperview];
}

- (void)confirmClick {
    if ([self.delegate respondsToSelector:@selector(JumpDateViewSelectDate:)]) {
        [self.delegate JumpDateViewSelectDate:_picker.date];
    }
    [self cancelClick];
}

#pragma mark UI

- (void)initUI {
    [self addSubview:self.hiddenBtn];
    [self addSubview:self.btnColimnView];
    [self addSubview:self.backView];
    [self addSubview:self.picker];
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, _btnColimnView.bottom, ScreenWidth, PICK_HEIGHT)];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

- (UIDatePicker *)picker {
    if (!_picker) {
        _picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, _btnColimnView.bottom, ScreenWidth, PICK_HEIGHT)];
        _picker.datePickerMode = UIDatePickerModeDate;
        if (@available(iOS 13.4, *)) {
            _picker.preferredDatePickerStyle = UIDatePickerStyleWheels;
        } else {
            // Fallback on earlier versions
        }
        _picker.centerX = self.centerX;
        _picker.backgroundColor = [UIColor whiteColor];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文
        _picker.locale = locale;
        _picker.maximumDate = self.maxDate;
        _picker.minimumDate = self.minDate;
    }
    return _picker;
}

- (BtnColumnView *)btnColimnView {
    if (!_btnColimnView) {
        _btnColimnView = [[BtnColumnView alloc] initWithFrame:CGRectMake(0, _hiddenBtn.bottom, ScreenWidth, 45)];
        [_btnColimnView.leftBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        [_btnColimnView.rightBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnColimnView;
}

- (UIButton *)hiddenBtn {
    if (!_hiddenBtn) {
        _hiddenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _hiddenBtn.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - PICK_HEIGHT - 45);
        [_hiddenBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hiddenBtn;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
