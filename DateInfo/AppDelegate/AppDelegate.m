//
//  AppDelegate.m
//  DateInfo
//
//  Created by MRJ on 2019/3/3.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "FileManager.h"
#import "YYModel.h"
#import "RiJiModel.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "RijiYearViewController.h"
#import "SetViewController.h"
#import "CYLTabBarController.h"
//#import "BaseNavViewController.h"
#import "RijiManager.h"
#import "WenzhanManager.h"
#import "LaunchImageView.h"
#import <UMCommon/UMCommon.h>
#import <UMPush/UMessage.h>
#import "ZXRequestBlock.h"
#import "MainViewController.h"
#import "XNavigationController.h"

@interface AppDelegate ()

@property (nonatomic, strong)CYLTabBarController *tabBarController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupViewControllers];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    [self.tabBarController hideTabBadgeBackgroundSeparator];
    
    //    日期接口
    //    http://timor.tech/api/holiday/year/2020
    [[UINavigationBar appearance]  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]]; 
    // Override point for customization after application launch.

    [LaunchImageView loadLaunchImage];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LaunchImageView removeLaunch];
    });
    
    [LEETheme defaultTheme:@"main"];
    
    [RijiManager shareRijiManager];
    [WenzhanManager shareManager];
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [[IQKeyboardManager sharedManager] registerTextFieldViewClass:YYTextView.class didBeginEditingNotificationName:YYTextViewTextDidBeginEditingNotification didEndEditingNotificationName:YYTextViewTextDidEndEditingNotification];
    
    // UMeng
    [self setupUMeng:launchOptions];
        
    [ZXRequestBlock disableHttpProxy];
    
    return YES;
}

- (void)setupUMeng:(NSDictionary *)launchOptions {
#ifdef DEBUG
    NSString *channel = @"DEBUG";
#else
    NSString *channel = @"App Store";
#endif
    [UMConfigure initWithAppkey:@"5f71d5ef80455950e49a6265" channel:channel];
//    [MobClick setAutoPageEnabled:YES];
    
    UMessageRegisterEntity *entity = [[UMessageRegisterEntity alloc] init];
    entity.types = UMessageAuthorizationOptionBadge | UMessageAuthorizationOptionSound | UMessageAuthorizationOptionAlert;
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
        NSString* deviceID =  [UMConfigure deviceIDForIntegration];
        NSLog(@"umeng-push: %@。。。。。。。deviceID=%@", @(granted), deviceID);
    }];
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
    RootViewController *firstViewController = [[RootViewController alloc] init];
    XNavigationController *firstNavigationController = [[XNavigationController alloc]
                                                        initWithRootViewController:firstViewController];
    
    MainViewController *secondViewController = [[MainViewController alloc] init];
    XNavigationController *secondNavigationController = [[XNavigationController alloc]
                                                         initWithRootViewController:secondViewController];
    
    SetViewController *threeViewController = [[SetViewController alloc] init];
    XNavigationController *threeNavigationController = [[XNavigationController alloc]
                                                        initWithRootViewController:threeViewController];
    
    CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];
    [self customizeTabBarForController:tabBarController];
    [tabBarController setTintColor:[UIColor whiteColor]];
    [tabBarController setViewControllers:@[
                                           firstNavigationController,
                                           secondNavigationController,
                                           threeNavigationController,
                                           ]];
    self.tabBarController = tabBarController;
    self.tabBarController.tabBar.backgroundImage = [UIImage imageWithColor:MAINCOLOR];
}

/*
 *
 在`-setViewControllers:`之前设置TabBar的属性，
 *
 */
- (void)customizeTabBarForController:(CYLTabBarController *)tabBarController {
    
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"日子",
                            CYLTabBarItemImage : @"oneBlack",
                            CYLTabBarItemSelectedImage : @"one",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"壁纸",
                            CYLTabBarItemImage : @"twoBlack",
                            CYLTabBarItemSelectedImage : @"two",
                            };
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle : @"设置",
                            CYLTabBarItemImage : @"threeBlack",
                            CYLTabBarItemSelectedImage : @"three",
                            };
    
    NSArray *tabBarItemsAttributes = @[ dict1, dict2 , dict3];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

    
    // umeng
    const unsigned *bytes = deviceToken.bytes;
    NSString *token = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                       ntohl(bytes[0]), ntohl(bytes[1]), ntohl(bytes[2]), ntohl(bytes[3]),
                       ntohl(bytes[4]), ntohl(bytes[5]), ntohl(bytes[6]), ntohl(bytes[7])
                       ];
#if DEBUG
    UIPasteboard.generalPasteboard.string = token;
#endif
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"app.push.reg.failed");
}




@end
