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

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    self.view.backgroundColor = [UIColor whiteColor];
    return self;
}

@end
