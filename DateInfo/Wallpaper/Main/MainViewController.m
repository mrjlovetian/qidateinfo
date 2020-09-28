//
//  MainViewController.m
//  XWallpaper
//
//  Created by MRJ on 2020/7/31.
//  Copyright © 2020 MRJ. All rights reserved.
//

#import "MainViewController.h"
#import "HXHttpNetwork.h"
#import "WallCatageModel.h"
#import "WallpaperCell.h"
#import "YBImageBrowser.h"
#import "WallPaperHeaderView.h"
#import "MoreWallViewController.h"
#import "StoryMakeImageEditorViewController.h"
#import "MoreWallViewController.h"

@interface MainViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *imageSource;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.lee_theme.LeeAddBackgroundColor(@"main", MAINCOLOR);
    // Do any additional setup after loading the view.
    self.title = @"XWallPaper";
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

       // Set the label text.
    hud.label.text = NSLocalizedString(@"加载中...", @"请求");
    [HXHttpNetwork httpRequestDataByGet:@"https://claritywallpaper.com/clarity/api/special/queryByCatalogAllPlus?catalogIds=ff8080816a525a11016a53ac8b441a80" params:nil success:^(id responseObject) {
        NSArray *arr = [NSArray yy_modelArrayWithClass:WallCatageModel.class json:responseObject[@"data"]];
        self.dataSource = [arr reverseObjectEnumerator].allObjects;
        
        __block NSInteger requesetCount = 0;
        for (WallCatageModel *model in self.dataSource) {
            NSString *imageDataUrl = [NSString stringWithFormat:@"https://claritywallpaper.com/clarity/api/special/%@", model.catagateId];
            [HXHttpNetwork httpRequestDataByGet:imageDataUrl params:nil success:^(id responseObject) {
                requesetCount += 1;
                ImageListModel *imageListModel = [ImageListModel yy_modelWithJSON:responseObject[@"data"]];
                for (WallCatageModel *tmode in self.dataSource) {
                    if ([tmode.catagateId isEqualToString:imageListModel.catagateId]) {
                        tmode.dataSources = imageListModel.pictureList;
                    }
                }
                if (requesetCount == self.dataSource.count) {
                    [self.collectionView reloadData];
                }
            } failure:^(NSError *error) {
                
            }];
        }
        [hud hideAnimated:YES];
    } failure:^(NSError *error) {
        NSLog(@"error = %@", error.localizedDescription);
        [hud hideAnimated:YES];
    }];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)menuClick {
//    [[SideMenuController shared] presentedIn:self animated:YES];
}

#pragma mark UICollectionViewDelegate
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WallCatageModel *model = self.dataSource[indexPath.section];
    NSMutableArray *datas = [NSMutableArray array];
    [model.dataSources enumerateObjectsUsingBlock:^(ImageModel *imageModel, NSUInteger idx, BOOL * _Nonnull stop) {
       
       WallpaperCell *cell = (WallpaperCell *)[collectionView cellForItemAtIndexPath:indexPath];
       YBIBImageData *data = [YBIBImageData new];
       data.projectiveView = cell.iconImageView;
       // 这里放的是原图地址（实际业务中请按需关联）
       NSString *thumUrl = [NSString stringWithFormat:@"http://wallpapers.claritywallpaper.com/%@?imageMogr2/auto-orient/thumbnail/750x/blur/1x0/quality/100", imageModel.url];
       NSString *imageUrl = [NSString stringWithFormat:@"http://wallpapers.claritywallpaper.com/%@", imageModel.url];
       data.imageURL = [NSURL URLWithString:imageUrl];
       data.thumbURL = [NSURL URLWithString:thumUrl];

       [datas addObject:data];
       
    }];
    
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = datas;
    browser.currentPage = indexPath.row;
    [browser show];
    
    YBIBSheetAction *action = [YBIBSheetAction actionWithName:@"Edit" action:^(id<YBIBDataProtocol>  _Nonnull data) {
        StoryMakeImageEditorViewController *storyMakerVc = [[StoryMakeImageEditorViewController alloc] initWithImage:((YBIBImageData *)data).originImage];
        storyMakerVc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:storyMakerVc animated:YES completion:nil];
        [browser hide];
    }];
    [browser.defaultToolViewHandler.sheetView.actions addObject:action];
}

#pragma mark UICollectionViewDataSource

//组头

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

   WallPaperHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
    WallCatageModel *model = self.dataSource[indexPath.section];
    headerView.titleLab.text = model.headlineEn;
   headerView.backgroundColor = MAINCOLOR;
    headerView.wallMoreBlock = ^(NSIndexPath * aindexPath) {
        MoreWallViewController *vc = [MoreWallViewController new];
        vc.dataSource = model.dataSources;
        vc.title = model.headlineEn;
        [self.navigationController pushViewController:vc animated:YES];
    };

   return headerView;
}

//当然这个设置不能忘记

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize size={ScreenWidth,35};
   return size;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.count;
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    WallCatageModel *model = (WallCatageModel *)self.dataSource[section];
    return model.pictureCount > 3?3:model.pictureCount;//self.dataSource.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WallpaperCell *cell = (WallpaperCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    WallCatageModel *model = self.dataSource[indexPath.section];
    cell.imageModel = model.dataSources[indexPath.row];
    
    return cell;
}

#pragma mark UICollectionViewDelegateFlowLayout

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
//        layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 100);
        //该方法也可以设置itemSize
        CGFloat itemSizeWidth = (ScreenWidth - 50)/3.0;
        layout.itemSize =CGSizeMake(itemSizeWidth, itemSizeWidth * (4/3.0));
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) collectionViewLayout:layout];
//        _collectionView.backgroundColor = HexRGB(0xe5e5e5);
        [_collectionView registerClass:[WallpaperCell class] forCellWithReuseIdentifier:@"cellId"];
        _collectionView.lee_theme.LeeAddBackgroundColor(@"main", MAINCOLOR);
        //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
//        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
        
        _collectionView.collectionViewLayout = layout;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[WallPaperHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    }
    return _collectionView;
}


@end
