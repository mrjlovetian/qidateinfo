//
//  RijiDetailViewController.m
//  DateInfo
//
//  Created by MRJ on 2019/3/30.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import "RijiDetailViewController.h"
#import "RiJiModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "FileManager.h"
#import "RijiManager.h"
#import <YBImageBrowser.h>

@interface RijiDetailViewController ()

@property (nonatomic, strong)UILabel *timeLab;
@property (nonatomic, strong)YYLabel *contentLab;
@property (nonatomic, strong)UIScrollView *mainView;
@property (nonatomic, copy)NSArray *photos;

@end

@implementation RijiDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(0, 0, 50, 40);
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteRiji) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:deleteBtn];
    self.navigationItem.rightBarButtonItem = item;
    
    self.view.lee_theme.LeeAddBackgroundColor(@"main", MAINCOLOR);
    [self.view addSubview:self.mainView];
    [self.mainView addSubview:self.timeLab];
    [self.mainView addSubview:self.contentLab];
    self.title = self.rijiModel.title;
    self.timeLab.text = self.rijiModel.day;
    YYTextContainer *contentContarer = [YYTextContainer new];
    //限制宽度
    contentContarer.size = CGSizeMake(ScreenWidth - 20, CGFLOAT_MAX);
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:self.rijiModel.content];
    att.yy_font = [UIFont systemFontOfSize:17.0];
    att.yy_color = [UIColor whiteColor];
    att.yy_alignment = NSTextAlignmentJustified;
    //设置行间距
    att.yy_lineSpacing = 5;
    
    YYTextLayout *textLayout = [YYTextLayout layoutWithContainer:contentContarer text:att];
    self.contentLab.textLayout = textLayout;
    self.contentLab.height = textLayout.textBoundingSize.height;
    
    
    CGFloat iamgeWidth = (ScreenSzie.width - 40)/3.0;
    CGFloat bottom = self.contentLab.bottom + 20;
    self.rijiModel.images = [self.rijiModel.imageUrls componentsSeparatedByString:@"#"];
    for (int i = 0; i < _rijiModel.images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.frame = CGRectMake(10 + (i%3)*(iamgeWidth + 5), _contentLab.bottom + 5 + (i/3)*(iamgeWidth + 5), iamgeWidth, iamgeWidth);
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            [self checkImageIndex:i rijiModel:self.rijiModel];
        }]];
        [imageView sd_setImageWithURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@%@", [[FileManager shareManager] getMianPath], _rijiModel.images[i]]]];
        [self.mainView addSubview:imageView];
        if (i == _rijiModel.images.count - 1) {
            bottom = imageView.bottom + 20;
        }
    }
    self.mainView.contentSize = CGSizeMake(0, bottom);
    // Do any additional setup after loading the view.
}

#pragma mark method
- (void)checkImageIndex:(NSInteger)index rijiModel:(RiJiModel *)model {
    
    NSMutableArray *datas = [NSMutableArray arrayWithCapacity:1];
    for (NSString *imageUrl in model.images) {
        YBIBImageData *data = [YBIBImageData new];
        data.imageURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@%@", [[FileManager shareManager] getMianPath], imageUrl]];
        [datas addObject:data];
    }
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = datas;
    browser.currentPage = index;
    [browser show];
}

- (void)deleteRiji {
    [RiJiModel deleteModel:self.rijiModel];
}

#pragma mark get
- (UIScrollView *)mainView {
    if (!_mainView) {
        _mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - NavBarHeight)];
    }
    return _mainView;
}

- (UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, ScreenWidth - 20, 15)];
        _timeLab.textColor = [UIColor whiteColor];
        _timeLab.textAlignment = NSTextAlignmentRight;
        _timeLab.font = [UIFont systemFontOfSize:14.0];
    }
    return _timeLab;
}

- (YYLabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [[YYLabel alloc] initWithFrame:CGRectMake(_timeLab.left, _timeLab.bottom + 10, _timeLab.width, 0)];
    }
    return _contentLab;
}

@end
