//
//  USNavigationController.m
//  StockScreener
//
//  Created by MRJ on 2019/5/24.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import "XNavigationController.h"

@interface XNavigationController () <UIGestureRecognizerDelegate,UINavigationControllerDelegate>
@property (nonatomic, weak) id popDelegate;
@end

@implementation XNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 解决自定义leftItem后没有pop手势的问题
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
    
    [self setupUserInterfaceStyle];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count>0) {
        // push后去掉TabBar
        viewController.hidesBottomBarWhenPushed = viewController.us_hidesBottomBarWhenPushed;
        [self createLeftBarButtonItemsWithViewController:viewController selector:@selector(pushBackClick)];

    }

    [super pushViewController:viewController animated:animated];
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    
    UIViewController *realVC = viewControllerToPresent;
    if ([viewControllerToPresent isKindOfClass:XNavigationController.class]) {
        XNavigationController *vc = (XNavigationController *)viewControllerToPresent;
        if (vc.childViewControllers.count > 0) {
            realVC = vc.childViewControllers.firstObject;
        }
    }
    
    [self createLeftBarButtonItemsWithViewController:realVC selector:@selector(presentBackClick)];
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

#pragma mark - Private
- (void)createLeftBarButtonItemsWithViewController:(UIViewController *)vc selector:(SEL)selector {
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"nav_back_n"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 60, 44);
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
    negativeSpacer.width = 0;
    
    vc.navigationItem.leftBarButtonItems = @[negativeSpacer,
                                             [[UIBarButtonItem alloc] initWithCustomView:btn]
                                             ];
}

#pragma mark - Action
- (void)pushBackClick{
    [self popViewControllerAnimated:YES];
}

- (void)presentBackClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(nonnull UIViewController *)viewController animated:(BOOL)animated {
    if (viewController == self.viewControllers.firstObject) {
        self.interactivePopGestureRecognizer.delegate = self.popDelegate;
    } else {
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - Dark Mode
//
//- (void)themeStyleDidChange:(XLThemeStyle)themeStyle {
//    [super themeStyleDidChange:themeStyle];
//    [self setupUserInterfaceStyle];
//}

- (void)setupUserInterfaceStyle {
//    BOOL darkMode = self.themeStyle == XLThemeStyleDark;
    
    UIColor *titleColor = UIColor.whiteColor;
    UIColor *tintColor = UIColor.whiteColor;
    UIColor *barTintColor = MAINCOLOR;
    UIColor *backgroundColor = UIColor.whiteColor;
//    if (darkMode) {
//        titleColor = HexRGB(0xe6e6e6);
//        tintColor = HexRGB(0x16161d);
//        backgroundColor = tintColor;
//    }
    
    // 默认导航字体大小
    [self.navigationBar setTitleTextAttributes:@{
        NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
        NSForegroundColorAttributeName:titleColor
    }];
    self.navigationBar.barTintColor = barTintColor;
    self.view.backgroundColor = backgroundColor;
    // 避免返回按钮变蓝色
    self.navigationBar.tintColor = tintColor;
    // Backward Button
    UIBarButtonItem *backwardItem = self.navigationBar.items.lastObject.leftBarButtonItems.lastObject;
    UIButton *backwardButton = backwardItem.customView;
    if ([backwardButton isKindOfClass:UIButton.class]) {
        [backwardButton setImage:[UIImage imageNamed:@"bar_backward"] forState:UIControlStateNormal];
    }
    
}

@end
//
//@interface USNavigationController (MainTabBarController)
//@end
//
//@implementation USNavigationController (MainTabBarController)
//
//- (BOOL)shouldSelectWithTabBarController:(UITabBarController *)tabBarController {
//    return [self.topViewController shouldSelectWithTabBarController:tabBarController];
//}
//
//@end


@implementation UIViewController (USNavigationController)

- (BOOL)us_hidesBottomBarWhenPushed {
    return YES;
}

@end
