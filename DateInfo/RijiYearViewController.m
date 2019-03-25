//
//  RijiYearViewController.m
//  DateInfo
//
//  Created by MRJ on 2019/3/25.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import "RijiYearViewController.h"
#import "RijiManager.h"
#import "RiModel/RiJiModel.h"
#import "ShowRijiViewController.h"

@interface RijiYearViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *arr;

@end

@implementation RijiYearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    RiJiDay *info = self.rijiDayArr[indexPath.section];
//    RiJiModel *model = info.datas[indexPath.row];
//    return [RijiCell hetightForModel:model];
    return 48.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RiJiYear *rijiYear = [RijiManager shareRijiManager].rijiArr[indexPath.section];
    RiJiMonth *rijiMonth = rijiYear.datas[indexPath.row];
    ShowRijiViewController *vc = [ShowRijiViewController new];
    vc.rijiDayArr = rijiMonth.datas;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [RijiManager shareRijiManager].rijiArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    RiJiYear *rijiYear = [RijiManager shareRijiManager].rijiArr[section];
    return rijiYear.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identif = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identif];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:identif];
    }
    RiJiYear *rijiYear = [RijiManager shareRijiManager].rijiArr[indexPath.section];
    RiJiMonth *rijiMonth = rijiYear.datas[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@月", rijiMonth.month];
    return cell;
}

#pragma mark UI
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 100;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.backgroundColor = FlatMint;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

@end
