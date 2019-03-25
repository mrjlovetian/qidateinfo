//
//  RijiMonthViewController.m
//  DateInfo
//
//  Created by MRJ on 2019/3/25.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import "RijiMonthViewController.h"

@interface RijiMonthViewController ()

@end

@implementation RijiMonthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

#pragma mark UITableViewDelegate

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 48.0;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    RiJiYear *rijiYear = [RijiManager shareRijiManager].rijiArr[indexPath.section];
//    RiJiMonth *rijiMonth = rijiYear.datas[indexPath.row];
//    ShowRijiViewController *vc = [ShowRijiViewController new];
//    [self.navigationController pushViewController:vc animated:YES];
//}
//
//#pragma mark UITableViewDataSource
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return self.rijiMonthArr.count;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    RiJiMonth *rijiMonth = self.rijiMonthArr[section];
//    return rijiMonth.datas.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *identif = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identif];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:identif];
//    }
//    RiJiMonth *rijiMonth = self.rijiMonthArr[indexPath.section];
//    RiJiDay *rijiDay = rijiYear.datas[indexPath.row];
//    cell.textLabel.text = [NSString stringWithFormat:@"%@", rijiDay.date];
//    return cell;
//}
//
//#pragma mark UI
//- (UITableView *)tableView {
//    if (!_tableView) {
//        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        _tableView.estimatedRowHeight = 100;
//        _tableView.rowHeight = UITableViewAutomaticDimension;
//        _tableView.backgroundColor = FlatMint;
//        _tableView.tableFooterView = [UIView new];
//    }
//    return _tableView;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
