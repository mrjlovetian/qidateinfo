//
//  USToast.m
//  NorthAmerican
//
//  Created by chenxingchen on 2019/6/21.
//  Copyright © 2019 10jqka. All rights reserved.
//

#import "USToast.h"
#import "MBProgressHUD.h"
//#import <USMacros/USMacros.h>
//#import <USCategory/USCategory.h>
//#import <ThemeManager/ThemeManager.h>

static const CGFloat USToastMinHeight            = 40;
static const CGFloat USToastPadding              = 30;
static const CGFloat USToastDefaultDelay         = 2.0f;

@implementation USToast

+ (UIView *)makeToast:(NSString *)message {
    return [self makeToast:message yOffset:0.f];
}

+ (UIView *)makeToast:(NSString *)message position:(USToastPosition)position {
    return [self makeToast:message position:position delay:USToastDefaultDelay];
}

+ (UIView *)makeToast:(NSString *)message position:(USToastPosition)position delay:(float)delay {
    CGFloat yoffset = 0;
    
    switch (position) {
        case USToastPositioneTop:
            yoffset = -(ScreenHeight/2-STATUSBAR_AND_NAVIGATIONBAR_HEIGHT-USToastPadding-USToastMinHeight*0.5);
            break;
        case USToastPositionBottom:
            yoffset = ScreenHeight/2-TABBAR_HEIGHT-USToastPadding-USToastMinHeight*0.5;
            break;
        default:
            yoffset = 0;
            break;
    }
    
    UIView *hubView = [self makeToast:message yOffset:yoffset delay:delay];
    return hubView;
}

+ (UIView *)makeToast:(NSString *)message delay:(float)delay {
    return [self tipHUDForView:nil title:message yOffset:0.f hideAfterDelay:delay];
}

+ (UIView *)makeToast:(NSString *)message onView:(UIView *)view {
    return [self tipHUDForView:view title:message yOffset:0.f hideAfterDelay:2.f];
}

+ (UIView *)makeToast:(NSString *)message yOffset:(NSInteger)offset {
    return [self makeToast:message yOffset:offset delay:USToastDefaultDelay];
}

+ (UIView *)makeToast:(NSString *)message yOffset:(NSInteger)offset delay:(float)delay {
    return [self tipHUDForView:nil title:message yOffset:offset hideAfterDelay:delay];
}

+ (UIView *)tipHUDForView:(UIView *)view title:(NSString *)title yOffset:(NSInteger)offset hideAfterDelay:(NSTimeInterval)duration
{
    
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    
    
    if (title.length == 0) {
        return nil;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    if (hud) {
        hud.bezelView.color = HexRGB(0xffffff);
        // 设置字体的颜色
        hud.contentColor = UIColor.blackColor;
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.mode = MBProgressHUDModeText;
        hud.bezelView.layer.cornerRadius = 2;//圆角半径
        hud.margin = 10.f;//文字与边界之间的距离
        hud.label.font = [UIFont systemFontOfSize:16.0f];//提示文字字体
        hud.label.numberOfLines = 0;
        [hud setOffset:CGPointMake(hud.offset.x, offset)];
        hud.minSize = CGSizeMake(150,30);//外框尺寸下限
        hud.removeFromSuperViewOnHide = YES;
        hud.label.text = title;
        hud.userInteractionEnabled = NO;
        [hud hideAnimated:YES afterDelay:duration];
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = YES;
    }
    return hud;
}


@end
