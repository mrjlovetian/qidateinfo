//
//  USNavigationController.h
//  StockScreener
//
//  Created by MRJ on 2019/5/24.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XNavigationController : UINavigationController

@end

@interface UIViewController (USNavigationController)

/// **default**: YES
@property (nonatomic, readonly) BOOL us_hidesBottomBarWhenPushed;

@end

NS_ASSUME_NONNULL_END
