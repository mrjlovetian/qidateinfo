//
//  HXColor.m
//  DateInfo
//
//  Created by MRJ on 2019/3/24.
//  Copyright © 2019 MRJ. All rights reserved.
//


#import "HexColor.h"

@implementation HexColor

///**
// *  提示字体颜色
// */
//+ (UIColor *) alertTextColor {
//    return UIColorFromRGB(0xcccccc);
//}
//
///**
// *  蓝色  是否点击后
// */
//+ (UIColor *) blueWhenSelected:(BOOL)isSelected {
//    UIColor * resultColor = nil;
//    if (isSelected) { //      选中状态
//
//        resultColor = UIColorFromRGB(0x0098e2);
//    } else {          //      未选中状态
//
//        resultColor = UIColorFromRGB(0x00acff);
//    }
//    return resultColor;
//}
//
///**
// *  红色  是否点击后
// */
//+ (UIColor *) redWhenSelected:(BOOL)isSelected {
//    UIColor * resultColor = nil;
//    if (isSelected) { //      选中状态
//
//        resultColor = UIColorFromRGB(0xed6262);
//    } else {          //      未选中状态
//
//        resultColor = UIColorFromRGB(0xff6b6b);
//    }
//    return resultColor;
//}

/**
 *  银色  是否点击后
 */
//+ (UIColor *) whiteWhenSelected:(BOOL)isSelected {
//    UIColor * resultColor = nil;
//    if (isSelected) { //      选中状态
//
//        resultColor = UIColorFromRGB(0xefefef);
//    } else {          //      未选中状态
//
//        resultColor = UIColorFromRGB(0xffffff);
//    }
//    return resultColor;
//}
//
///**
// *  导航栏灰色
// */
//+ (UIColor *) naviBarGrayColor {
//    return RGBA(131, 142, 160, 1);
//}
//
//#pragma mark - 老版本颜色
//
//+ (UIColor *) navigationBarBackgroundColor {
//    return RGBA(26, 36, 49, 1);
//}
//
///**
// *  半透明 黑色蒙版  0.7透明度
// */
//+ (UIColor *) translucentBlackColor {
//    return RGBA(0,0,0,0.7);
//}
//
//#pragma mark - Response 新增color
///**
// *  发求回应、展现，次标题颜色、线的颜色
// */
//+ (UIColor *)responseColor
//{
//    return UIColorFromRGB(0xbfc4c9);
//}
//
///**
// *  半透明 按钮颜色
// */
//+ (UIColor *)responseBtnColorIsHavePic:(BOOL)isHavePic
//{
//    if (isHavePic) {
//        return RGBA(0, 205, 174, 0.3);
//    }
//    return RGBA(178, 178, 178, 0.3);
//}
//
///**
// * 求回应的title
// */
//+ (UIColor *)responseTitleColor
//{
//    return UIColorFromRGB(0x868b90);
//}
//
///**
// * 求回应头像的阴影颜色
// */
//+ (UIColor *)responseShadowColor
//{
//    return UIColorFromRGB(0x666666);
//}
//
///**
// * 消息发送状态  送达颜色
// */
//+ (UIColor *)messageSendColor {
//    return UIColorFromRGB(0xf1bb75);
//}
//
///**
// * 消息发送状态  失败颜色
// */
//+ (UIColor *)messageFailColor {
//    return UIColorFromRGB(0xeea09c);
//}
//
//#pragma mark - 标准颜色
///**
// * 背景颜色 浅色
// */
//+ (UIColor *)bgColor8WithAlpha:(CGFloat)alpha
//{
//    return UIColorFromRGBWithAlpha(0xf8f8f8,alpha);
//}
//
///**
// * 背景颜色 深色
// */
//+ (UIColor *)bgColor5WithAlpha:(CGFloat)alpha
//{
//    //    return UIColorFromRGBWithAlpha(0xf5f5f5, alpha);
//    return UIColorFromRGBWithAlpha(0xffffff, alpha);
//}
//
///**
// * 线条颜色
// */
//+ (UIColor *)lineColorWithAlpha:(CGFloat)alpha
//{
//    return UIColorFromRGBWithAlpha(0xe6e6e6, alpha);
//}
//
///**
// * 浅色----小浅色
// */
//+ (UIColor *)lightColorWithAlpha:(CGFloat)alpha
//{
//    return UIColorFromRGBWithAlpha(0xd8d8d8, alpha);
//}
//
///**
// * 中色----中浅色
// */
//+ (UIColor *)middleColorWithAlpha:(CGFloat)alpha
//{
//    return UIColorFromRGBWithAlpha(0xb2b2b2, alpha);
//}
//
///**
// * 深色----深色
// */
//+ (UIColor *)darkColorWithAlpha:(CGFloat)alpha
//{
//    return UIColorFromRGBWithAlpha(0x959595, alpha);
//}
///**
// * 帖子卡片的 小清新灰色
// */
//+ (UIColor *)postListCardGrayD2Color {
//    return UIColorFromRGB(0xd2d2d2);
//}
///**
// * 正文颜色
// */
//+ (UIColor *)contentColorWithAlpha:(CGFloat)alpha
//{
//    return UIColorFromRGBWithAlpha(0x848585, alpha);
//}
///**
// * 大标题
// */
//+ (UIColor *)titleColorWithAlpha:(CGFloat)alpha
//{
//    return [UIColor colorWithHexString:@"#2e302f" alpha:alpha];
//}
//
///**
// * 话题标题颜色
// */
//+ (UIColor *)topicTitleColorWithAlpha:(CGFloat)alpha
//{
//    return UIColorFromRGBWithAlpha(0x1b1b1b, alpha);
//}
//
///**
// * 标准绿色
// */
//+ (UIColor *)greenColorWithAlpha:(CGFloat)alpha
//{
//    return UIColorFromRGBWithAlpha(0x00cdae, alpha);
//}
//
///**
// * 绿色的标题颜色
// */
//+ (UIColor *)titleGreenColorWithAlpha:(CGFloat)alpha
//{
//    return UIColorFromRGBWithAlpha(0x30ffd2, alpha);
//}
//
//#pragma mark - 出现过的颜色 不知道搁哪 就搁这吧
///**
// * 提示  升级头像 背景颜色
// */
//+ (UIColor *)remindUpgardColorWithAlpha:(CGFloat)alpha
//{
//    return UIColorFromRGBWithAlpha(0x18d1b5, alpha);
//}
//
///**
// * 搜索界面的背景颜色
// */
//+ (UIColor *)searchBgColorWithAlpha:(CGFloat)alpha
//{
//    return RGBA(49, 49, 49, alpha);
//}
//
///**
// * 提醒的小圆点
// */
//+(UIColor *)redCircleColorWithAlpha:(CGFloat)alpha
//{
//    return UIColorFromRGBWithAlpha(0xfd6260, alpha);
//}
//
///**
// * 新版Cell主标题
// */
//+(UIColor *)newCellTitleColorWithAlpha:(CGFloat)alpha
//{
//    return UIColorFromRGBWithAlpha(0x2e302f, alpha);
//}
//
///**
// * 新版Cell副标题
// */
//+(UIColor *)newCellSubTitleColorWithAlpha:(CGFloat)alpha
//{
//    return UIColorFromRGBWithAlpha(0x959796, alpha);
//}
//
///**
// * 新版Cell内容
// */
//+(UIColor *)newCellContentColorWithAlpha:(CGFloat)alpha
//{
//    return UIColorFromRGBWithAlpha(0x5a5c5b, alpha);
//}
//
///**
// * 新辅助类内容颜色
// */
//+(UIColor *)newHintContentColorWithAlpha:(CGFloat)alpha
//{
//    return UIColorFromRGBWithAlpha(0xb1b3b2, alpha);
//}
//
///**
// * 新版line颜色
// */
//+(UIColor *)newLineColorWithAlpha:(CGFloat)alpha
//{
//    return UIColorFromRGBWithAlpha(0xe8eae9, alpha);
//}
//
///**
// * 新版背景颜色
// */
//+(UIColor *)newBackgroundColorWithAlpha:(CGFloat)alpha
//{
//    return UIColorFromRGBWithAlpha(0xf6f8f7, alpha);
//}
//
///**
// * 背景颜色
// */
//+(UIColor *)newBackgroundColor5WithAlpha:(CGFloat)alpha
//{
//    return UIColorFromRGBWithAlpha(0xf5f7f6, alpha);
//}
//
///**
// * 新版浅色背景
// */
//+(UIColor *)newBackgroundMiddleColorWithAlpha:(CGFloat)alpha
//{
//    return UIColorFromRGBWithAlpha(0xfdfffe, alpha);
//}
//
///**
// * 时间颜色
// */
//+(UIColor *)timeColorWithAlpha:(CGFloat)alpha
//{
//    return UIColorFromRGBWithAlpha(0xb2b4b3, alpha);
//}
//
///**
// * 透明白色
// */
//+(UIColor *)newWhiteColorWithAlpha:(CGFloat)alpha
//{
//    return UIColorFromRGBWithAlpha(0xffffff, alpha);
//}
//
//
///**
// * 新版绿色
// */
//+(UIColor *)newGreenColorWithAlpha:(CGFloat)alpha
//{
//    return UIColorFromRGBWithAlpha(0x39d9ab, alpha);
//}
//
///**
// * 边缘线颜色
// */
//+(UIColor *)newBorderLineColorWithAlpha:(CGFloat)alpha
//{
//    return UIColorFromRGBWithAlpha(0xc1c3c2, alpha);
//}
//
///**
// * 提示辅助类颜色
// */
//+(UIColor *)newHintColorWithAlpha:(CGFloat)alpha
//{
//    return UIColorFromRGBWithAlpha(0xb1b3b2, alpha);
//}
//
///**
// * 提示辅助类背景颜色
// */
//+(UIColor *)newHintBgColorWithAlpha:(CGFloat)alpha
//{
//    return UIColorFromRGBWithAlpha(0xe6e8e7, alpha);
//}
//
///**
// * 占位符颜色
// */
//+(UIColor *)newPlaceholderColorWithAlpha:(CGFloat)alpha
//{
//    return UIColorFromRGBWithAlpha(0xd1d3d2, alpha);
//}

// ---------------------------------------------------------------------------------------------------
#pragma mark - IOS类扩展之Hex值颜色转换
/**
 *  Hex值颜色转换
 *
 *  @param color 十六进制色值
 *  @param alpha 透明度
 *
 *  @return 颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

/**
 *  Hex值颜色转换,默认的透明度为1
 *
 *  @param color 十六进制色值
 *
 *  @return 颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}

/**
 * 字体颜色 标题与导航
 */
+ (UIColor *)fontColorWithTitleOrBar{
    
    return [UIColor colorWithHexString:@"#2e302f"];
}

//+ (UIColor *)fontColorWithTitleOrBarWithAlpha:(CGFloat)alpha{
//    
//    return [UIColor colorWithHexString:@"#2e302f" alpha:alpha];
//}
//
///**
// * 字体颜色 正文
// */
//+ (UIColor *)fontColorWithContent{
//    
//    return [UIColor colorWithHexString:@"#848585"];
//}
//
//+ (UIColor *)fontColorWithContentWithAlpha:(CGFloat)alpha{
//    
//    return [UIColor colorWithHexString:@"#848585" alpha:alpha];
//}
//
///**
// * 字体颜色 绿色
// */
//+ (UIColor *)fontColorWithGreen{
//    
//    return [UIColor colorWithHexString:@"#39d9ab"];
//}
//
//+ (UIColor *)fontColorWithGreenWithAlpha:(CGFloat)alpha{
//    
//    return [UIColor colorWithHexString:@"#39d9ab" alpha:alpha];
//}
//
///**
// * 字体颜色 点赞与评论数字
// */
//+ (UIColor *)fontColorWithPrompt{
//    
//    return [UIColor colorWithHexString:@"#b1b3b2"];
//}
//
//+ (UIColor *)fontColorWithPromptWithAlpha:(CGFloat)alpha{
//    
//    return [UIColor colorWithHexString:@"#b1b3b2" alpha:alpha];
//}
//
///**
// * 字体颜色 提示辅助类
// */
//+ (UIColor *)fontColorWithHint{
//    
//    return [UIColor colorWithHexString:@"#d1d3d2"];
//}
//
//+ (UIColor *)fontColorWithHintWithAlpha:(CGFloat)alpha{
//    
//    return [UIColor colorWithHexString:@"#d1d3d2" alpha:alpha];
//}
//
///**
// * 环境颜色 导航栏图标
// */
//+ (UIColor *)EnvironmentColorWithTitleBG{
//    
//    return [UIColor colorWithHexString:@"#cacccb"];
//}
//
//+ (UIColor *)EnvironmentColorWithTitleBGWithAlpha:(CGFloat)alpha{
//    
//    return [UIColor colorWithHexString:@"#cacccb" alpha:alpha];
//}
//
///**
// * 环境颜色 上下导航栏分割颜色
// */
//+ (UIColor *)EnvironmentColorWithTitledividebg{
//    
//    return [UIColor colorWithHexString:@"#d8dad9"];
//}
//
//
//+ (UIColor *)EnvironmentColorWithTitledividebgWithAlpha:(CGFloat)alpha{
//    
//    return [UIColor colorWithHexString:@"#d8dad9" alpha:alpha];
//}
//
///**
// * 环境颜色 卡片内分割线
// */
//+ (UIColor *)EnvironmentColorWithContentdividebg{
//    
//    return [UIColor colorWithHexString:@"#eaeaea"];
//}
//
//+ (UIColor *)EnvironmentColorWithContentdividebgWithAlpha:(CGFloat)alpha{
//    
//    return [UIColor colorWithHexString:@"#eaeaea" alpha:alpha];
//}
//
///**
// * 环境颜色 二级导航,搜索背景
// */
//+ (UIColor *)EnvironmentColorWithPromptbg{
//    
//    return [UIColor colorWithHexString:@"#f8f9f9"];
//}
//
//+ (UIColor *)EnvironmentColorWithPromptbgWithAlpha:(CGFloat)alpha{
//    
//    return [UIColor colorWithHexString:@"#f8f9f9" alpha:alpha];
//}
//
///**
// * 环境颜色 内容背景色
// */
//+ (UIColor *)EnvironmentColorWithContentbg{
//    
//    return [UIColor colorWithHexString:@"#f6f8f7"];
//}
//
//+ (UIColor *)EnvironmentColorWithContentbgWithAlpha:(CGFloat)alpha{
//    
//    return [UIColor colorWithHexString:@"#f6f8f7" alpha:alpha];
//}

@end
