//
//  ShouWenzhanViewController.m
//  DateInfo
//
//  Created by MRJ on 2019/3/29.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import "ShouWenzhanViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "WenzhanManager.h"
#import <Photos/Photos.h>

@interface ShouWenzhanViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong)UILabel *titleLab;
@property (nonatomic, strong)UILabel *authorLab;
@property (nonatomic, strong)YYLabel *contentLab;

@property (nonatomic, strong)UIScrollView *mainView;
@property (nonatomic, assign)NSInteger index;
@property (nonatomic, strong)UIButton *backBtn;

@end

@implementation ShouWenzhanViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.lee_theme.LeeAddBackgroundColor(@"main", MAINCOLOR);
    [self.view addSubview:self.mainView];
    [self.mainView addSubview:self.titleLab];
    [self.mainView addSubview:self.authorLab];
    [self.mainView addSubview:self.contentLab];
    [self.view addSubview:self.backBtn];
    
    
    NSInteger count = [[WenzhanManager shareManager] dataSource].count - 1;
    self.index = (arc4random()%count);
    
    [self refreshData];
    
    MJWeakSelf;
    self.mainView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf.mainView scrollToTop];
        [UIView animateWithDuration:0.1 animations:^{
            weakSelf.index += 1;
            [weakSelf refreshData];
            [weakSelf.mainView.mj_header endRefreshing];
        }];
    }];
    
    self.mainView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.index -= 1;
            [weakSelf refreshData];
            [weakSelf.mainView.mj_footer endRefreshing];
            [weakSelf.mainView scrollToTop];
        }];
    }];
}



#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint translatedPoint = [scrollView.panGestureRecognizer translationInView:scrollView];
    if(translatedPoint.y < 0) {
        [UIView animateWithDuration:0.3 animations:^{
            self.backBtn.hidden = YES;
        }];
    }
    
    if(translatedPoint.y > 0) {
        [UIView animateWithDuration:0.1 animations:^{
            self.backBtn.hidden = NO;
        }];
    }
}

#pragma mark method

- (NSDictionary *)getWenzhan {
    if (self.index > [WenzhanManager shareManager].dataSource.count) {
        self.index = 0;
    }
    return [[[WenzhanManager shareManager] dataSource] objectAtIndex:self.index];
}

- (void)goBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)refreshData {
    NSDictionary *dic = [self getWenzhan];
    if ([dic objectForKey:@"title"]) {
        self.titleLab.text = [dic objectForKey:@"title"];
    }
    if ([dic objectForKey:@"author"]) {
        self.authorLab.text = [dic objectForKey:@"author"];
    }
    if ([dic objectForKey:@"content"]) {
        
        NSString *content = [dic objectForKey:@"content"];
        YYTextContainer *contentContarer = [YYTextContainer new];
        //限制宽度
        contentContarer.size = CGSizeMake(ScreenWidth - 20, CGFLOAT_MAX);
        NSMutableAttributedString  *contentAttr = [self getAttr:content];
        YYTextLayout *contentLayout = [YYTextLayout layoutWithContainer:contentContarer text:contentAttr];
        self.contentLab.textLayout = contentLayout;
        //        self.contentLab.text = [dic objectForKey:@"content"];
        CGFloat contentHeight = contentLayout.textBoundingSize.height;
        self.contentLab.height = contentHeight;
        self.mainView.contentSize = CGSizeMake(0, self.contentLab.bottom);
    }
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

#pragma mark get
- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _backBtn.frame = CGRectMake(20, NavBarHeight + 10, 40, 40);
//        [_backBtn setTitle:@"退出" forState:UIControlStateNormal];
        [_backBtn setImage:[[UIImage imageNamed:@"exit"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:UIControlStateNormal];
        _backBtn.layer.cornerRadius = 4.0;
        _backBtn.clipsToBounds = YES;
        _backBtn.lee_theme.LeeAddBackgroundColor(@"main", [UIColor colorWithHexString:@"ff801a"]);
        [_backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, ScreenWidth - 20, 30)];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.font = [UIFont systemFontOfSize:18.0];
    }
    return _titleLab;
}

- (UILabel *)authorLab {
    if (!_authorLab) {
        _authorLab = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLab.left, self.titleLab.bottom + 10, self.titleLab.width, self.titleLab.height)];
        _authorLab.textAlignment = NSTextAlignmentCenter;
        _authorLab.font = [UIFont systemFontOfSize:16.0];
        _authorLab.textColor = [UIColor whiteColor];
    }
    return _authorLab;
}

- (YYLabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [[YYLabel alloc] initWithFrame:CGRectMake(self.titleLab.left, self.authorLab.bottom + 10, self.titleLab.width, 0)];
        _contentLab.displaysAsynchronously = YES;
        _contentLab.numberOfLines = 0;
        _contentLab.textColor = [UIColor whiteColor];
    }
    return _contentLab;
}

- (UIScrollView *)mainView {
    if (!_mainView) {
        _mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, StatusBarHeight, ScreenWidth, ScreenHeight - StatusBarHeight)];
        _mainView.delegate = self;
    }
    return _mainView;
}

@end
