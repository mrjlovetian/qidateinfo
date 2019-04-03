//
//  AboutViewController.m
//  DateInfo
//
//  Created by MRJ on 2019/3/30.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@property (nonatomic, strong)UILabel *aboutLab;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于";
    self.view.lee_theme.LeeAddBackgroundColor(@"main", MAINCOLOR);
    
    self.aboutLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 60, ScreenWidth - 30, 0)];
    self.aboutLab.numberOfLines = 0;
    self.aboutLab.textColor = [UIColor whiteColor];
    self.aboutLab.font = [UIFont systemFontOfSize:15.0];
    [self.view addSubview:self.aboutLab];
    
    NSString *aboutStr = @"软件著作为个人所有，如您在使用本软件的过程中遇到任何问题或者您需要向作者提供建议，均可联系作者，我会认真思考您对本软件提出的意见或建议！\n\n软件提供基本的日历功能，提供当年的节假日信息，仅供参考。您可以在本软件中添加当天的日志信息，包括日志标题，日志内容以及不超与6张的图片信息。添加之后的日志信息会在日志功能页显示，你可选择性查看所添加的日志，在日志详情业内可以日志删除，日志不会上传到互联网，删除操作数据是不可恢复的。\n 联系作者：mrjlovetian@gmail.com";
    self.aboutLab.text = aboutStr;
    CGRect rect = [aboutStr boundingRectWithSize:CGSizeMake( ScreenWidth - 30, 0) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]} context:nil];
    self.aboutLab.height = rect.size.height;
    // Do any additional setup after loading the view.
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
