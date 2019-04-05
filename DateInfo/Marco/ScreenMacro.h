//
//  ScreenMacro.h
//  LoveQi
//
//  Created by tops on 2018/1/25.
//  Copyright © 2018年 李琦. All rights reserved.
//

#ifndef ScreenMacro_h
#define ScreenMacro_h

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

#endif /* ScreenMacro_h */
