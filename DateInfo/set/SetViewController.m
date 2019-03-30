//
//  SetViewController.m
//  SystemInfo
//
//  Created by MRJ on 2019/3/13.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import "SetViewController.h"
#import "ParallaxHeaderView.h"
#import "ShouWenzhanViewController.h"
#import "AboutViewController.h"

@interface SetViewController () <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, copy)NSArray *dataSource;
@property (nonatomic, strong)ParallaxHeaderView *headerView;

@end

@implementation SetViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"014D41"];
    self.title = @"设置";
    self.dataSource = @[@"随机散文", @"意见反馈", @"关于", @"当前版本"];
    [self.view addSubview:self.tableView];
    UIImage *image = [UIImage imageNamed:@"02.JPG"];
    self.headerView = [ParallaxHeaderView parallaxHeaderViewWithImage:image forSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 200)];
    self.tableView.tableHeaderView = self.headerView;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        ShouWenzhanViewController *vc = [ShouWenzhanViewController new];
        [self presentViewController:vc animated:YES completion:^{
            
        }];
    } else if (indexPath.row == 1) {
        
    } else if (indexPath.row == 2) {
        AboutViewController *vc = [AboutViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *idtif = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idtif];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:idtif];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.lee_theme.LeeAddBackgroundColor(@"main", MAINCOLOR);
    cell.textLabel.textColor = [UIColor whiteColor];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, cell.frame.size.height - 0.5, ScreenWidth - 30, 0.4)];
    lineView.backgroundColor = [UIColor whiteColor];
    [cell addSubview:lineView];
    if (indexPath.row == 3) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        UILabel *versionLab = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2.0, 0, ScreenWidth/2.0 - 30, cell.frame.size.height)];
        versionLab.text = [UIApplication sharedApplication].appVersion;
        versionLab.textColor = [UIColor whiteColor];
        versionLab.font = [UIFont systemFontOfSize:14.0];
        versionLab.textAlignment = NSTextAlignmentRight;
        [cell addSubview:versionLab];
    }
    return cell;
}

#pragma mark UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView) {
        // pass the current offset of the UITableView so that the ParallaxHeaderView layouts the subViews.
        [(ParallaxHeaderView *)self.tableView.tableHeaderView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
    }
}

#pragma mark get
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.lee_theme.LeeAddBackgroundColor(@"main", MAINCOLOR);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

@end
