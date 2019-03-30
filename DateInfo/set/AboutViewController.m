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
    
    NSString *aboutStr = @"这是一款简单的日历软件，可记录用户个人当天的私密日志，记录的日志可在日志页面下查看。\n软件名称小七日历";
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
