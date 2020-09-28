//
//  ScreenMacro.h
//  LoveQi
//
//  Created by tops on 2018/1/25.
//  Copyright © 2018年 李琦. All rights reserved.
//

#ifndef ScreenMacro_h
#define ScreenMacro_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define ScreenSzie [[UIScreen mainScreen] bounds].size
#define ScreenWidth (ScreenSzie.width)
#define ScreenHeight (iPhoneX?(ScreenSzie.height):ScreenSzie.height)
#define NavBarHeight Height_NavBar//bar的高度
#define StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define VScaleRate (iPhone6Plus ? 1 : 2.0/3.0)
#define VScaleRateWidth ScreenSzie / 320.0 //算宽度比率isPad
#define VScaleRateNewWidth ScreenWidth / 375.0 //以6s为基准计算比例
#define VScaleRateHeight ScreenHeight / 736.0 //算高度比率
#define VScaleRateNewHeight ScreenHeight / 667 //算高度比率
#define VGetX(x) x*VScaleRateHeight;
#define Edge 15 //边距15
#define RowHeight 50 //行高，1行选择的高度
#define CellHeight 55 //输入内容的行高
#define ButtonHeight 48 //按钮高度

#define HexRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)/255.0) green:((float)((rgbValue & 0xFF00) >> 8)/255.0) blue:((float)((rgbValue & 0xFF))/255.0) alpha:1.0]

//用于判断设备是否为iphoneX/iphoneXS
#define IS_IPHONEXS (( fabs( ( double )ScreenHeight - ( double )812 ) < DBL_EPSILON )&&( fabs( ( double )ScreenWidth - ( double )375 ) < DBL_EPSILON ))
//用于判断设备是否为iphoneXR/iphoneXS Max
#define IS_IPHONEXR_MAX (( fabs( ( double )ScreenHeight - ( double )896 ) < DBL_EPSILON )&&( fabs( ( double )ScreenWidth - ( double )414 ) < DBL_EPSILON ))
//用于判断设备是否有刘海
#define IS_IPHONEX ( IS_IPHONEXS || IS_IPHONEXR_MAX )

// 状态栏与导航栏的高度
#define STATUSBAR_AND_NAVIGATIONBAR_HEIGHT (IS_IPHONEX ? 88.0f:64.0f)

#define SCREENAPPLY(x, y) CGSizeMake(ScreenWidth / 375.0 * (x), ScreenHeight / 667.0 * (y))
#define SCREENAPPLYSPACE(x) ScreenWidth / 375.0 * (x)
#define SCREENAPPLYHEIGHT(x) ScreenHeight / 667.0 * (x)

#define UIColorFromRGBA(r,g,b,a)            [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define UIColorFromRGB(r,g,b)               UIColorFromRGBA(r,g,b,1.0)

//tabbar高度
#define TABBAR_HEIGHT (IS_IPHONEX ? (49.0f+34.0f):49.0f)

static inline BOOL IsEmpty(id thing) {
    return thing == nil || [thing isEqual:[NSNull null]]
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSArray *)thing count] == 0);
}

#endif /* ScreenMacro_h */
