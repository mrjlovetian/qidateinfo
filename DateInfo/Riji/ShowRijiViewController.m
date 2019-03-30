//
//  ShowRijiViewController.m
//  DateInfo
//
//  Created by MRJ on 2019/3/9.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import "ShowRijiViewController.h"
#import "FileManager.h"
#import "RiJiModel.h"
#import "MWPhotoBrowser.h"
#import "TestViewController.h"
#import "RijiCell.h"
#import "RijiDetailViewController.h"

@interface ShowRijiViewController () <UITableViewDelegate, UITableViewDataSource, MWPhotoBrowserDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, copy)NSArray *photos;

@end

@implementation ShowRijiViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.lee_theme.LeeAddBackgroundColor(@"main", MAINCOLOR);
    [self.view addSubview:self.tableView];
    self.tableView.estimatedRowHeight = 150;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView reloadData];
}

#pragma mark method
- (void)checkImageIndex:(NSInteger)index rijiModel:(RiJiModel *)model {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];
    for (NSString *imageUrl in model.images) {
        NSURL *url = [[NSURL alloc] initFileURLWithPath:[NSString stringWithFormat:@"%@%@", [[FileManager shareManager] getMianPath] , imageUrl]];
        MWPhoto *photo = [[MWPhoto alloc] initWithURL:url];
        [arr addObject:photo];
    }
    self.photos = arr;
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    [browser setCurrentPhotoIndex:index];
    [self.navigationController pushViewController:browser animated:YES];
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
    RiJiDay *rijiDay = self.rijiDayArr[indexPath.section];
    RiJiModel *model = rijiDay.datas[indexPath.row];
    RijiDetailViewController *vc = [RijiDetailViewController new];
    vc.rijiModel = model;
    [self.navigationController pushViewController:vc animated:YES];
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
    cell.lee_theme.LeeAddBackgroundColor(@"main", MAINCOLOR);
    cell.imageCallback = ^(NSInteger index) {
        [self checkImageIndex:index rijiModel:rijiModel];
    };
    return cell;
}

#pragma mark UI
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - NavBarHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 100;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.lee_theme.LeeAddBackgroundColor(@"main", MAINCOLOR);
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

@end
