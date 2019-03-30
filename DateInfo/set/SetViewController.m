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

@interface SetViewController () <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, copy)NSArray *dataSource;
@property (nonatomic, strong)ParallaxHeaderView *headerView;

@end

@implementation SetViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.delegate = self;
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
    self.dataSource = @[@"主题切换", @"字体切换", @"意见反馈", @"关于"];
    [self.view addSubview:self.tableView];
    UIImage *image = [UIImage imageNamed:@"04.PNG"];
    self.headerView = [ParallaxHeaderView parallaxHeaderViewWithImage:image forSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 200)];
    self.tableView.tableHeaderView = self.headerView;
    // Do any additional setup after loading the view.
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ShouWenzhanViewController *vc = [ShouWenzhanViewController new];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
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
    cell.backgroundColor = [UIColor colorWithHexString:@"014D41"];
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
        _tableView.backgroundColor = [UIColor colorWithHexString:@"014D41"];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

@end
