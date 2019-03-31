//
//  BaseViewController.m
//  DateInfo
//
//  Created by MRJ on 2019/3/31.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    [self setLeftBtn];
}

#pragma mark - set
// 设置返回按钮
- (void)setLeftBtn {
    UIButton *btn = ({
        UIButton *btn = [UIButton new];
        [btn setImage:[UIImage imageNamed:@"nav_back_n"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"nav_back_n"] forState:UIControlStateHighlighted];
        [btn.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [btn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [btn setFrame:CGRectMake(0, 0, 40, 40)];
        [btn setContentMode:UIViewContentModeLeft];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [btn setContentEdgeInsets:UIEdgeInsetsMake(8, -4, 8, 16)];
        btn;
    });
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = barBtn;
    self.leftButton = btn;
}

- (void)leftButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
