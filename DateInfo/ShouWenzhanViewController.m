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

@interface ShouWenzhanViewController ()

@property (nonatomic, strong)UILabel *titleLab;
@property (nonatomic, strong)UILabel *authorLab;
@property (nonatomic, strong)YYTextView *contentView;

@property (nonatomic, strong)UIScrollView *mainView;
@property (nonatomic, assign)NSInteger index;

@end

@implementation ShouWenzhanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainView];
    [self.mainView addSubview:self.titleLab];
    [self.mainView addSubview:self.authorLab];
    [self.mainView addSubview:self.contentView];
    
    NSInteger count = [[WenzhanManager shareManager] dataSource].count - 1;
    self.index = (arc4random()%count);
    
    [self refreshData];
    
    self.mainView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
//        self.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        [UIView animateWithDuration:0.1 animations:^{
            self.index += 1;
            [self refreshData];
            [self.mainView.mj_header endRefreshing];
//            self.view.backgroundColor = [UIColor orangeColor];
        }];
    }];
    
    self.mainView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        self.view.backgroundColor = [UIColor blackColor];
        [UIView animateWithDuration:0.5 animations:^{
            self.index -= 1;
            [self refreshData];
            [self.mainView.mj_footer endRefreshing];
            self.view.backgroundColor = [UIColor purpleColor];
        }];
    }];
    
    
    // Do any additional setup after loading the view.
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
        self.contentView.text = [dic objectForKey:@"content"];
    }
    
    
    CGRect rect = [self.contentView.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, 0) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]} context:nil];
    self.contentView.height = rect.size.height;
    self.mainView.contentSize = CGSizeMake(0, self.contentView.bottom);
}

#pragma mark method

- (NSDictionary *)getWenzhan {
    
    if (self.index > [WenzhanManager shareManager].dataSource.count) {
        self.index = 0;
    }
    return [[[WenzhanManager shareManager] dataSource] objectAtIndex:self.index];
}

#pragma mark get
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, ScreenWidth - 20, 30)];
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (UILabel *)authorLab {
    if (!_authorLab) {
        _authorLab = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLab.left, self.titleLab.bottom + 10, self.titleLab.width, self.titleLab.height)];
        _authorLab.textAlignment = NSTextAlignmentCenter;
    }
    return _authorLab;
}

- (YYTextView *)contentView {
    if (!_contentView) {
        _contentView = [[YYTextView alloc] initWithFrame:CGRectMake(self.titleLab.left, self.authorLab.bottom + 10, self.titleLab.width, 0)];
        _contentView.editable = NO;
        _contentView.font = [UIFont systemFontOfSize:17.0];
    }
    return _contentView;
}

- (UIScrollView *)mainView {
    if (!_mainView) {
        _mainView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//        _mainView.backgroundColor = [UIColor cyanColor];
    }
    return _mainView;
}

@end
