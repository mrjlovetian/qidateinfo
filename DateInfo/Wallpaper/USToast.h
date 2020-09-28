//
//  USToast.h
//  NorthAmerican
//
//  Created by chenxingchen on 2019/6/21.
//  Copyright © 2019 10jqka. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, USToastPosition) {
    USToastPositionCenter,
    USToastPositioneTop,
    USToastPositionBottom
};


@interface USToast : NSObject

+ (UIView *)makeToast:(NSString *)message;
+ (UIView *)makeToast:(NSString *)message position:(USToastPosition)position;
+ (UIView *)makeToast:(NSString *)message delay:(float)delay;
+ (UIView *)makeToast:(NSString *)message position:(USToastPosition)position delay:(float)delay;
+ (UIView *)makeToast:(NSString *)message onView:(UIView *)view;
+ (UIView *)makeToast:(NSString *)message yOffset:(NSInteger)offset;
+ (UIView *)makeToast:(NSString *)message yOffset:(NSInteger)offset delay:(float)delay;
@end

NS_ASSUME_NONNULL_END
