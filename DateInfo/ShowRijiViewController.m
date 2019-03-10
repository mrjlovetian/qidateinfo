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
#import <MWPhotoBrowser.h>
#import "TestViewController.h"
#import "RijiCell.h"

@interface ShowRijiViewController () <UITableViewDelegate, UITableViewDataSource, MWPhotoBrowserDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSources;
@property (nonatomic, copy)NSArray *photos;

@end

@implementation ShowRijiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataSources = [NSMutableArray arrayWithCapacity:1];
    
    [self.view addSubview:self.tableView];
    NSString *file = [[FileManager shareManager] readFileNameForKey:@"mrjdata"];
    [self.dataSources addObjectsFromArray:[NSArray yy_modelArrayWithClass:RiJiInfo.class json:file]];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    RiJiInfo *info = self.dataSources[indexPath.section];
    RiJiModel *model = info.datas[indexPath.row];
    return [RijiCell hetightForModel:model];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];
    RiJiInfo *info = [self.dataSources objectAtIndex:indexPath.section];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    RiJiInfo *info = self.dataSources[section];
    return info.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identif = @"cell";
    RijiCell *cell = [tableView dequeueReusableCellWithIdentifier:identif];
    if (!cell) {
        cell = [[RijiCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:identif];
    }
    RiJiInfo *info =  [_dataSources objectAtIndex:indexPath.section];
    RiJiModel *model = info.datas[indexPath.row];
    cell.rijiModel = model;
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
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

@end
