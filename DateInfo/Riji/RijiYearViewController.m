//
//  RijiYearViewController.m
//  DateInfo
//
//  Created by MRJ on 2019/3/25.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import "RijiYearViewController.h"
#import "RijiManager.h"
#import "RiJiModel.h"
#import "ShowRijiViewController.h"
#import "RijiSectionView.h"


@interface RijiYearViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *arr;
@property (nonatomic, strong)NSMutableArray *isExtentArr;

@end

@implementation RijiYearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"日志";
    self.navigationController.navigationBar.translucent = NO;
    
    self.isExtentArr = [[NSMutableArray alloc] initWithCapacity:1];
    for (int i = 0; i < self.arr.count; i++) {
        [self.isExtentArr addObject:@"1"];
    }
    [self.view addSubview:self.tableView];
    
    
    
    if (self.arr.count == 0) {
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您还没有记录新的日志哦！去首页添加一条吧！" preferredStyle:(UIAlertControllerStyleAlert)];
        [alertVc addAction:[UIAlertAction actionWithTitle:@"好哒" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alertVc animated:YES completion:nil];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[RijiManager shareRijiManager] reloadData];
    [self.tableView reloadData];
    
    
    
//    NSArray *array = [RiJiModel selectDataByYear:@"2020"];
    
    NSLog(@".......%@", self.arr);
}


#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RiJiYear *rijiYear = [RijiManager shareRijiManager].rijiArr[indexPath.section];
    RiJiMonth *rijiMonth = rijiYear.datas[indexPath.row];
    ShowRijiViewController *vc = [ShowRijiViewController new];
    vc.title = [NSString stringWithFormat:@"%@月", rijiMonth.month];
    vc.rijiDayArr = rijiMonth.datas;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.isExtentArr.count > 0) {
        RiJiYear *rijiYear = [RijiManager shareRijiManager].rijiArr[section];
        RijiSectionView *rijiSectionView = [[RijiSectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
        rijiSectionView.titleStr = [NSString stringWithFormat:@"%@年", rijiYear.year];
        rijiSectionView.btnState = [self.isExtentArr[section] boolValue];
        MRJWeakSelf(self);
        rijiSectionView.lefyCallback = ^(NSInteger btnState){
            if ([weakself.isExtentArr[section] isEqualToString:@"0"]) {
                //关闭 => 展开
                [weakself.isExtentArr removeObjectAtIndex:section];
                [weakself.isExtentArr insertObject:@"1" atIndex:section];
            } else {
                //展开 => 关闭
                [weakself.isExtentArr removeObjectAtIndex:section];
                [weakself.isExtentArr insertObject:@"0" atIndex:section];
            }
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
            NSRange rang = NSMakeRange(indexPath.section, 1);
            NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:rang];
            [weakself.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
            
        };
        return rijiSectionView;
    }
    return nil;
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [RijiManager shareRijiManager].rijiArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isExtentArr.count > 0) {
        if ([[self.isExtentArr objectAtIndex:section] isEqualToString:@"1"]) {
            RiJiYear *rijiYear = [RijiManager shareRijiManager].rijiArr[section];
            return rijiYear.datas.count;
        }
    }
    return 0;
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
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.lee_theme.LeeAddBackgroundColor(@"main", MAINCOLOR);;
    return cell;
}

#pragma mark UI
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 100;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.lee_theme.LeeAddBackgroundColor(@"main", MAINCOLOR);
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

@end
