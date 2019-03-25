//
//  AppDelegate.m
//  DateInfo
//
//  Created by MRJ on 2019/3/3.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "FileManager.h"
#import "YYModel.h"
#import "RiModel/RiJiModel.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "RijiYearViewController.h"
#import "SetViewController.h"
#import "CYLTabBarController.h"
#import "BaseNavViewController.h"
#import "RijiManager.h"

@interface AppDelegate ()

@property (nonatomic, strong)CYLTabBarController *tabBarController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupViewControllers];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.

    [RijiManager shareRijiManager];
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [[IQKeyboardManager sharedManager] registerTextFieldViewClass:YYTextView.class didBeginEditingNotificationName:YYTextViewTextDidBeginEditingNotification didEndEditingNotificationName:YYTextViewTextDidEndEditingNotification];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark method
- (void)setupViewControllers {
    ViewController *firstViewController = [[ViewController alloc] init];
    BaseNavViewController *firstNavigationController = [[BaseNavViewController alloc]
                                                        initWithRootViewController:firstViewController];
    
    RijiYearViewController *secondViewController = [[RijiYearViewController alloc] init];
    BaseNavViewController *secondNavigationController = [[BaseNavViewController alloc]
                                                         initWithRootViewController:secondViewController];
    SetViewController *threeViewController = [[SetViewController alloc] init];
    BaseNavViewController *threeNavigationController = [[BaseNavViewController alloc]
                                                        initWithRootViewController:threeViewController];
    
    
    CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];
    [self customizeTabBarForController:tabBarController];
    
    [tabBarController setViewControllers:@[
                                           firstNavigationController,
                                           secondNavigationController,
                                           threeNavigationController,
                                           ]];
    self.tabBarController = tabBarController;
    self.tabBarController.tabBar.backgroundImage = [UIImage imageWithColor:FlatMint];
}

/*
 *
 在`-setViewControllers:`之前设置TabBar的属性，
 *
 */
- (void)customizeTabBarForController:(CYLTabBarController *)tabBarController {
    
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"信息",
                            CYLTabBarItemImage : @"home_normal",
                            CYLTabBarItemSelectedImage : @"home_highlight",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"日志",
                            CYLTabBarItemImage : @"mycity_normal",
                            CYLTabBarItemSelectedImage : @"mycity_highlight",
                            };
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle : @"设置",
                            CYLTabBarItemImage : @"mycity_normal",
                            CYLTabBarItemSelectedImage : @"mycity_highlight",
                            };
    
    NSArray *tabBarItemsAttributes = @[ dict1, dict2 , dict3];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
}


@end
