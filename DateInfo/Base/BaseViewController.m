//
//  BaseViewController.m
//  DateInfo
//
//  Created by MRJ on 2019/3/31.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong)UIBarButtonItem *backBtn;

@end

@implementation BaseViewController

- (void)delloc {
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}

- (void)addNavigationLeftBtns:(NSArray *)leftBtns {
    [self addNavigationLeftBtns:leftBtns withBackBtn:NO];
}

- (void)addNavigationLeftBtns:(NSArray *)leftBtns withBackBtn:(BOOL)option {
    NSMutableArray *tem_leftBtns = [NSMutableArray array];
    if (option) {
        if (_backBtn == nil) {
            _backBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_back_n"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
        }
        [tem_leftBtns addObject:_backBtn];
    }
    
    if ([leftBtns count] > 0) {
        [tem_leftBtns addObjectsFromArray:leftBtns];
    }
    [self.navigationItem setLeftBarButtonItems:tem_leftBtns];
}

- (void)addNacigationRightBtns:(NSArray *)rightBtns {
    NSMutableArray *temrightBtns = [NSMutableArray array];
    if ([rightBtns count]>0) {
        [temrightBtns addObjectsFromArray:rightBtns];
    }
    [self.navigationItem setRightBarButtonItems:rightBtns];
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    if ([self.navigationController.viewControllers count] > 1) {
        [self addNavigationLeftBtns:nil withBackBtn:YES];
    } else {
        [self addNavigationLeftBtns:nil];
    }
}

- (BOOL)gestureReconizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.navigationController != nil) {
        NSArray *ary = self.navigationController.viewControllers;
        if (ary != nil && [ary count] > 1) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}

@end
