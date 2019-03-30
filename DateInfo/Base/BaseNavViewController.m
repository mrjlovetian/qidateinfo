//
//  BaseNavViewController.m
//  SystemInfo
//
//  Created by MRJ on 2019/3/13.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import "BaseNavViewController.h"

@interface BaseNavViewController ()

@end

@implementation BaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = MAINCOLOR;
    self.view.lee_theme.LeeAddBackgroundColor(@"main", MAINCOLOR);
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                      NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:17]}];
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    return self;
}

@end
