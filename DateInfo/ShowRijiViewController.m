//
//  ShowRijiViewController.m
//  DateInfo
//
//  Created by MRJ on 2019/3/9.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import "ShowRijiViewController.h"
#import "FileManager/FileManager.h"
#import "RiModel/RiJiModel.h"
#import "MWPhotoBrowser.h"
#import "TestViewController.h"
#import "RijiCell.h"

@interface ShowRijiViewController () <UITableViewDelegate, UITableViewDataSource, MWPhotoBrowserDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, copy)NSArray *photos;

@end

@implementation ShowRijiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"014D41"];
    [self.view addSubview:self.tableView];
    self.tableView.estimatedRowHeight = 150;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView reloadData];
    
}

#pragma mark MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    return [self.photos objectAtIndex:index];
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.rijiDayArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    RiJiDay *rijiDay = self.rijiDayArr[indexPath.section];
    RiJiModel *model = rijiDay.datas[indexPath.row];
    return [RijiCell hetightForModel:model];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    RiJiDay *rijiDay = self.rijiDayArr[section];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    titleLab.text = [NSString stringWithFormat:@"\t%@", rijiDay.date];
    titleLab.backgroundColor = [UIColor whiteColor];
    return titleLab;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];
    RiJiDay *info = [self.rijiDayArr objectAtIndex:indexPath.section];
    RiJiModel *model = [info.datas objectAtIndex:indexPath.row];
    for (NSString *imageUrl in model.images) {
        NSURL *url = [[NSURL alloc] initFileURLWithPath:[NSString stringWithFormat:@"%@%@", [[FileManager shareManager] getMianPath] , imageUrl]];
        MWPhoto *photo = [[MWPhoto alloc] initWithURL:url];
        [arr addObject:photo];
    }
    self.photos = arr;
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    [self.navigationController pushViewController:browser animated:YES];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    RiJiDay *rijiDay = self.rijiDayArr[section];
    return rijiDay.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identif = @"cell";
    RijiCell *cell = [tableView dequeueReusableCellWithIdentifier:identif];
    if (!cell) {
        cell = [[RijiCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:identif];
    }
    RiJiDay *rijiDay =  [self.rijiDayArr objectAtIndex:indexPath.section];
    RiJiModel *rijiModel = rijiDay.datas[indexPath.row];
    cell.rijiModel = rijiModel;
    cell.backgroundColor = [UIColor colorWithHexString:@"014D41"];
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
        _tableView.backgroundColor = [UIColor colorWithHexString:@"014D41"];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

@end
