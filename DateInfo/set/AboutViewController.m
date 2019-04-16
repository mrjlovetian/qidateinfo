//
//  AboutViewController.m
//  DateInfo
//
//  Created by MRJ on 2019/3/30.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import "AboutViewController.h"
#import <YYText/YYText.h>

@interface AboutViewController ()

@property (nonatomic, strong)YYLabel *aboutLab;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于";
    self.view.lee_theme.LeeAddBackgroundColor(@"main", MAINCOLOR);
    
    self.aboutLab = [[YYLabel alloc] initWithFrame:CGRectMake(15, NavBarHeight + 20, ScreenWidth - 30, 0)];
    self.aboutLab.numberOfLines = 0;
    self.aboutLab.textColor = [UIColor whiteColor];
    self.aboutLab.font = [UIFont systemFontOfSize:15.0];
    [self.view addSubview:self.aboutLab];
    
    NSString *aboutStr = @"软件著作为个人所有，如您在使用本软件的过程中遇到任何问题或者您需要向作者提供建议，均可联系作者，我会认真思考您对本软件提出的意见或建议！\n\n软件提供基本的日历功能，提供当年的节假日信息，仅供参考。您可以在本软件中添加当天的日志信息，包括日志标题，日志内容以及不超与6张的图片信息。添加之后的日志信息会在日志功能页显示，你可选择性查看所添加的日志，在日志详情页内可以日志删除，日志不会上传到互联网，删除操作数据是不可恢复的。\n 联系作者：1520312758@qq.com";
    YYTextContainer *container = [[YYTextContainer alloc] init];
    container.size = CGSizeMake(ScreenWidth - 30, CGFLOAT_MAX);
    YYTextLayout *textLayout = [YYTextLayout layoutWithContainer:container text:[self getAttr:aboutStr]];
    self.aboutLab.textLayout = textLayout;
    self.aboutLab.height = textLayout.textBoundingSize.height;
    
    // Do any additional setup after loading the view.
}

- (NSMutableAttributedString*)getAttr:(NSString*)attributedString {
    NSMutableAttributedString * resultAttr = [[NSMutableAttributedString alloc] initWithString:attributedString];
    //对齐方式 这里是 两边对齐
    resultAttr.yy_alignment = NSTextAlignmentJustified;
    //设置行间距
    resultAttr.yy_lineSpacing = 5;
    //设置字体大小
    resultAttr.yy_font = [UIFont systemFontOfSize:16.0];
    resultAttr.yy_color = [UIColor whiteColor];
    //可以设置某段字体的大小
    //[resultAttr yy_setFont:[UIFont boldSystemFontOfSize:CONTENT_FONT_SIZE] range:NSMakeRange(0, 3)];
    //设置字间距
    //resultAttr.yy_kern = [NSNumber numberWithFloat:1.0];
    return resultAttr;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
