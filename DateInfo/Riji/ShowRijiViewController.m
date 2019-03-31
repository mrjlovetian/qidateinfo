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
#import "RijiSectionView.h"
#import "DateInfo-Swift.h"

@interface ShowRijiViewController () <UITableViewDelegate, UITableViewDataSource, MWPhotoBrowserDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, copy)NSArray *photos;
@property (nonatomic, strong)NSMutableArray *isExtentArr;

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
    StarsOverlay *starsOverlay = [[StarsOverlay alloc] init];
    starsOverlay.layer.frame = self.view.bounds;
    starsOverlay.emitter.emitterPosition = CGPointMake(ScreenWidth/2.0, (ScreenHeight - NavBarHeight - 49)/2.0);
    starsOverlay.emitter.emitterSize = CGSizeMake(ScreenWidth/4.0, (ScreenHeight - NavBarHeight - 49)/4.0);
    [self.view.layer addSublayer:starsOverlay.layer];
    
    self.isExtentArr = [NSMutableArray arrayWithCapacity:1];
    for (int i = 0; i < self.rijiDayArr.count; i++) {
        [self.isExtentArr addObject:@"1"];
    }
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
    RijiSectionView *rijiSectionView = [[RijiSectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    rijiSectionView.titleStr = [NSString stringWithFormat:@"%@", rijiDay.date];
    rijiSectionView.btnState = [self.isExtentArr[section] boolValue];
    MRJWeakSelf(self);
    rijiSectionView.lefyCallback = ^(NSInteger btnState){
        if ([weakself.isExtentArr[section] isEqualToString:@"0"]) {
            //关闭 => 展开
            [weakself.isExtentArr removeObjectAtIndex:section];
            [weakself.isExtentArr insertObject:@"1" atIndex:section];
        }else{
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
    if ([[self.isExtentArr objectAtIndex:section] isEqualToString:@"1"]) {
        RiJiDay *rijiDay = self.rijiDayArr[section];
        return rijiDay.datas.count;
    }
    return 0;
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
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.lee_theme.LeeAddBackgroundColor(@"main", MAINCOLOR);
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

@end
