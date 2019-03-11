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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ViewController *rootVC = [[ViewController alloc] init];
    UINavigationController *rootNav = [[UINavigationController alloc] initWithRootViewController:rootVC];
    self.window.rootViewController = rootNav;
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.

    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [[IQKeyboardManager sharedManager] registerTextFieldViewClass:YYTextView.class didBeginEditingNotificationName:YYTextViewTextDidBeginEditingNotification didEndEditingNotificationName:YYTextViewTextDidEndEditingNotification];
    
//    NSArray *array = @[@{@"date":@"20190304", @"datas":@[
//        @{@"title":@"rizhi", @"content":@"content", @"images":@[@"imageUrl"], @"voices":@[@"voiceUrl"], @"videos":@[@"videoUrl"], @"date":@"20190306", @"index":@"1"},
//         @{@"title":@"rizhi3", @"content":@"content3", @"images":@[@"imageUrl"], @"voices":@[@"voiceUrl"], @"videos":@[@"videoUrl"], @"date":@"20190307", @"index":@"2"}
//    ]}, @{@"date":@"20190306", @"datas":@[
//         @{@"title":@"rizhi", @"content":@"content", @"images":@[@"imageUrl"], @"voices":@[@"voiceUrl"], @"videos":@[@"videoUrl"], @"date":@"20190306", @"index":@"1"}
//    ]}];
//
//    NSArray *infoArray = [NSArray yy_modelArrayWithClass:RiJiInfo.class json:array];
//    NSString *jsonStr = [infoArray yy_modelToJSONString];
    NSArray *arrr = [NSArray yy_modelArrayWithClass:RiJiInfo.class json:[[FileManager shareManager] readFileNameForKey:@"mrjdata"]];
    [[[UIAlertView alloc] initWithTitle:@"" message:[arrr yy_modelToJSONString] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    ;
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


@end
